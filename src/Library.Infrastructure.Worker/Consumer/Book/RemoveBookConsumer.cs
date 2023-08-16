using Library.Data.Cache;
using Library.Data.Repository.Mongo.Interface;
using Library.Domain.Constants;
using Library.Domain.Message.Book;
using Library.Domain.Model;
using MassTransit;

namespace Library.Infrastructure.Worker.Consumer.Book;

public class RemoveBookConsumer : IConsumer<RemoveBookMessage>
{
    private readonly IBookMongoRepository _bookMongoRepository;
    private readonly ICacheService _cacheService;

    public RemoveBookConsumer(IBookMongoRepository bookMongoRepository, ICacheService cacheService)
    {
        _bookMongoRepository = bookMongoRepository;
        _cacheService = cacheService;
    }

    public async Task Consume(ConsumeContext<RemoveBookMessage> context)
    {
        var book = new Domain.Model.Book(context.Message.Id);

        await _bookMongoRepository.Remove(book, context.CancellationToken);

        var key = $"{CachePrefix.BookCachePrefix}-{book.Id}";

        await _cacheService.RemoveAsync(key, context.CancellationToken);
    }
}
