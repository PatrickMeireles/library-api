using AutoFixture;
using Library.Application.Notification;
using Library.Application.Rules;
using Library.Data.Repository.EntityFramework.Interface;
using Library.Domain.Model;
using Library.Test.Helper;
using Moq;
using System.Linq.Expressions;

namespace Library.Test.Application.Rules;

[TestClass]
public class AuthorRulesTest : BaseTest
{
    private Mock<IAuthorEntityFrameworkRepository> _mockIAuthorEntityFrameworkRepository;
    private Mock<IBookEntityFrameworkRepository> _mockIBookEntityFrameworkRepository;
    private Mock<NotificationContext> _mockNotificationContext;
    private AuthorRules _rules;

    [TestInitialize]
    public void Init() 
    {
        _mockIAuthorEntityFrameworkRepository = new();
        _mockIBookEntityFrameworkRepository = new();
        _mockNotificationContext = new();

        _rules = new(_mockIAuthorEntityFrameworkRepository.Object, _mockIBookEntityFrameworkRepository.Object, _mockNotificationContext.Object);
    }

    [TestMethod]
    public async Task Should_CreateIsValidAsync_Return_True()
    {
        var author = new Author(Guid.NewGuid());

        var mockAuthor = Enumerable.Empty<Author>();

        Expression<Func<IAuthorEntityFrameworkRepository, Task<IEnumerable<Author>>>> expression = c
            => c.Get(It.IsAny<Expression<Func<Author, bool>>>(), It.IsAny<int>(), It.IsAny<int>(), It.IsAny<CancellationToken>());

        _mockIAuthorEntityFrameworkRepository.Setup(expression)
            .ReturnsAsync(mockAuthor);

        var result = await _rules.CreateIsValidAsync(author, default);

        Assert.IsNotNull(result);
        Assert.IsTrue(result);

        _mockIAuthorEntityFrameworkRepository.Verify(expression, Times.Once);
        _mockNotificationContext.Verify(c => c.AddNotification(It.IsAny<string>(), It.IsAny<string>()), Times.Never);
    }

    [TestMethod]
    public async Task Should_CreateIsValidAsync_Return_False()
    {
        var author = new Author(Guid.NewGuid());

        var mockAuthor = _fixture.CreateMany<Author>();

        Expression<Func<IAuthorEntityFrameworkRepository, Task<IEnumerable<Author>>>> expression = c
            => c.Get(It.IsAny<Expression<Func<Author, bool>>>(), It.IsAny<int>(), It.IsAny<int>(), It.IsAny<CancellationToken>());

        _mockIAuthorEntityFrameworkRepository.Setup(expression)
            .ReturnsAsync(mockAuthor);

        var result = await _rules.CreateIsValidAsync(author, default);

        Assert.IsNotNull(result);
        Assert.IsFalse(result);

        _mockIAuthorEntityFrameworkRepository.Verify(expression, Times.Once);
        _mockNotificationContext.Verify(c => c.AddNotification(It.IsAny<string>(), It.IsAny<string>()), Times.Once);
    }

    [TestMethod]
    public async Task Should_RemoveIsValidAsync_Return_True()
    {
        var mockBook = Enumerable.Empty<Book>();

        Expression<Func<IBookEntityFrameworkRepository, Task<IEnumerable<Book>>>> expression = c
            => c.Get(It.IsAny<Expression<Func<Book, bool>>>(), It.IsAny<int>(), It.IsAny<int>(), It.IsAny<CancellationToken>());

        _mockIBookEntityFrameworkRepository.Setup(expression)
            .ReturnsAsync(mockBook);

        var result = await _rules.RemoveIsValidAsync(Guid.NewGuid(), default);

        Assert.IsNotNull(result);
        Assert.IsTrue(result);

        _mockIBookEntityFrameworkRepository.Verify(expression, Times.Once);
        _mockNotificationContext.Verify(c => c.AddNotification(It.IsAny<string>(), It.IsAny<string>()), Times.Never);
    }

    [TestMethod]
    public async Task Should_RemoveIsValidAsync_Return_False()
    {
        var author = new Book(Guid.NewGuid());

        var mockBook = _fixture.CreateMany<Book>();

        Expression<Func<IBookEntityFrameworkRepository, Task<IEnumerable<Book>>>> expression = c
            => c.Get(It.IsAny<Expression<Func<Book, bool>>>(), It.IsAny<int>(), It.IsAny<int>(), It.IsAny<CancellationToken>());

        _mockIBookEntityFrameworkRepository.Setup(expression)
            .ReturnsAsync(mockBook);

        var result = await _rules.RemoveIsValidAsync(Guid.NewGuid(), default);

        Assert.IsNotNull(result);
        Assert.IsFalse(result);

        _mockIBookEntityFrameworkRepository.Verify(expression, Times.Once);
        _mockNotificationContext.Verify(c => c.AddNotification(It.IsAny<string>(), It.IsAny<string>()), Times.Once);
    }

    [TestMethod]
    public async Task Should_UpdateIsValidAsync_Return_True()
    {
        var author = new Author(Guid.NewGuid());

        var mockAuthor = Enumerable.Empty<Author>();

        Expression<Func<IAuthorEntityFrameworkRepository, Task<IEnumerable<Author>>>> expression = c
            => c.Get(It.IsAny<Expression<Func<Author, bool>>>(), It.IsAny<int>(), It.IsAny<int>(), It.IsAny<CancellationToken>());

        _mockIAuthorEntityFrameworkRepository.Setup(expression)
            .ReturnsAsync(mockAuthor);

        var result = await _rules.UpdateIsValidAsync(author, default);

        Assert.IsNotNull(result);
        Assert.IsTrue(result);

        _mockIAuthorEntityFrameworkRepository.Verify(expression, Times.Once);
        _mockNotificationContext.Verify(c => c.AddNotification(It.IsAny<string>(), It.IsAny<string>()), Times.Never);
    }

    [TestMethod]
    public async Task Should_UpdateIsValidAsync_Return_False()
    {
        var author = new Author(Guid.NewGuid());

        var mockAuthor = _fixture.CreateMany<Author>();

        Expression<Func<IAuthorEntityFrameworkRepository, Task<IEnumerable<Author>>>> expression = c
            => c.Get(It.IsAny<Expression<Func<Author, bool>>>(), It.IsAny<int>(), It.IsAny<int>(), It.IsAny<CancellationToken>());

        _mockIAuthorEntityFrameworkRepository.Setup(expression)
            .ReturnsAsync(mockAuthor);

        var result = await _rules.UpdateIsValidAsync(author, default);

        Assert.IsNotNull(result);
        Assert.IsFalse(result);

        _mockIAuthorEntityFrameworkRepository.Verify(expression, Times.Once);
        _mockNotificationContext.Verify(c => c.AddNotification(It.IsAny<string>(), It.IsAny<string>()), Times.Once);
    }
}

