using Library.Data.Cache;
using Library.Data.Repository.Mongo.Interface;
using Library.Domain.Message.Book;
using Library.Infrastructure.Worker.Consumer.Book;
using MassTransit;
using Moq;
using System.Linq.Expressions;

namespace Library.Test.Infrastructure.Worker.Consumer.Book;

[TestClass]
public class RemoveBookConsumerTest
{
    private RemoveBookConsumer _consumer;
    private Mock<IBookMongoRepository> _repository;
    private Mock<ICacheService> _mockCacheService;
    private ConsumeContext<RemoveBookMessage> _consumeContext;

    [TestInitialize]
    public void Init()
    {
        _consumeContext = Mock.Of<ConsumeContext<RemoveBookMessage>>(_ => _.Message == new RemoveBookMessage(Guid.NewGuid()));        
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

    private readonly Expression<Func<IBookMongoRepository, Task>> buildRepositoryExpression = c =>
        c.Remove(It.IsAny<Library.Domain.Model.Book>(), It.IsAny<CancellationToken>());
    private static Expression<Func<ICacheService, Task>> RemoveCacheExpression =>
        c => c.RemoveAsync(It.IsAny<string>(), It.IsAny<CancellationToken>());
}
