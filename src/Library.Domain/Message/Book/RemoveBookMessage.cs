namespace Library.Domain.Message.Book;

public record RemoveBookMessage
{
    public Guid Id { get; set; }

    public RemoveBookMessage(Guid id)
    {
        Id = id;
    }
}
