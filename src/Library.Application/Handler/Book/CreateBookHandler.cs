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

public class CreateBookHandler : CommandHandler,
    IRequestHandler<CreateBookCommand, CommandReturnDto>
{
    private readonly IBookEntityFrameworkRepository _repository;
    private readonly BookRules _rules;
    public CreateBookHandler(EntityFrameworkContext context,
        DomainHandler domainHandler,
        NotificationContext notificationContext,
        IBookEntityFrameworkRepository repository,
        BookRules rules) : base(context, domainHandler, notificationContext)
    {
        _repository = repository;
        _rules = rules;
    }

    public async Task<CommandReturnDto> Handle(CreateBookCommand request, CancellationToken cancellationToken)
    {
        var result = new CommandReturnDto();

        var book = request.Adapt<Domain.Model.Book>();

        var isValid = await _rules.CreateIsValidAsync(book, cancellationToken);

        if (!isValid)
            return result;

        await _repository.AddOrUpdate(book, cancellationToken);

        var domainEvent = new CreatedBookEvent(book);

        AddEvent(domainEvent);

        if (await CommitAsync(cancellationToken))
            result.Successfully();

        return result;
    }
}
