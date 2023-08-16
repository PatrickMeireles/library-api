using AutoFixture;
using Library.Application.Handler.Author;
using Library.Application.Mapper;
using Library.Application.Notification;
using Library.Application.Rules;
using Library.Data.Repository.EntityFramework.Interface;
using Library.Domain.Command.Author;
using Library.Infrastructure.Data.EF;
using Library.Infrastructure.Event.Base;
using Microsoft.Extensions.DependencyInjection;
using Moq;
using System.Linq.Expressions;

namespace Library.Test.Application.Handler.Author;

[TestClass]
public class CreateBookHandlerTest
{
    private Mock<EntityFrameworkContext> _mockContext;
    private Mock<DomainHandler> _mockDomainHandler;
    private Mock<NotificationContext> _mockNotificationContext;
    private Mock<IAuthorEntityFrameworkRepository> _mockRepository;
    private Mock<AuthorRules> _mockAuthorRules;
    private CreateAuthorHandler _handler;
    private Fixture _fixture;

    [TestInitialize]
    public void Init()
    {
        _fixture = new();
        _mockContext = new();
        _mockDomainHandler = new();
        _mockNotificationContext = new();
        _mockRepository = new();
        _mockAuthorRules = new(null, null, null);

        _handler = new(_mockContext.Object, _mockDomainHandler.Object, _mockNotificationContext.Object, _mockRepository.Object, _mockAuthorRules.Object);

        MappingConfiguration.RegisterMappings(new ServiceCollection());
    }

    [TestMethod]
    public async Task Should_Handle_Return_False_When_Rules_Is_Invalid()
    {
        var request = _fixture.Create<CreateAuthorCommand>();

        _mockAuthorRules.Setup(authorRulesExpression).ReturnsAsync(false);

        var result = await _handler.Handle(request, default);

        Assert.IsNotNull(result);
        Assert.IsFalse(result.Success);

        _mockAuthorRules.Verify(authorRulesExpression, Times.Once);
        _mockRepository.Verify(repositoryAddExpression, Times.Never);
        _mockContext.Verify(contextCommitExpression, Times.Never);
    }

    [TestMethod]
    public async Task Should_Handle_Return_False_When_Commit_Is_False()
    {
        var request = _fixture.Create<CreateAuthorCommand>();

        _mockAuthorRules.Setup(authorRulesExpression).ReturnsAsync(true);

        _mockContext.Setup(contextCommitExpression).ReturnsAsync(false);

        var result = await _handler.Handle(request, default);

        Assert.IsNotNull(result);
        Assert.IsFalse(result.Success);

        _mockAuthorRules.Verify(authorRulesExpression, Times.Once);
        _mockRepository.Verify(repositoryAddExpression, Times.Once);
        _mockContext.Verify(contextCommitExpression, Times.Once);
    }

    [TestMethod]
    public async Task Should_Handle_Return_True()
    {
        var request = _fixture.Create<CreateAuthorCommand>();

        _mockAuthorRules.Setup(authorRulesExpression).ReturnsAsync(true);

        _mockContext.Setup(contextCommitExpression).ReturnsAsync(true);

        var result = await _handler.Handle(request, default);

        Assert.IsNotNull(result);
        Assert.IsTrue(result.Success);

        _mockAuthorRules.Verify(authorRulesExpression, Times.Once);
        _mockRepository.Verify(repositoryAddExpression, Times.Once);
        _mockContext.Verify(contextCommitExpression, Times.Once);
    }

    private readonly Expression<Func<IAuthorEntityFrameworkRepository, Task>> repositoryAddExpression = c =>
            c.AddOrUpdate(It.IsAny<Library.Domain.Model.Author>(), It.IsAny<CancellationToken>());

    private readonly Expression<Func<AuthorRules, Task<bool>>> authorRulesExpression = c =>
            c.CreateIsValidAsync(It.IsAny<Library.Domain.Model.Author>(), It.IsAny<CancellationToken>());

    private readonly Expression<Func<EntityFrameworkContext, Task<bool>>> contextCommitExpression = c =>
            c.CommitAsync(It.IsAny<CancellationToken>());
}
