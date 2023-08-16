using Library.Data.Cache;
using Library.Data.Repository.Mongo.Interface;
using Library.Domain.Constants;
using Library.Domain.Message.Author;
using Mapster;
using MassTransit;

namespace Library.Infrastructure.Worker.Consumer.Author;

public class CreateAuthorConsumer : IConsumer<CreateAuthorMessage>
{
    private readonly IAuthorMongoRepository _repository;
    private readonly ICacheService _cacheService;

    public CreateAuthorConsumer(IAuthorMongoRepository repository, ICacheService cacheService)
    {
        _repository = repository;
        _cacheService = cacheService;
    }

    public async Task Consume(ConsumeContext<CreateAuthorMessage> context)
    {
        var param = context.Message.Adapt<Domain.Model.Author>();

        await _repository.AddOrUpdate(param, context.CancellationToken);

        var key = $"{CachePrefix.AuthorCachePrefix}-{param.Id}";

        await _cacheService.SetAsync(key, param, context.CancellationToken);
    }
}
