using Library.Data.Cache;
using Library.Data.Repository.Mongo.Interface;
using Library.Domain.Constants;
using Library.Domain.Message.Author;
using Mapster;
using MassTransit;

namespace Library.Infrastructure.Worker.Consumer.Author;

public class UpdateAuthorConsumer : IConsumer<UpdateAuthorMessage>
{
    private readonly IAuthorMongoRepository _repository;
    private readonly ICacheService _cacheService;

    public UpdateAuthorConsumer(IAuthorMongoRepository repository, ICacheService cacheService)
    {
        _repository = repository;
        _cacheService = cacheService;
    }

    public async Task Consume(ConsumeContext<UpdateAuthorMessage> context)
    {
        var param = context.Message.Adapt<Domain.Model.Author>();

        await _repository.AddOrUpdate(param, context.CancellationToken);

        var key = $"{CachePrefix.AuthorCachePrefix}-{param.Id}";

        await _cacheService.SetAsync(key, param, context.CancellationToken);
    }
}
