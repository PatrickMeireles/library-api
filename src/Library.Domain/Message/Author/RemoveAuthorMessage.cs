namespace Library.Domain.Message.Author;

public class RemoveAuthorMessage
{
    public Guid Id { get; set; }

    public RemoveAuthorMessage(Guid id)
    {
        Id = id;
    }
}
