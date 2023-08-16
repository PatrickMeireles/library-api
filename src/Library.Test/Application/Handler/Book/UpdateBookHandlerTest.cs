using AutoFixture;
using Library.Application.Handler.Book;
using Library.Application.Mapper;
using Library.Application.Notification;
using Library.Application.Rules;
using Library.Data.Repository.EntityFramework.Interface;
using Library.Domain.Command.Book;
using Library.Infrastructure.Data.EF;
using Library.Infrastructure.Event.Base;
using Library.Test.Helper;
using Microsoft.Extensions.DependencyInjection;
using Moq;
using System.Linq.Expressions;

namespace Library.Test.Application.Handler.Book;

[TestClass]
public class UpdateBookHandlerTest : BaseTest
{
    private Mock<EntityFrameworkContext> _mockContext;
    private Mock<DomainHandler> _mockDomainHandler;
    private Mock<NotificationContext> _mockNotificationContext;
    private Mock<IBookEntityFrameworkRepository> _mockRepository;
    private Mock<BookRules> _mockBookRules;
    private UpdateBookHandler _handler;

    [TestInitialize]
    public void Init()
    {
        _mockContext = new();
        _mockDomainHandler = new();
        _mockNotificationContext = new();
        _mockRepository = new();
        _mockBookRules = new(null, null, null);

        _handler = new(_mockContext.Object, _mockDomainHandler.Object, _mockNotificationContext.Object, _mockRepository.Object, _mockBookRules.Object);
        MappingConfiguration.RegisterMappings(new ServiceCollection());
    }

    [TestMethod]
    public async Task Should_Return_False_When_Not_Found_Book()
    {
        var request = _fixture.Create<UpdateBookCommand>();

        var result = await _handler.Handle(request, default);

        Assert.IsNotNull(result);
        Assert.IsFalse(result.Success);

        _mockRepository.Verify(repositoryGetByIdExpression, Times.Once);
        _mockBookRules.Verify(BookRulesExpression, Times.Never);
        _mockContext.Verify(contextCommitExpression, Times.Never);
    }

    [TestMethod]
    public async Task Should_Return_False_When_Rules_Is_False()
    {
        var request = _fixture.Create<UpdateBookCommand>();

        var mockBook = _fixture.Create<Library.Domain.Model.Book>();

        _mockRepository.Setup(repositoryGetByIdExpression).ReturnsAsync(mockBook);

        _mockBookRules.Setup(BookRulesExpression).ReturnsAsync(false);

        var result = await _handler.Handle(request, default);

        Assert.IsNotNull(result);
        Assert.IsFalse(result.Success);

        _mockRepository.Verify(repositoryGetByIdExpression, Times.Once);
        _mockBookRules.Verify(BookRulesExpression, Times.Once);
        _mockContext.Verify(contextCommitExpression, Times.Never);
    }

    [TestMethod]
    public async Task Should_Return_False_When_Commit_Is_False()
    {
        var request = _fixture.Create<UpdateBookCommand>();

        var mockBook = _fixture.Create<Library.Domain.Model.Book>();

        _mockRepository.Setup(repositoryGetByIdExpression).ReturnsAsync(mockBook);

        _mockBookRules.Setup(BookRulesExpression).ReturnsAsync(true);

        _mockContext.Setup(contextCommitExpression).ReturnsAsync(false);

        var result = await _handler.Handle(request, default);

        Assert.IsNotNull(result);
        Assert.IsFalse(result.Success);

        _mockRepository.Verify(repositoryGetByIdExpression, Times.Once);
        _mockBookRules.Verify(BookRulesExpression, Times.Once);
        _mockContext.Verify(contextCommitExpression, Times.Once);
    }

    [TestMethod]
    public async Task Should_Return_True()
    {
        var request = _fixture.Create<UpdateBookCommand>();

        var mockBook = _fixture.Create<Library.Domain.Model.Book>();

        _mockRepository.Setup(repositoryGetByIdExpression).ReturnsAsync(mockBook);

        _mockBookRules.Setup(BookRulesExpression).ReturnsAsync(true);

        _mockContext.Setup(contextCommitExpression).ReturnsAsync(true);

        var result = await _handler.Handle(request, default);

        Assert.IsNotNull(result);
        Assert.IsTrue(result.Success);

        _mockRepository.Verify(repositoryGetByIdExpression, Times.Once);
        _mockBookRules.Verify(BookRulesExpression, Times.Once);
        _mockContext.Verify(contextCommitExpression, Times.Once);
    }

    private readonly Expression<Func<IBookEntityFrameworkRepository, Task<Library.Domain.Model.Book>>> repositoryGetByIdExpression = c =>
            c.GetById(It.IsAny<Guid>(), It.IsAny<CancellationToken>());

    private readonly Expression<Func<BookRules, Task<bool>>> BookRulesExpression = c =>
            c.UpdateIsValidAsync(It.IsAny<Library.Domain.Model.Book>(), It.IsAny<CancellationToken>());

    private readonly Expression<Func<EntityFrameworkContext, Task<bool>>> contextCommitExpression = c =>
            c.CommitAsync(It.IsAny<CancellationToken>());
}
