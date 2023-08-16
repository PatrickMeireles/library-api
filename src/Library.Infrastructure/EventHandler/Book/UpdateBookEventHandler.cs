using Library.Domain.Message.Book;
using Library.Infrastructure.Event.Book;
using Mapster;
using MassTransit;
using MediatR;
using Microsoft.Extensions.Configuration;

namespace Library.Infrastructure.EventHandler.Book;

public class UpdateBookEventHandler : INotificationHandler<UpdateBookEvent>
{
    private readonly IBus _bus;
    private readonly IConfiguration _configuration;

    public UpdateBookEventHandler(IBus bus, IConfiguration configuration)
    {
        _bus = bus;
        _configuration = configuration;
    }

    public async Task Handle(UpdateBookEvent notification, CancellationToken cancellationToken)
    {
        var message = notification.Book.Adapt<UpdateBookMessage>();

        var queue = $"queue:{_configuration["RabbitMq:UpdateBookQueue"]}";

        var endpoint = await _bus.GetSendEndpoint(new Uri(queue));

        await endpoint.Send(message, cancellationToken);
    }
}
