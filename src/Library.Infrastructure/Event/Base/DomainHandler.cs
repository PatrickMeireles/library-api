namespace Library.Infrastructure.Event.Base;

public class DomainHandler
{
    private readonly List<DomainEvent> _domainEvents;

    public IReadOnlyCollection<DomainEvent> DomainEvents => _domainEvents.AsReadOnly();

    public DomainHandler()
    {
        _domainEvents = _domainEvents ?? new List<DomainEvent>();
    }

    public virtual void AddEvent(DomainEvent @event)
    {
        if (@event != null)
            _domainEvents.Add(@event);
    }

    public virtual void ClearEvents()
    {
        _domainEvents.Clear();
    }
}
