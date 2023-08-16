using Library.Data.Cache;
using Library.Data.Repository.Mongo.Interface;
using Library.Domain.Constants;
using Library.Domain.Message.Book;
using Mapster;
using MassTransit;

namespace Library.Infrastructure.Worker.Consumer.Book;

public class CreateBookConsumer : IConsumer<CreateBookMessage>
{
    private readonly IBookMongoRepository _bookMongoRepository;
    private readonly ICacheService _cacheService;

    public CreateBookConsumer(IBookMongoRepository bookMongoRepository, ICacheService cacheService)
    {
        _bookMongoRepository = bookMongoRepository;
        _cacheService = cacheService;
    }

    public async Task Consume(ConsumeContext<CreateBookMessage> context)
    {
        var param = context.Message.Adapt<Domain.Model.Book>();

        await _bookMongoRepository.AddOrUpdate(param, context.CancellationToken);

        var key = $"{CachePrefix.BookCachePrefix}-{param.Id}";

        await _cacheService.SetAsync(key, param, context.CancellationToken);
    }
}
