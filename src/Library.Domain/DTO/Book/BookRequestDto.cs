using Library.Domain.Enum;
using System.ComponentModel.DataAnnotations;

namespace Library.Domain.DTO.Book;

public class BookRequestDto
{
    [Required]
    [MaxLength(50)]
    public string Title { get; set; } = "";

    [Required]
    public string Description { get; set; } = "";

    [Required]
    public int YearPublication { get; set; }

    [Required]
    public int Pages { get; set; }

    [Required]
    [EnumDataType(typeof(BookType))]
    public int BookType { get; set; }

    [Required]
    [EnumDataType(typeof(Genre))]
    public int Genre { get; set; }

    [Required, MinLength(1)]
    public ICollection<Guid> Authors { get; set; } = new List<Guid>();
}
