namespace Library.Domain.Message.Author;

public class AuthorMessage
{
    public Guid Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Biography { get; set; } = string.Empty;
    public DateTime DateOfBirth { get; set; }

    public DateTime CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }
}
