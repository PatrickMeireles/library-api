using Library.Domain.DTO.Base;
using MediatR;

namespace Library.Domain.Command.Author;

public class UpdateAuthorCommand : IRequest<CommandReturnDto>
{
    public Guid Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Biography { get; set; } = string.Empty;
    public DateTime DateOfBirth { get; set; }

    public UpdateAuthorCommand()
    {

    }
}
