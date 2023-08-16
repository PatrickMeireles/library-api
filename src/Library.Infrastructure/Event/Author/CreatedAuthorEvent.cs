using Library.Infrastructure.Event.Base;

namespace Library.Infrastructure.Event.CreatedAuthorEvent;

public class CreatedAuthorEvent : DomainEvent
{
    public Domain.Model.Author Author { get; private set; }

    public CreatedAuthorEvent(Domain.Model.Author author)
    {
        Author = author;
    }


    public CreatedAuthorEvent()
    {

    }
}