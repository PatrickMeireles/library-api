using Library.Domain.Message.Author;
using Library.Infrastructure.Event.Author;
using Mapster;
using MassTransit;
using MediatR;
using Microsoft.Extensions.Configuration;

namespace Library.Infrastructure.EventHandler.Author;

public class UpdateAuthorEventHandler : INotificationHandler<UpdateAuthorEvent>
{
    private readonly IBus _bus;
    private readonly IConfiguration _configuration;
    public UpdateAuthorEventHandler(IBus bus, IConfiguration configuration)
    {
        _bus = bus;
        _configuration = configuration;
    }

    public async Task Handle(UpdateAuthorEvent notification, CancellationToken cancellationToken)
    {
        var message = notification.Author.Adapt<UpdateAuthorMessage>();

        var queue = $"queue:{_configuration["RabbitMq:UpdateAuthorQueue"]}";

        var endpoint = await _bus.GetSendEndpoint(new Uri(queue));

        await endpoint.Send(message, cancellationToken);
    }
}
