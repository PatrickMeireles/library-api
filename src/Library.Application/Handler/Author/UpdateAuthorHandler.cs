using Library.Application.Notification;
using Library.Application.Rules;
using Library.Data.Repository.EntityFramework.Interface;
using Library.Domain.Command.Author;
using Library.Domain.DTO.Base;
using Library.Infrastructure.Data.EF;
using Library.Infrastructure.Event.Author;
using Library.Infrastructure.Event.Base;
using Mapster;
using MediatR;

namespace Library.Application.Handler.Author;

public class UpdateAuthorHandler : CommandHandler, IRequestHandler<UpdateAuthorCommand, CommandReturnDto>
{
    private readonly IAuthorEntityFrameworkRepository _repository;
    private readonly AuthorRules _authorRules;

    public UpdateAuthorHandler(EntityFrameworkContext context,
        DomainHandler domainHandler,
        NotificationContext notificationContext,
        IAuthorEntityFrameworkRepository repository,
        AuthorRules authorRules) : base(context, domainHandler, notificationContext)
    {
        _repository = repository;
        _authorRules = authorRules;
    }

    public async Task<CommandReturnDto> Handle(UpdateAuthorCommand request, CancellationToken cancellationToken)
    {
        var result = new CommandReturnDto();

        var exist = await _repository.GetById(request.Id, cancellationToken);

        if (exist is null)
            return result;

        var data = request.Adapt<Domain.Model.Author>();

        var isValid = await _authorRules.UpdateIsValidAsync(data, cancellationToken);

        if (!isValid)
            return result;

        await _repository.AddOrUpdate(data, cancellationToken);

        AddEvent(new UpdateAuthorEvent(data));

        if (await CommitAsync(cancellationToken))
            result.Successfully();

        return result;
    }
}
