using Library.Infrastructure.Event.Base;

namespace Library.Infrastructure.Event.Author;

public class RemoveAuthorEvent : DomainEvent
{
    public Guid Id { get; private set; }

    public RemoveAuthorEvent(Guid id)
    {
        Id = id;
    }

    public RemoveAuthorEvent()
    {

    }
}
