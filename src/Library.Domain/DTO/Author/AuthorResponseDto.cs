namespace Library.Domain.DTO.Author;

public class AuthorResponseDto
{
    public Guid Id { get; set; }
    public string Name { get; set; } = string.Empty;

    public string Biography { get; set; } = string.Empty;

    public DateTime DateOfBirth { get; set; }
}
