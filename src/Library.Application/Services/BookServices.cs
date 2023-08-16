using Library.Application.Services.Interface;
using Library.Data.Cache;
using Library.Data.Repository.Mongo.Interface;
using Library.Domain.Command.Book;
using Library.Domain.Constants;
using Library.Domain.DTO.Base;
using Library.Domain.DTO.Book;
using Library.Domain.Model;
using Mapster;
using MediatR;
using System.Linq.Expressions;

namespace Library.Application.Services;

public class BookServices : IBookServices
{
    private readonly IMediator _mediator;
    private readonly IBookMongoRepository _bookMongoRepository;
    private readonly ICacheService _cacheService;
    public BookServices(IMediator mediator, IBookMongoRepository bookMongoRepository, ICacheService cacheService)
    {
        _mediator = mediator;
        _bookMongoRepository = bookMongoRepository;
        _cacheService = cacheService;
    }

    public async Task<Guid?> Create(BookRequestDto param, CancellationToken cancellationToken = default)
    {
        var data = param.Adapt<CreateBookCommand>();

        var result = await _mediator.Send(data, cancellationToken);

        if (!result.Success)
            return null;

        return data.Id;
    }

    public ValueTask DisposeAsync()
    {
        GC.SuppressFinalize(this);
        return ValueTask.CompletedTask;
    }

    public async Task<BookResponseDto?> GetById(Guid id, CancellationToken cancellationToken = default)
    {
        var key = $"{CachePrefix.BookCachePrefix}-{id}";

        var fromCache = await _cacheService.GetAsync<Book>(key, cancellationToken);

        if (fromCache is not null)
            return fromCache.Adapt<BookResponseDto>();

        var data = await _bookMongoRepository.GetById(id, cancellationToken);

        if (data is null)
            return await Task.FromResult<BookResponseDto?>(null);

        await _cacheService.SetAsync(key, data, cancellationToken);

        return data.Adapt<BookResponseDto>();
    }

    public async Task<IEnumerable<BookResponseDto>> GetAll(PaginateRequest paginate, BookQueryParamDto param, CancellationToken cancellationToken = default)
    {
        Expression<Func<Book, bool>> expression = c => param != null &&
                (string.IsNullOrWhiteSpace(param.Title) || c.Title.Contains(param.Title) &&
                (param.YearPublication <= 0 || c.YearPublication == param.YearPublication) &&
                (param.BookType < 0 || (int)c.BookType == param.BookType) &&
                (param.Genre < 0 || (int)c.Genre == param.Genre) &&

                (!param.Id.Any() || param.Id.Contains(c.Id))) &&
                (!param.AuthorId.Any() || param.AuthorId.Intersect(c.BookAuthors.Select(c => c.AuthorId)).Any());

        var data = await _bookMongoRepository.Get(expression, paginate.Page, paginate.Size, cancellationToken);

        if (data is null)
            return await Task.FromResult(Array.Empty<BookResponseDto>());

        return data.Select(c => c.Adapt<BookResponseDto>());
    }

    public async Task<bool> Remove(Guid id, CancellationToken cancellationToken = default)
    {
        var data = new RemoveBookCommand(id);

        var result = await _mediator.Send(data, cancellationToken);
                
        return result.Success;

    }

    public async Task<bool> Update(Guid id, BookRequestDto param, CancellationToken cancellationToken = default)
    {
        var data = param.Adapt<UpdateBookCommand>();
        data.Id = id;

        var result = await _mediator.Send(data, cancellationToken);

        return result.Success;
    }
}
