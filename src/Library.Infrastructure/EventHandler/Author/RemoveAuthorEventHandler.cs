using Library.Domain.Message.Author;
using Library.Infrastructure.Event.Author;
using MassTransit;
using MediatR;
using Microsoft.Extensions.Configuration;

namespace Library.Infrastructure.EventHandler.Author;

public class RemoveAuthorEventHandler : INotificationHandler<RemoveAuthorEvent>
{
    private readonly IBus _bus;
    private readonly IConfiguration _configuration;

    public RemoveAuthorEventHandler(IBus bus, IConfiguration configuration)
    {
        _bus = bus;
        _configuration = configuration;
    }

    public async Task Handle(RemoveAuthorEvent notification, CancellationToken cancellationToken)
    {
        var message = new RemoveAuthorMessage(notification.Id);

        var queue = $"queue:{_configuration["RabbitMq:RemoveAuthorQueue"]}";

        var endpoint = await _bus.GetSendEndpoint(new Uri(queue));

        await endpoint.Send(message, cancellationToken);
    }
}
