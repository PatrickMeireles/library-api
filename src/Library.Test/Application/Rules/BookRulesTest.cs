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
public class BookRulesTest : BaseTest
{
    private Mock<IAuthorEntityFrameworkRepository> _mockIAuthorEntityFrameworkRepository;
    private Mock<IBookEntityFrameworkRepository> _mockIBookEntityFrameworkRepository;
    private Mock<NotificationContext> _mockNotificationContext;
    private BookRules _rules;

    [TestInitialize]
    public void Init() 
    {        
        _mockIAuthorEntityFrameworkRepository = new();
        _mockIBookEntityFrameworkRepository = new();
        _mockNotificationContext = new();

        _rules = new(_mockIBookEntityFrameworkRepository.Object, _mockIAuthorEntityFrameworkRepository.Object, _mockNotificationContext.Object);
    }

    [TestMethod]
    public async Task Should_CreateIsValidAsync_Return_False_When_Book_Already_Exist()
    {
        var book = _fixture.Create<Book>();

        var books = _fixture.CreateMany<Book>(1).ToList();
        books.Add(book);

        _mockIBookEntityFrameworkRepository.Setup(getBooksExpression)
            .ReturnsAsync(books);

        var result = await _rules.CreateIsValidAsync(book, default);

        Assert.IsNotNull(result);
        Assert.IsFalse(result);

        _mockIBookEntityFrameworkRepository.Verify(getBooksExpression, Times.Once);
        _mockIAuthorEntityFrameworkRepository.Verify(getAuthorsExpression, Times.Never);
        _mockNotificationContext.Verify(c => c.AddNotification(It.IsAny<string>(), It.IsAny<string>()), Times.Once);
    }

    [TestMethod]
    public async Task Should_CreateIsValidAsync_Return_False_When_Not_Found_Author()
    {
        var bookAuthor = BookAuthor.Create(Guid.NewGuid(), Guid.NewGuid(), Guid.NewGuid());

        var book = _fixture.Create<Book>();
        var books = _fixture.CreateMany<Book>();

        var authors = _fixture.Build<Author>()
            .CreateMany();

        _mockIBookEntityFrameworkRepository.Setup(getBooksExpression)
            .ReturnsAsync(new List<Book>());

        _mockIAuthorEntityFrameworkRepository.Setup(getAuthorsExpression)
            .ReturnsAsync(new List<Author>());

        var result = await _rules.CreateIsValidAsync(book, default);

        Assert.IsNotNull(result);
        Assert.IsFalse(result);

        _mockIBookEntityFrameworkRepository.Verify(getBooksExpression, Times.Once);
        _mockIAuthorEntityFrameworkRepository.Verify(getAuthorsExpression, Times.Once);
        _mockNotificationContext.Verify(c => c.AddNotification(It.IsAny<string>(), It.IsAny<string>()), Times.Once);
    }

    [TestMethod]
    public async Task Should_CreateIsValidAsync_Return_True()
    {
        var author = _fixture.Build<Author>()
            .Create();

        var book = _fixture.Create<Book>();

        var bookAuthor = BookAuthor.Create(Guid.NewGuid(), book.Id, author.Id);

        book.AddAuthors(bookAuthor);

        var authors = new List<Author>(author.BookAuthors.Count);

        foreach (var item in book.BookAuthors)
            authors.Add(new Author(item.Id));

        _mockIBookEntityFrameworkRepository.Setup(getBooksExpression)
            .ReturnsAsync(new List<Book>());

        _mockIAuthorEntityFrameworkRepository.Setup(getAuthorsExpression)
            .ReturnsAsync(authors);

        var result = await _rules.CreateIsValidAsync(book, default);

        Assert.IsNotNull(result);
        Assert.IsTrue(result);

        _mockIBookEntityFrameworkRepository.Verify(getBooksExpression, Times.Once);
        _mockIAuthorEntityFrameworkRepository.Verify(getAuthorsExpression, Times.Once);
        _mockNotificationContext.Verify(c => c.AddNotification(It.IsAny<string>(), It.IsAny<string>()), Times.Never);
    }

