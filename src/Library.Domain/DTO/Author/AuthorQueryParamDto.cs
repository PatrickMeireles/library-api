namespace Library.Domain.DTO.Author;

public class AuthorQueryParamDto
{
    public Guid[] Id { get; set; } = Array.Empty<Guid>();
    public string Name { get; set; } = string.Empty;
}
