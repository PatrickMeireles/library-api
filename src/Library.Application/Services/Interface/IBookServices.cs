using Library.Domain.DTO.Base;
using Library.Domain.DTO.Book;

namespace Library.Application.Services.Interface;

public interface IBookServices : IAsyncDisposable
{
    Task<Guid?> Create(BookRequestDto param, CancellationToken cancellationToken = default);
    Task<BookResponseDto?> GetById(Guid id, CancellationToken cancellationToken = default);
    Task<IEnumerable<BookResponseDto>> GetAll(PaginateRequest paginate, BookQueryParamDto param, CancellationToken cancellationToken = default);
    Task<bool> Remove(Guid id, CancellationToken cancellationToken = default);
    Task<bool> Update(Guid id, BookRequestDto param, CancellationToken cancellationToken = default);
}
