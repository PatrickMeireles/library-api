using AutoFixture;
using Library.Domain.Message.Book;

namespace Library.Test.Domain.Message.Book;

[TestClass]
public class RemoveBookMessageTest
{
    private readonly Fixture _fixture = new();

    [TestMethod]
    public void Should_Create_Message()
    {
        var param = _fixture.Create<RemoveBookMessage>();

        var message = new RemoveBookMessage(param.Id);

        Assert.IsNotNull(message);
        Assert.AreEqual(param.Id, message.Id);
    }
}
