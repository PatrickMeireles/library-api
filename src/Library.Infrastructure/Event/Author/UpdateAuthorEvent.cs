using Library.Infrastructure.Event.Base;

namespace Library.Infrastructure.Event.Author;

public class UpdateAuthorEvent : DomainEvent
{
    public Domain.Model.Author Author { get; private set; }

    public UpdateAuthorEvent(Domain.Model.Author author)
    {
        Author = author;
    }


    public UpdateAuthorEvent()
    {

    }
}
