using Library.Data.Cache;
using Library.Data.Repository.Mongo.Interface;
using Library.Domain.Message.Author;
using Library.Infrastructure.Worker.Consumer.Author;
using MassTransit;
using Moq;
using System.Linq.Expressions;

namespace Library.Test.Infrastructure.Worker.Consumer.Author;

[TestClass]
public class CreateAuthorConsumerTest
{
    private CreateAuthorConsumer _consumer;
    private Mock<IAuthorMongoRepository> _repository;
    private Mock<ICacheService> _mockCacheService;
    private ConsumeContext<CreateAuthorMessage> _consumeContext;

    [TestInitialize]
    public void Init()
    {
        _consumeContext = Mock.Of<ConsumeContext<CreateAuthorMessage>>(_ => _.Message == new CreateAuthorMessage());
        _mockCacheService = new();
        _repository = new();
        _consumer = new(_repository.Object, _mockCacheService.Object);
    }

    [TestMethod]
    public async Task Should_Consume_Message()
    {        
        _repository.Setup(buildRepositoryExpression).Returns(Task.CompletedTask);

        _mockCacheService.Setup(SetCacheExpression).Returns(Task.CompletedTask);

        await _consumer.Consume(_consumeContext);

        _repository.Verify(buildRepositoryExpression, Times.Once);
        _mockCacheService.Verify(SetCacheExpression, Times.Once);
    }

    private readonly Expression<Func<IAuthorMongoRepository, Task>> buildRepositoryExpression = c =>
        c.AddOrUpdate(It.IsAny<Library.Domain.Model.Author>(), It.IsAny<CancellationToken>());

    private static Expression<Func<ICacheService, Task>> SetCacheExpression =>
        c => c.SetAsync(It.IsAny<string>(), It.IsAny<Library.Domain.Model.Author>(), It.IsAny<CancellationToken>());
}

