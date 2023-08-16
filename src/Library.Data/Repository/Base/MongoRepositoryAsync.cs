using Library.Domain.Model.Base;
using Library.Infrastructure.Data.Mongo;
using MongoDB.Driver;
using System.Linq.Expressions;

namespace Library.Data.Repository.Base;

public class MongoRepositoryAsync<T> : IRepositoryAsync<T> where T : AggregateRoot
{
    protected readonly MongoDbContext _mongoContext;
    protected IMongoCollection<T> _mongoCollection;

    public MongoRepositoryAsync(MongoDbContext mongoContext)
    {
        _mongoContext = mongoContext;
        _mongoCollection = _mongoContext.GetCollection<T>(typeof(T).Name);
    }

    public async Task AddOrUpdate(T aggregateRoot, CancellationToken cancellationToken = default)
    {
        FilterDefinition<T> filter = Builders<T>.Filter.Eq("Id", aggregateRoot.Id);

        var exist = await _mongoCollection.Find(filter).FirstOrDefaultAsync(cancellationToken);

        if (exist == null)
            await _mongoCollection.InsertOneAsync(aggregateRoot, null, cancellationToken);
        else
            await _mongoCollection.ReplaceOneAsync(filter, aggregateRoot, cancellationToken: cancellationToken);
    }

    public async Task<IEnumerable<T>> Get(Expression<Func<T, bool>>? predicate = null, int page = 0, int pageSize = 0, CancellationToken cancellationToken = default)
    {
        var query = _mongoCollection.Find(predicate);

        if (page != default && pageSize != default)
            query = query.Skip(Math.Abs((page - 1) * pageSize)).Limit(pageSize);

        return await query.ToListAsync(cancellationToken);
    }

    public async Task<T?> GetById(Guid id, CancellationToken cancellationToken = default)
    {
        FilterDefinition<T> filter = Builders<T>.Filter.Eq("Id", id);

        return await _mongoCollection.Find(filter).FirstOrDefaultAsync(cancellationToken);
    }

    public async Task Remove(T aggregateRoot, CancellationToken cancellationToken = default)
    {
        await _mongoCollection.DeleteOneAsync(c => c.Id == aggregateRoot.Id, cancellationToken);
    }
}
