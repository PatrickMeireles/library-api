namespace Library.Domain.DTO.Book;

public class BookQueryParamDto
{
    public Guid[] Id { get; set; } = Array.Empty<Guid>();
    public string Title { get; set; } = string.Empty;
    public Guid[] AuthorId { get; set; } = Array.Empty<Guid>();
    public int YearPublication { get; set; }
    public int BookType { get; set; }
    public int Genre { get; set; }
}
