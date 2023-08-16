using Library.Application.Notification;
using Library.Application.Rules;
using Library.Data.Repository.EntityFramework.Interface;
using Library.Domain.Command.Book;
using Library.Domain.DTO.Base;
using Library.Infrastructure.Data.EF;
using Library.Infrastructure.Event.Base;
using Library.Infrastructure.Event.Book;
using Mapster;
using MediatR;

namespace Library.Application.Handler.Book;

public class UpdateBookHandler : CommandHandler, IRequestHandler<UpdateBookCommand, CommandReturnDto>
{
    private readonly IBookEntityFrameworkRepository _repository;
    private readonly BookRules _rules;
    public UpdateBookHandler(EntityFrameworkContext context,
        DomainHandler domainHandler,
        NotificationContext notificationContext,
        IBookEntityFrameworkRepository repository,
        BookRules rules) : base(context, domainHandler, notificationContext)
    {
        _repository = repository;
        _rules = rules;
    }

    public async Task<CommandReturnDto> Handle(UpdateBookCommand request, CancellationToken cancellationToken)
    {
        var result = new CommandReturnDto();

        var exist = await _repository.GetById(request.Id, cancellationToken);

        if (exist is null)
            return result;

        var data = request.Adapt<Domain.Model.Book>();

        var isValid = await _rules.UpdateIsValidAsync(data, cancellationToken);

        if (!isValid)
            return result;

        await _repository.AddOrUpdate(data, cancellationToken);

        AddEvent(new UpdateBookEvent(data));

        if (await CommitAsync(cancellationToken))
            result.Successfully();

        return result;
    }
}
