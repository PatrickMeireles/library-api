using Library.Infrastructure.Event.Base;
using MediatR;

namespace Library.Infrastructure.Helper;

public static class MediatorExtension
{
    public static async Task DispatchDomainEvents(this IMediator _mediator, IEnumerable<DomainEvent> events, CancellationToken cancellationToken = default)
    {
        foreach (var @event in events)
        {
            await _mediator.Publish(@event, cancellationToken);
        }
    }
}
