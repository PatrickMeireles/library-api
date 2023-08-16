using Library.Data.Context;
using Library.Infrastructure.Event.Base;
using Library.Infrastructure.Helper;
using MediatR;
using Microsoft.Extensions.Options;
using MongoDB.Bson.Serialization.Conventions;
using MongoDB.Driver;

namespace Library.Infrastructure.Data.Mongo;

public class MongoDbContext : IContext, IAsyncDisposable
{
    private MongoClient MongoClient { get; set; }

    private readonly DomainHandler _domainHandler;
    private IMongoDatabase MongoDatabase { get; set; }

    private readonly IMediator _mediator;

    public MongoDbContext(IOptions<MongoSettings> configuration, DomainHandler domainHandler, IMediator mediator)
    {
        MongoClient = new MongoClient(configuration.Value.Connection);
        MongoDatabase = MongoClient.GetDatabase(configuration.Value.DatabaseName);

        _domainHandler = domainHandler;
        _mediator = mediator;

        ConventionRegistry.Register("MyConventions", new ConventionPack { new IgnoreIfNullConvention(true) }, t => true);
    }

    public virtual IMongoCollection<T> GetCollection<T>(string name)
    {
        return MongoDatabase.GetCollection<T>(name);
    }

    public async Task<bool> CommitAsync(CancellationToken cancellationToken = default)
    {
        try
        {
            await _mediator.DispatchDomainEvents(_domainHandler.DomainEvents, cancellationToken);

            _domainHandler.ClearEvents();

            return true;
        }
        catch (Exception)
        {
            _domainHandler.ClearEvents();

            throw;
        }
    }

    public ValueTask DisposeAsync()
    {
        GC.SuppressFinalize(this);
        return ValueTask.CompletedTask;
    }
}
