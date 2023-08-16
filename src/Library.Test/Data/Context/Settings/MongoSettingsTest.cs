using AutoFixture;
using Library.Infrastructure.Data.Mongo;

namespace Library.Test.Data.Context.Settings;

[TestClass]
public class MongoSettingsTest
{
    private readonly Fixture _fixture = new();

    [TestMethod]
    public void Should_Create()
    {
        var param = _fixture.Create<MongoSettings>();

        var settings = new MongoSettings()
        {
            Connection = param.Connection,
            DatabaseName = param.DatabaseName
        };

        Assert.IsNotNull(settings);
        Assert.AreEqual(param.Connection , settings.Connection);
        Assert.AreEqual(param.DatabaseName, settings.DatabaseName);
    }
}
