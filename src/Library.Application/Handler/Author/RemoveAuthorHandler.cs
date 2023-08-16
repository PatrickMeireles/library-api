using Library.Application.Notification;
using Library.Application.Rules;
using Library.Data.Repository.EntityFramework.Interface;
using Library.Domain.Command.Author;
using Library.Domain.DTO.Base;
using Library.Infrastructure.Data.EF;
using Library.Infrastructure.Event.Author;
using Library.Infrastructure.Event.Base;
using MediatR;

namespace Library.Application.Handler.Author;

public class RemoveAuthorHandler : CommandHandler, IRequestHandler<RemoveAuthorCommand, CommandReturnDto>
{
    private readonly IAuthorEntityFrameworkRepository _repository;
    private readonly AuthorRules _authorRules;

    public RemoveAuthorHandler(EntityFrameworkContext context,
        DomainHandler domainHandler,
        NotificationContext notificationContext,
        IAuthorEntityFrameworkRepository repository,
        AuthorRules authorRules) : base(context, domainHandler, notificationContext)
    {
        _repository = repository;
        _authorRules = authorRules;
        _authorRules = authorRules;
    }

    public async Task<CommandReturnDto> Handle(RemoveAuthorCommand request, CancellationToken cancellationToken)
    {
        var result = new CommandReturnDto();

        var exist = await _repository.GetById(request.Id, cancellationToken);

        if (exist is null)
            return result;

        var isValid = await _authorRules.RemoveIsValidAsync(request.Id, cancellationToken);

        if (!isValid)
            return result;

        await _repository.Remove(exist, cancellationToken);

        var domainEvent = new RemoveAuthorEvent(request.Id);

        AddEvent(domainEvent);

        if (await CommitAsync(cancellationToken))
            result.Successfully();

        return result;
    }
}
