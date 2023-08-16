using Library.Application.Notification;
using Library.Application.Rules;
using Library.Data.Repository.EntityFramework.Interface;
using Library.Domain.Command.Author;
using Library.Domain.DTO.Base;
using Library.Infrastructure.Data.EF;
using Library.Infrastructure.Event.Base;
using Library.Infrastructure.Event.CreatedAuthorEvent;
using Mapster;
using MediatR;

namespace Library.Application.Handler.Author;

public class CreateAuthorHandler : CommandHandler, IRequestHandler<CreateAuthorCommand, CommandReturnDto>
{
    private readonly IAuthorEntityFrameworkRepository _repository;
    private readonly AuthorRules _authorRules;

    public CreateAuthorHandler(EntityFrameworkContext context,
        DomainHandler domainHandler,
        NotificationContext notificationContext,
        IAuthorEntityFrameworkRepository repository,
        AuthorRules authorRules) : base(context, domainHandler, notificationContext)
    {
        _repository = repository;
        _authorRules = authorRules;
    }

    public async Task<CommandReturnDto> Handle(CreateAuthorCommand request, CancellationToken cancellationToken)
    {
        var result = new CommandReturnDto();

        var author = request.Adapt<Domain.Model.Author>();

        var isValid = await _authorRules.CreateIsValidAsync(author, cancellationToken);

        if (!isValid)
            return result;

        await _repository.AddOrUpdate(author, cancellationToken);

        var domainEvent = new CreatedAuthorEvent(author);

        AddEvent(domainEvent);

        if (await CommitAsync(cancellationToken))
            result.Successfully();

        return result;
    }
}