    [TestMethod]
    public async Task Should_UpdateIsValidAsync_Return_False_When_Already_Book_With_Same_Name()
    {
        var author = _fixture.Build<Author>()
            .Create();

        var book = _fixture.Create<Book>();

        var bookAuthor = BookAuthor.Create(Guid.NewGuid(), book.Id, author.Id);

        book.AddAuthors(bookAuthor);

        _mockIBookEntityFrameworkRepository.Setup(getBooksExpression)
            .ReturnsAsync(new[] { book });

        var result = await _rules.UpdateIsValidAsync(book, default);

        Assert.IsNotNull(result);
        Assert.IsFalse(result);

        _mockIBookEntityFrameworkRepository.Verify(getBooksExpression, Times.Once);
        _mockIAuthorEntityFrameworkRepository.Verify(getAuthorsExpression, Times.Never);
        _mockNotificationContext.Verify(c => c.AddNotification(It.IsAny<string>(), It.IsAny<string>()), Times.Once);
    }

    [TestMethod]
    public async Task Should_UpdateIsValidAsync_Return_False_When_Not_Found_Author()
    {
        var author = _fixture.Build<Author>()
            .Create();

        var book = _fixture.Create<Book>();

        var bookAuthor = BookAuthor.Create(Guid.NewGuid(), book.Id, author.Id);

        book.AddAuthors(bookAuthor);

        _mockIBookEntityFrameworkRepository.Setup(getBooksExpression)
            .ReturnsAsync(new List<Book>());

        _mockIAuthorEntityFrameworkRepository.Setup(getAuthorsExpression)
            .ReturnsAsync(new List<Author>());

        var result = await _rules.UpdateIsValidAsync(book, default);

        Assert.IsNotNull(result);
        Assert.IsFalse(result);

        _mockIBookEntityFrameworkRepository.Verify(getBooksExpression, Times.Once);
        _mockIAuthorEntityFrameworkRepository.Verify(getAuthorsExpression, Times.Once);
        _mockNotificationContext.Verify(c => c.AddNotification(It.IsAny<string>(), It.IsAny<string>()), Times.Once);
    }

    [TestMethod]
    public async Task Should_UpdateIsValidAsync_Return_True()
    {
        var author = _fixture.Build<Author>()
           .Create();

        var book = _fixture.Create<Book>();

        var bookAuthor = BookAuthor.Create(Guid.NewGuid(), book.Id, author.Id);

        book.AddAuthors(bookAuthor);

        var authors = new List<Author>(author.BookAuthors.Count);

        foreach (var item in book.BookAuthors)
            authors.Add(new Author(item.Id));

        _mockIBookEntityFrameworkRepository.Setup(getBooksExpression)
            .ReturnsAsync(new List<Book>());

        _mockIAuthorEntityFrameworkRepository.Setup(getAuthorsExpression)
            .ReturnsAsync(authors);

        var result = await _rules.UpdateIsValidAsync(book, default);

        Assert.IsNotNull(result);
        Assert.IsTrue(result);

        _mockIBookEntityFrameworkRepository.Verify(getBooksExpression, Times.Once);
        _mockIAuthorEntityFrameworkRepository.Verify(getAuthorsExpression, Times.Once);
        _mockNotificationContext.Verify(c => c.AddNotification(It.IsAny<string>(), It.IsAny<string>()), Times.Never);
    }

    private readonly static Expression<Func<IBookEntityFrameworkRepository, Task<IEnumerable<Book>>>> getBooksExpression = c
            => c.Get(It.IsAny<Expression<Func<Book, bool>>>(), It.IsAny<int>(), It.IsAny<int>(), It.IsAny<CancellationToken>());

    private readonly static Expression<Func<IAuthorEntityFrameworkRepository, Task<IEnumerable<Author>>>> getAuthorsExpression = c
            => c.Get(It.IsAny<Expression<Func<Author, bool>>>(), It.IsAny<int>(), It.IsAny<int>(), It.IsAny<CancellationToken>());
}
