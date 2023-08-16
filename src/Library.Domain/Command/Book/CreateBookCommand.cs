using Library.Domain.DTO.Base;
using MediatR;

namespace Library.Domain.Command.Book;

public class CreateBookCommand : IRequest<CommandReturnDto>
{
    public Guid Id { get; set; }
    public string Title { get; set; } = "";
    public string Description { get; set; } = "";
    public int YearPublication { get; set; }
    public int Pages { get; set; }
    public int BookType { get; set; }
    public int Genre { get; set; }
    public ICollection<Guid> Authors { get; set; } = new List<Guid>();

    public CreateBookCommand()
    {
        Id = Guid.NewGuid();
    }
}
