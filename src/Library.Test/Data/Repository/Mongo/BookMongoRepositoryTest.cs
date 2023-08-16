using Library.Data.Repository.Mongo;
using Library.Infrastructure.Data.Mongo;
using Library.Infrastructure.Event.Base;
using MediatR;
using Microsoft.Extensions.Options;
using Moq;

namespace Library.Test.Data.Repository.Mongo;

[TestClass]
public class BookMongoRepositoryTest
{
    [TestMethod]
    public void Should_Create_Repository()
    {
        var mockDomainHandler = new Mock<DomainHandler>();
        var mockMediatr = new Mock<IMediator>();

        var mongoSettings = new MongoSettings()
        {
            Connection = "mongodb://mongodb0.example.com:27017",
            DatabaseName = "db"
        };

        IOptions<MongoSettings> someOptions = Options.Create(mongoSettings);

        var mockMongoDbContext = new Mock<MongoDbContext>(someOptions, mockDomainHandler.Object, mockMediatr.Object);

        var result = new BookMongoRepository(mockMongoDbContext.Object);

        Assert.IsNotNull(result);
    }
}
