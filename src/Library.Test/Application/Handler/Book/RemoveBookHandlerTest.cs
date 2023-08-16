using AutoFixture;
using Library.Application.Handler.Book;
using Library.Application.Notification;
using Library.Data.Repository.EntityFramework.Interface;
using Library.Domain.Command.Book;
using Library.Infrastructure.Data.EF;
using Library.Infrastructure.Event.Base;
using Library.Test.Helper;
using Moq;
using System.Linq.Expressions;

namespace Library.Test.Application.Handler.Book;

[TestClass]
public class RemoveBookHandlerTest : BaseTest
{
    private Mock<EntityFrameworkContext> _mockContext;
    private Mock<DomainHandler> _mockDomainHandler;
    private Mock<NotificationContext> _mockNotificationContext;
    private Mock<IBookEntityFrameworkRepository> _mockRepository;
    private RemoveBookHandler _handler;

    [TestInitialize]
    public void Init()
    {
        _mockContext = new();
        _mockDomainHandler = new();
        _mockNotificationContext = new();
        _mockRepository = new();

        _handler = new(_mockContext.Object, _mockDomainHandler.Object, _mockNotificationContext.Object, _mockRepository.Object);
    }

    [TestMethod]
    public async Task Should_Handle_Return_False_When_Book_Not_Exist()
    {
        var request = _fixture.Create<RemoveBookCommand>();

        var result = await _handler.Handle(request, default);

        Assert.IsNotNull(result);
        Assert.IsFalse(result.Success);

        _mockRepository.Verify(repositoryGetByIdExpression, Times.Once);
        _mockContext.Verify(contextCommitExpression, Times.Never);
    }

    [TestMethod]
    public async Task Should_Handle_Return_False_When_RemoveIsValidAsync_Is_False()
    {
        var request = _fixture.Create<RemoveBookCommand>();

        var result = await _handler.Handle(request, default);

        Assert.IsNotNull(result);
        Assert.IsFalse(result.Success);

        _mockRepository.Verify(repositoryGetByIdExpression, Times.Once);
        _mockContext.Verify(contextCommitExpression, Times.Never);
    }

    [TestMethod]
    public async Task Should_Handle_Return_False_When_CommitAsync_Is_False()
    {
        var request = _fixture.Create<RemoveBookCommand>();

        var Book = _fixture.Create<Library.Domain.Model.Book>();

        _mockRepository.Setup(repositoryGetByIdExpression).ReturnsAsync(Book);

        _mockContext.Setup(contextCommitExpression).ReturnsAsync(false);

        var result = await _handler.Handle(request, default);

        Assert.IsNotNull(result);
        Assert.IsFalse(result.Success);

        _mockRepository.Verify(repositoryGetByIdExpression, Times.Once);
        _mockContext.Verify(contextCommitExpression, Times.Once);
    }

    [TestMethod]
    public async Task Should_Handle_Return_True()
    {
        var request = _fixture.Create<RemoveBookCommand>();

        var Book = _fixture.Create<Library.Domain.Model.Book>();

        _mockRepository.Setup(repositoryGetByIdExpression).ReturnsAsync(Book);

        _mockContext.Setup(contextCommitExpression).ReturnsAsync(true);

        var result = await _handler.Handle(request, default);

        Assert.IsNotNull(result);
        Assert.IsTrue(result.Success);

        _mockRepository.Verify(repositoryGetByIdExpression, Times.Once);
        _mockContext.Verify(contextCommitExpression, Times.Once);
    }

    private readonly Expression<Func<IBookEntityFrameworkRepository, Task<Library.Domain.Model.Book>>> repositoryGetByIdExpression = c =>
            c.GetById(It.IsAny<Guid>(), It.IsAny<CancellationToken>());

    private readonly Expression<Func<EntityFrameworkContext, Task<bool>>> contextCommitExpression = c =>
            c.CommitAsync(It.IsAny<CancellationToken>());
}
