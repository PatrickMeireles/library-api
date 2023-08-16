using Library.Data.Context;
using Library.Data.Mapping.Base;
using Library.Infrastructure.Event.Base;
using Library.Infrastructure.Helper;
using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Storage;

namespace Library.Infrastructure.Data.EF;

public class EntityFrameworkContext : DbContext, IContext
{
    private readonly IDbContextTransaction _transaction;
    private readonly DomainHandler _domainHandler;
    private readonly IMediator _mediator;

    public EntityFrameworkContext(DbContextOptions<EntityFrameworkContext> options, DomainHandler domainHandler, IMediator mediator) : base(options)
    {
        _transaction = Database.BeginTransaction();
        _domainHandler = domainHandler;
        _mediator = mediator;
    }

    public EntityFrameworkContext(DbContextOptions<EntityFrameworkContext> options) : base(options)
    {
        if (Database.IsRelational())
            Database.Migrate();
    }

    public EntityFrameworkContext()
    {

    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.ApplyConfigurationsFromAssembly(typeof(IEFMappingEntrypoint).Assembly);

        base.OnModelCreating(modelBuilder);
    }

    public virtual async Task<bool> CommitAsync(CancellationToken cancellationToken = default)
    {
        try
        {
            var saveChanges = await SaveChangesAsync(cancellationToken) > 0;

            if (!saveChanges)
                return false;

            await _mediator.DispatchDomainEvents(_domainHandler.DomainEvents, cancellationToken);

            _domainHandler.ClearEvents();

            await _transaction.CommitAsync(cancellationToken);

            return true;
        }
        catch (Exception)
        {
            _domainHandler.ClearEvents();
            await _transaction.RollbackAsync(cancellationToken);

            throw;
        }
    }
}
