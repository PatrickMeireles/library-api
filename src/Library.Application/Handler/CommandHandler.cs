using Library.Application.Notification;
using Library.Data.Context;
using Library.Infrastructure.Event.Base;

namespace Library.Application.Handler;

public abstract class CommandHandler
{
    private readonly IContext _context;
    private readonly DomainHandler _domainHandler;
    private readonly NotificationContext _notificationContext;

    protected CommandHandler(IContext context, DomainHandler domainHandler, NotificationContext notificationContext)
    {
        _context = context;
        _domainHandler = domainHandler;
        _notificationContext = notificationContext;
    }

    protected async Task<bool> CommitAsync(CancellationToken token = default)
    {
        try
        {
            var result = await _context.CommitAsync(token);
            return result;
        }
        catch (Exception ex)
        {
            _notificationContext.AddNotification("Exception: ", $"Message: {ex.Message}");
            return false;
        }
    }

    protected void AddEvent(DomainEvent domainEvent) =>
        _domainHandler.AddEvent(domainEvent);
}
