using System.ComponentModel.DataAnnotations;

namespace Library.Domain.DTO.Author;

public abstract class AuthorDto
{
    [Required]
    public string Name { get; set; } = string.Empty;

    [Required]
    public string Biography { get; set; } = string.Empty;

    [Required]
    public DateTime DateOfBirth { get; set; }
}
