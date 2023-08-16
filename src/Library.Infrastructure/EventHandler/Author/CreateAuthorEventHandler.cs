using Library.Domain.Message.Author;
using Library.Infrastructure.Event.CreatedAuthorEvent;
using Mapster;
using MassTransit;
using MediatR;
using Microsoft.Extensions.Configuration;

namespace Library.Infrastructure.EventHandler.Author;

public class CreateAuthorEventHandler : INotificationHandler<CreatedAuthorEvent>
{
    private readonly IBus _bus;
    private readonly IConfiguration _configuration;
    public CreateAuthorEventHandler(IBus bus, IConfiguration configuration)
    {
        _bus = bus;
        _configuration = configuration;
    }

    public async Task Handle(CreatedAuthorEvent notification, CancellationToken cancellationToken)
    {
        var message = notification.Author.Adapt<CreateAuthorMessage>();

        var queue = $"queue:{_configuration["RabbitMq:CreateAuthorQueue"]}";

        var endpoint = await _bus.GetSendEndpoint(new Uri(queue));

        await endpoint.Send(message, cancellationToken);
    }
}
