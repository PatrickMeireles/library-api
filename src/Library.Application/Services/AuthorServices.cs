using Library.Application.Services.Interface;
using Library.Data.Cache;
using Library.Data.Repository.Mongo.Interface;
using Library.Domain.Command.Author;
using Library.Domain.Constants;
using Library.Domain.DTO.Author;
using Library.Domain.DTO.Base;
using Library.Domain.Model;
using Mapster;
using MediatR;
using System.Linq.Expressions;

namespace Library.Application.Services;

public class AuthorServices : IAuthorServices
{
    private readonly IMediator _mediator;
    private readonly IAuthorMongoRepository _authorMongoRepository;
    private readonly ICacheService _cacheService;

    public AuthorServices(IMediator mediator, IAuthorMongoRepository authorMongoRepository, ICacheService cacheService)
    {
        _mediator = mediator;
        _authorMongoRepository = authorMongoRepository;
        _cacheService = cacheService;
    }

    public async Task<Guid?> Create(AuthorRequestDto param, CancellationToken cancellationToken = default)
    {
        var data = param.Adapt<CreateAuthorCommand>();

        var result = await _mediator.Send(data, cancellationToken);

        if (!result.Success)
            return await Task.FromResult<Guid?>(null);

        return data.Id;
    }

    public async Task<AuthorResponseDto?> GetById(Guid id, CancellationToken cancellationToken = default)
    {
        var key = $"{CachePrefix.AuthorCachePrefix}-{id}";

        var fromCache = await _cacheService.GetAsync<Author>(key, cancellationToken);

        if(fromCache is not null)
            return fromCache.Adapt<AuthorResponseDto>();

        var data = await _authorMongoRepository.GetById(id, cancellationToken);

        if (data is null)
            return await Task.FromResult<AuthorResponseDto?>(null);

        await _cacheService.SetAsync(key, data, cancellationToken);

        var result = data.Adapt<AuthorResponseDto>();

        return result;
    }

    public async Task<IEnumerable<AuthorResponseDto>> GetAll(PaginateRequest paginate, AuthorQueryParamDto param, CancellationToken cancellationToken = default)
    {
        Expression<Func<Author, bool>> expression = c => param != null &&
                (string.IsNullOrWhiteSpace(param.Name) || c.Name.Contains(param.Name) &&
                (!param.Id.Any() || param.Id.Contains(c.Id)));

        var data = await _authorMongoRepository.Get(expression, paginate.Page, paginate.Size, cancellationToken);

        if (data is null)
            return await Task.FromResult(Array.Empty<AuthorResponseDto>());

        return data.Select(c => c.Adapt<AuthorResponseDto>());
    }


    public async Task<bool> Remove(Guid id, CancellationToken cancellationToken = default)
    {
        var data = new RemoveAuthorCommand(id);

        var result = await _mediator.Send(data, cancellationToken);

        return result.Success;
    }

    public async Task<bool> Update(Guid id, AuthorRequestDto param, CancellationToken cancellationToken = default)
    {
        var data = param.Adapt<UpdateAuthorCommand>();
        data.Id = id;

        var result = await _mediator.Send(data, cancellationToken);

        return result.Success;
    }


    public ValueTask DisposeAsync()
    {
        GC.SuppressFinalize(this);
        return ValueTask.CompletedTask;
    }
}
