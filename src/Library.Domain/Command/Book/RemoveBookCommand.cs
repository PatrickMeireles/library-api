using Library.Domain.DTO.Base;
using MediatR;

namespace Library.Domain.Command.Book;

public class RemoveBookCommand : IRequest<CommandReturnDto>
{
    public Guid Id { get; private set; }

    public RemoveBookCommand(Guid id)
    {
        Id = id;
    }
}
