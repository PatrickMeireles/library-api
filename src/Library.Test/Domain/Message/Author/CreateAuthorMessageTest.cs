using AutoFixture;
using Library.Domain.Message.Author;

namespace Library.Test.Domain.Message.Author;

[TestClass]
public class CreateAuthorMessageTest
{
    private readonly Fixture _fixture = new();

    [TestMethod]
    public void Should_Create_Message()
    {
        var param = _fixture.Create<CreateAuthorMessage>();

        var message = new CreateAuthorMessage()
        {
            Biography = param.Biography,
            CreatedAt = param.CreatedAt,
            DateOfBirth = param.DateOfBirth,
            Id = param.Id,
            Name = param.Name,
            UpdatedAt = param.UpdatedAt
        };

        Assert.IsNotNull(message);
        Assert.AreEqual(param.Biography, message.Biography);
        Assert.AreEqual(param.CreatedAt, message.CreatedAt);
        Assert.AreEqual(param.DateOfBirth, message.DateOfBirth);
        Assert.AreEqual(param.Id, message.Id);
        Assert.AreEqual(param.Name, message.Name);
        Assert.AreEqual(param.UpdatedAt, message.UpdatedAt);
    }

}
