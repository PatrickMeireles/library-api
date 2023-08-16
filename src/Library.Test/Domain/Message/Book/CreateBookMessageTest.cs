using AutoFixture;
using Library.Domain.Message.Book;

namespace Library.Test.Domain.Message.Book;

[TestClass]
public class CreateBookMessageTest
{
    private readonly Fixture _fixture = new();

    [TestMethod]
    public void Should_Create_Message()
    {
        var param = _fixture.Create<CreateBookMessage>();

        var message = new CreateBookMessage()
        {
            BookAuthors = param.BookAuthors,
            BookType = param.BookType,
            CreatedAt = param.CreatedAt,
            Description = param.Description,
            Genre = param.Genre,
            Id = param.Id,
            Pages = param.Pages,
            Title = param.Title,
            UpdatedAt = param.UpdatedAt,
            YearPublication = param.YearPublication
        };

        Assert.IsNotNull(message);
        Assert.AreEqual(param.BookAuthors, message.BookAuthors);
        Assert.AreEqual(param.BookType, message.BookType);
        Assert.AreEqual(param.CreatedAt, message.CreatedAt);
        Assert.AreEqual(param.Description, message.Description);
        Assert.AreEqual(param.Genre, message.Genre);
        Assert.AreEqual(param.Id, message.Id);
        Assert.AreEqual(param.Pages, message.Pages);
        Assert.AreEqual(param.Title, message.Title);
        Assert.AreEqual(param.UpdatedAt, message.UpdatedAt);
        Assert.AreEqual(param.YearPublication, message.YearPublication);
    }
}
