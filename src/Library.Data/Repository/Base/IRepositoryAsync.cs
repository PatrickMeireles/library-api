using Library.Domain.Model.Base;
using System.Linq.Expressions;

namespace Library.Data.Repository.Base;

public interface IRepositoryAsync<T> where T : AggregateRoot
{
    Task<T?> GetById(Guid id, CancellationToken cancellationToken = default);
    Task AddOrUpdate(T aggregateRoot, CancellationToken cancellationToken = default);
    Task Remove(T aggregateRoot, CancellationToken cancellationToken = default);
    Task<IEnumerable<T>> Get(Expression<Func<T, bool>>? predicate = default, int page = default, int pageSize = default, CancellationToken cancellationToken = default);

}
