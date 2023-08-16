using Library.Data.Cache;
using Library.Data.Repository.Mongo.Interface;
using Library.Domain.Message.Author;
using Library.Infrastructure.Worker.Consumer.Author;
using MassTransit;
using Moq;
using System.Linq.Expressions;

namespace Library.Test.Infrastructure.Worker.Consumer.Author;

[TestClass]
public class RemoveAuthorConsumerTest
{
    private RemoveAuthorConsumer _consumer;
    private Mock<IAuthorMongoRepository> _repository;
    private Mock<ICacheService> _mockCacheService;
    private ConsumeContext<RemoveAuthorMessage> _consumeContext;

    [TestInitialize]
    public void Init()
    {
        _consumeContext = Mock.Of<ConsumeContext<RemoveAuthorMessage>>(_ => _.Message == new RemoveAuthorMessage(Guid.NewGuid()));
        _repository = new();
        _mockCacheService = new();
        _consumer = new(_repository.Object, _mockCacheService.Object);
    }

    [TestMethod]
    public async Task Should_Consume_Message()
    {
        _repository.Setup(buildRepositoryExpression).Returns(Task.CompletedTask);
        _mockCacheService.Setup(RemoveCacheExpression).Returns(Task.CompletedTask);

        await _consumer.Consume(_consumeContext);

        _repository.Verify(buildRepositoryExpression, Times.Once);
        _mockCacheService.Verify(RemoveCacheExpression, Times.Once);
    }

    private readonly Expression<Func<IAuthorMongoRepository, Task>> buildRepositoryExpression = c =>
        c.Remove(It.IsAny<Library.Domain.Model.Author>(), It.IsAny<CancellationToken>());


    private static Expression<Func<ICacheService, Task>> RemoveCacheExpression =>
        c => c.RemoveAsync(It.IsAny<string>(),  It.IsAny<CancellationToken>());
}
