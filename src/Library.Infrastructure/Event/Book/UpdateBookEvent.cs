using Library.Infrastructure.Event.Base;

namespace Library.Infrastructure.Event.Book;

public class UpdateBookEvent : DomainEvent
{
    public Domain.Model.Book Book { get; private set; }

    public UpdateBookEvent(Domain.Model.Book book)
    {
        Book = book;
    }
}
