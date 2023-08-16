using AutoFixture;
using Library.Test.Helper;

namespace Library.Test.Domain.Model;

[TestClass]
public class BookTest : BaseTest
{

    [TestMethod]
    public void Should_Create_Book()
    {
        var fakeBook = _fixture.Build<Library.Domain.Model.Book>()
                               .Create();

        var book = Library.Domain.Model.Book.Create(fakeBook.Id,
            fakeBook.Title, fakeBook.Description, fakeBook.YearPublication, fakeBook.Pages, fakeBook.BookType, fakeBook.Genre,
            fakeBook.BookAuthors.Select(c => c.AuthorId).ToArray());

        Assert.IsNotNull(book);
        Assert.AreEqual(fakeBook.Id, book.Id);
        Assert.AreEqual(fakeBook.Title, book.Title);
        Assert.AreEqual(fakeBook.Description, book.Description);
        Assert.AreEqual(fakeBook.YearPublication, book.YearPublication);
        Assert.AreEqual(fakeBook.Pages, book.Pages);
        Assert.AreEqual(fakeBook.BookType, book.BookType);
        Assert.AreEqual(fakeBook.Genre, book.Genre);
        Assert.AreEqual(fakeBook.BookAuthors.Count, book.BookAuthors.Count);
    }

    [TestMethod]
    public void Should_Update_Book()
    {
        var fakeBook = _fixture.Build<Library.Domain.Model.Book>()
                               .Create();

        var book = Library.Domain.Model.Book.Create(fakeBook.Id,
            fakeBook.Title, fakeBook.Description, fakeBook.YearPublication, fakeBook.Pages, fakeBook.BookType, fakeBook.Genre,
            fakeBook.BookAuthors.Select(c => c.AuthorId).ToArray());

        Assert.IsNotNull(book);
        Assert.AreEqual(fakeBook.Id, book.Id);
        Assert.AreEqual(fakeBook.Title, book.Title);
        Assert.AreEqual(fakeBook.Description, book.Description);
        Assert.AreEqual(fakeBook.YearPublication, book.YearPublication);
        Assert.AreEqual(fakeBook.Pages, book.Pages);
        Assert.AreEqual(fakeBook.BookType, book.BookType);
        Assert.AreEqual(fakeBook.Genre, book.Genre);
        Assert.AreEqual(fakeBook.BookAuthors.Count, book.BookAuthors.Count);
    }

    [TestMethod]
    [DataRow(1)]
    [DataRow(3)]
    [DataRow(7)]
    public void Should_Add_Authors(int count)
    {
        var book = _fixture.Build<Library.Domain.Model.Book>()
                           .Create();

        var originalCount = book.BookAuthors.Count;
        var quantity = originalCount + count;

        var authors = _fixture.CreateMany<Guid>(count);

        foreach(var author in authors)
            book.AddAuthors(Library.Domain.Model.BookAuthor.Create(Guid.NewGuid(), book.Id, author));

        Assert.AreEqual(quantity, book.BookAuthors.Count);
    }
}
