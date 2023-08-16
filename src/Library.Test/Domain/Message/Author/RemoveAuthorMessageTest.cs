using AutoFixture;
using Library.Domain.Message.Author;

namespace Library.Test.Domain.Message.Author;

[TestClass]
public class RemoveAuthorMessageTest
{
    private readonly Fixture _fixture = new();

    [TestMethod]
    public void Should_Create_Message()
    {
        var param = _fixture.Create<RemoveAuthorMessage>();

        var message = new RemoveAuthorMessage(param.Id);

        Assert.IsNotNull(message);
        Assert.AreEqual(param.Id, message.Id);
    }
}
