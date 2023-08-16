using Library.Domain.Message.Book;
using Library.Infrastructure.Event.Book;
using MassTransit;
using MediatR;
using Microsoft.Extensions.Configuration;

namespace Library.Infrastructure.EventHandler.Book;

public class RemoveBookEventHandler : INotificationHandler<RemoveBookEvent>
{
    private readonly IBus _bus;
    private readonly IConfiguration _configuration;

    public RemoveBookEventHandler(IBus bus, IConfiguration configuration)
    {
        _bus = bus;
        _configuration = configuration;
    }

    public async Task Handle(RemoveBookEvent notification, CancellationToken cancellationToken)
    {
        var message = new RemoveBookMessage(notification.Id);

        var queue = $"queue:{_configuration["RabbitMq:RemoveBookQueue"]}";

        var endpoint = await _bus.GetSendEndpoint(new Uri(queue));

        await endpoint.Send(message, cancellationToken);
    }
}
