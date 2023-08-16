using AutoFixture;

namespace Library.Test.Domain.Model;

[TestClass]
public class AuthorTest
{
    private Fixture _fixture;

    [TestInitialize]
    public void Init() =>
        _fixture = new Fixture();


    [TestMethod]
    public void Should_Create_Author()
    {
        var fakeAuthor = _fixture.Create<Library.Domain.Model.Author>();

        var author = Library.Domain.Model.Author.Create(fakeAuthor.Id, fakeAuthor.Name, fakeAuthor.Biography, fakeAuthor.DateOfBirth);

        Assert.IsNotNull(author);
        Assert.AreEqual(fakeAuthor.Id, author.Id);
        Assert.AreEqual(fakeAuthor.Name, author.Name);
        Assert.AreEqual(fakeAuthor.Biography, author.Biography);
        Assert.AreEqual(fakeAuthor.DateOfBirth, author.DateOfBirth);
    }

    [TestMethod]
    public void Should_Update_Author()
    {
        var fakeAuthor = _fixture.Create<Library.Domain.Model.Author>();

        var author = Library.Domain.Model.Author.Update(fakeAuthor.Id, fakeAuthor.Name, fakeAuthor.Biography, fakeAuthor.DateOfBirth);

        Assert.IsNotNull(author);
        Assert.AreEqual(fakeAuthor.Id, author.Id);
        Assert.AreEqual(fakeAuthor.Name, author.Name);
        Assert.AreEqual(fakeAuthor.Biography, author.Biography);
        Assert.AreEqual(fakeAuthor.DateOfBirth, author.DateOfBirth);
    }
}
