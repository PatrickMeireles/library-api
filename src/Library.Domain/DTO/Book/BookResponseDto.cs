using Library.Domain.DTO.Base;

namespace Library.Domain.DTO.Book;

public record BookResponseDto
{
    public Guid Id { get; set; }
    public string Title { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public int YearPublication { get; set; }
    public int Pages { get; set; }
    public EnumResponse BookType { get; set; } = null!;
    public EnumResponse Genre { get; set; } = null!;
    public IEnumerable<Guid> Authors { get; set; } = null!;
}
