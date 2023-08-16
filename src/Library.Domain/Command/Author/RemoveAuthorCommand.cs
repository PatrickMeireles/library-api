using Library.Domain.DTO.Base;
using MediatR;

namespace Library.Domain.Command.Author;

public class RemoveAuthorCommand : IRequest<CommandReturnDto>
{
    public Guid Id { get; private set; }

    public RemoveAuthorCommand(Guid id)
    {
        Id = id;
    }
}
