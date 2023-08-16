using Library.Infrastructure.Event.Base;

namespace Library.Infrastructure.Event.Book;

public class CreatedBookEvent : DomainEvent
{
    public Domain.Model.Book Book { get; private set; }

    public CreatedBookEvent(Domain.Model.Book book)
    {
        Book = book;
    }
}
