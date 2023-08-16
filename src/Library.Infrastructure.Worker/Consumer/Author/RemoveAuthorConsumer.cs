using Library.Data.Cache;
using Library.Data.Repository.Mongo.Interface;
using Library.Domain.Constants;
using Library.Domain.Message.Author;
using MassTransit;

namespace Library.Infrastructure.Worker.Consumer.Author;

public class RemoveAuthorConsumer : IConsumer<RemoveAuthorMessage>
{
    private readonly IAuthorMongoRepository _repository;
    private readonly ICacheService _cacheService;

    public RemoveAuthorConsumer(IAuthorMongoRepository repository, ICacheService cacheService)
    {
        _repository = repository;
        _cacheService = cacheService;
    }

    public async Task Consume(ConsumeContext<RemoveAuthorMessage> context)
    {
        var author = new Domain.Model.Author(context.Message.Id);

        await _repository.Remove(author, context.CancellationToken);

        var key = $"{CachePrefix.AuthorCachePrefix}-{author.Id}";

        await _cacheService.RemoveAsync(key, context.CancellationToken);
    }
}
