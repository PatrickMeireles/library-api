using Library.Domain.Message.Book;
using Library.Infrastructure.Event.Book;
using Mapster;
using MassTransit;
using MediatR;
using Microsoft.Extensions.Configuration;

namespace Library.Infrastructure.EventHandler.Book;

public class CreateBookEventHandler : INotificationHandler<CreatedBookEvent>
{
    private readonly IBus _bus;
    private readonly IConfiguration _configuration;

    public CreateBookEventHandler(IBus bus, IConfiguration configuration)
    {
        _bus = bus;
        _configuration = configuration;
    }

    public async Task Handle(CreatedBookEvent notification, CancellationToken cancellationToken)
    {
        var message = notification.Book.Adapt<CreateBookMessage>();

        var queue = $"queue:{_configuration["RabbitMq:CreateBookQueue"]}";

        var endpoint = await _bus.GetSendEndpoint(new Uri(queue));

        await endpoint.Send(message, cancellationToken);
    }
}
