using AutoFixture;
using Library.Application.Handler.Book;
using Library.Application.Mapper;
using Library.Application.Notification;
using Library.Application.Rules;
using Library.Data.Repository.EntityFramework.Interface;
using Library.Domain.Command.Book;
using Library.Infrastructure.Data.EF;
using Library.Infrastructure.Event.Base;
using Microsoft.Extensions.DependencyInjection;
using Moq;
using System.Linq.Expressions;

namespace Library.Test.Application.Handler.Book;

[TestClass]
public class CreateBookHandlerTest
{
    private Mock<EntityFrameworkContext> _mockContext;
    private Mock<DomainHandler> _mockDomainHandler;
    private Mock<NotificationContext> _mockNotificationContext;
    private Mock<IBookEntityFrameworkRepository> _mockRepository;
    private Mock<BookRules> _mockBookRules;
    private CreateBookHandler _handler;
    private Fixture _fixture;

    [TestInitialize]
    public void Init()
    {
        _fixture = new();
        _mockContext = new();
        _mockDomainHandler = new();
        _mockNotificationContext = new();
        _mockRepository = new();
        _mockBookRules = new(null, null, null);

        _handler = new(_mockContext.Object, _mockDomainHandler.Object, _mockNotificationContext.Object, _mockRepository.Object, _mockBookRules.Object);

        MappingConfiguration.RegisterMappings(new ServiceCollection());
    }

    [TestMethod]
    public async Task Should_Handle_Return_False_When_Rules_Is_Invalid()
    {
        var request = _fixture.Create<CreateBookCommand>();

        _mockBookRules.Setup(BookRulesExpression).ReturnsAsync(false);

        var result = await _handler.Handle(request, default);

        Assert.IsNotNull(result);
        Assert.IsFalse(result.Success);

        _mockBookRules.Verify(BookRulesExpression, Times.Once);
        _mockRepository.Verify(repositoryAddExpression, Times.Never);
        _mockContext.Verify(contextCommitExpression, Times.Never);
    }

    [TestMethod]
    public async Task Should_Handle_Return_False_When_Commit_Is_False()
    {
        var request = _fixture.Create<CreateBookCommand>();

        _mockBookRules.Setup(BookRulesExpression).ReturnsAsync(true);

        _mockContext.Setup(contextCommitExpression).ReturnsAsync(false);

        var result = await _handler.Handle(request, default);

        Assert.IsNotNull(result);
        Assert.IsFalse(result.Success);

        _mockBookRules.Verify(BookRulesExpression, Times.Once);
        _mockRepository.Verify(repositoryAddExpression, Times.Once);
        _mockContext.Verify(contextCommitExpression, Times.Once);
    }

    [TestMethod]
    public async Task Should_Handle_Return_True()
    {
        var request = _fixture.Create<CreateBookCommand>();

        _mockBookRules.Setup(BookRulesExpression).ReturnsAsync(true);

        _mockContext.Setup(contextCommitExpression).ReturnsAsync(true);

        var result = await _handler.Handle(request, default);

        Assert.IsNotNull(result);
        Assert.IsTrue(result.Success);

        _mockBookRules.Verify(BookRulesExpression, Times.Once);
        _mockRepository.Verify(repositoryAddExpression, Times.Once);
        _mockContext.Verify(contextCommitExpression, Times.Once);
    }

    private readonly Expression<Func<IBookEntityFrameworkRepository, Task>> repositoryAddExpression = c =>
            c.AddOrUpdate(It.IsAny<Library.Domain.Model.Book>(), It.IsAny<CancellationToken>());

    private readonly Expression<Func<BookRules, Task<bool>>> BookRulesExpression = c =>
            c.CreateIsValidAsync(It.IsAny<Library.Domain.Model.Book>(), It.IsAny<CancellationToken>());

    private readonly Expression<Func<EntityFrameworkContext, Task<bool>>> contextCommitExpression = c =>
            c.CommitAsync(It.IsAny<CancellationToken>());
}
