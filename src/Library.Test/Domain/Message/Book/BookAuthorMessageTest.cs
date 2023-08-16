using AutoFixture;
using Library.Domain.Message.Book;

namespace Library.Test.Domain.Message.Book;

[TestClass]
public class BookAuthorMessageTest
{
    private readonly Fixture _fixture = new();

    [TestMethod]
    public void Should_Create()
    {
        var param = _fixture.Create<BookAuthorMessage>();

        var message = new BookAuthorMessage()
        {
            AuthorId = param.AuthorId,
            Id = param.Id,
            BookId = param.BookId
        };

        Assert.IsNotNull(message);
        Assert.AreEqual(param.Id, message.Id);
        Assert.AreEqual(param.AuthorId, message.AuthorId);
        Assert.AreEqual(param.BookId, message.BookId);
    }
}
