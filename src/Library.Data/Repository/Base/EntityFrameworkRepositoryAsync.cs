using Library.Domain.Model.Base;
using Library.Infrastructure.Data.EF;
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;

namespace Library.Data.Repository.Base;

public class EntityFrameworkRepositoryAsync<T> : IRepositoryAsync<T> where T : AggregateRoot
{
    protected readonly EntityFrameworkContext _context;
    protected readonly DbSet<T> _dbSet;

    public EntityFrameworkRepositoryAsync(EntityFrameworkContext context)
    {
        _context = context;
        _dbSet = _context.Set<T>();
    }

    public async Task AddOrUpdate(T aggregateRoot, CancellationToken cancellationToken = default)
    {
        var exist = await _dbSet.AsNoTracking().SingleOrDefaultAsync(c => c.Id == aggregateRoot.Id, cancellationToken);

        if (exist is null)
            await _dbSet.AddAsync(aggregateRoot, cancellationToken);
        else
        {
            _context.Entry(exist).CurrentValues.SetValues(aggregateRoot);
            _context.Entry(aggregateRoot).State = EntityState.Modified;

            _context.Update(aggregateRoot);
        }
    }

    public async Task<IEnumerable<T>> Get(Expression<Func<T, bool>>? predicate = null, int page = 0, int pageSize = 0, CancellationToken cancellationToken = default)
    {
        var query = _dbSet.AsNoTracking();

        if (predicate != null)
            query = query.Where(predicate);

        if (page != default && pageSize != default)
            query = query.Skip(Math.Abs((page - 1) * pageSize)).Take(pageSize);

        return await query.ToListAsync(cancellationToken);
    }

    public async Task<T?> GetById(Guid id, CancellationToken cancellationToken = default)
    {
        var result = await _dbSet.FirstOrDefaultAsync(c => c.Id == id, cancellationToken);
        return result;
    }

    public async Task Remove(T aggregateRoot, CancellationToken cancellationToken = default)
    {
        var result = await _dbSet.FirstOrDefaultAsync(c => c.Id == aggregateRoot.Id, cancellationToken);

        if (result is not null)
            _dbSet.Remove(result);
    }
}
