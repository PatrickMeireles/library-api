using MediatR;

namespace Library.Infrastructure.Event.Base;

public abstract class DomainEvent : INotification
{
    public DateTime Timestamp { get; private set; }
    public virtual Guid EventId { get; private set; }

    protected DomainEvent()
    {
        EventId = Guid.NewGuid();
        Timestamp = DateTime.Now;
    }
}
