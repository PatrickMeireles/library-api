using Library.Application.Notification;
using Library.Data.Repository.EntityFramework.Interface;
using Library.Domain.Command.Book;
using Library.Domain.DTO.Base;
using Library.Infrastructure.Data.EF;
using Library.Infrastructure.Event.Base;
using Library.Infrastructure.Event.Book;
using MediatR;

namespace Library.Application.Handler.Book;

public class RemoveBookHandler : CommandHandler, IRequestHandler<RemoveBookCommand, CommandReturnDto>
{
    private readonly IBookEntityFrameworkRepository _repository;

    public RemoveBookHandler(EntityFrameworkContext context,
        DomainHandler domainHandler,
        NotificationContext notificationContext,
        IBookEntityFrameworkRepository repository) : base(context, domainHandler, notificationContext)
    {
        _repository = repository;
    }

    public async Task<CommandReturnDto> Handle(RemoveBookCommand request, CancellationToken cancellationToken)
    {
        var result = new CommandReturnDto();

        var exist = await _repository.GetById(request.Id, cancellationToken);

        if (exist is null)
            return result; 
        
        await _repository.Remove(exist, cancellationToken);

        var domainEvent = new RemoveBookEvent(request.Id);

        AddEvent(domainEvent);

        if (await CommitAsync(cancellationToken))
            result.Successfully();

        return result;
    }
}
