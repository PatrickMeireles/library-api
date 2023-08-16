using Library.Infrastructure.Event.Base;

namespace Library.Infrastructure.Event.Book;
public class RemoveBookEvent : DomainEvent
{
    public Guid Id { get; private set; }

    public RemoveBookEvent(Guid id)
    {
        Id = id;
    }

    public RemoveBookEvent()
    {

    }
}
