using Library.Domain.DTO.Author;
using Library.Domain.DTO.Base;

namespace Library.Application.Services.Interface;

public interface IAuthorServices : IAsyncDisposable
{
    Task<Guid?> Create(AuthorRequestDto param, CancellationToken cancellationToken = default);
    Task<AuthorResponseDto?> GetById(Guid id, CancellationToken cancellationToken = default);
    Task<IEnumerable<AuthorResponseDto>> GetAll(PaginateRequest paginate, AuthorQueryParamDto param, CancellationToken cancellationToken = default);
    Task<bool> Remove(Guid id, CancellationToken cancellationToken = default);
    Task<bool> Update(Guid id, AuthorRequestDto param, CancellationToken cancellationToken = default);
}
