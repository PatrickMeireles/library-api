using Library.Application.Handler;
using Library.Application.Notification;
using Library.Data.Context;
using Library.Infrastructure.Event.Base;

namespace Library.Test.Helper;

public class FakeCommandHandler : CommandHandler
{
    public FakeCommandHandler(IContext context, DomainHandler domainHandler, NotificationContext notificationContext) : base(context, domainHandler, notificationContext)
    {
    }

    public async Task<bool> CallCommit()
    {
        return await CommitAsync(default);
    }

    public void CallAddEvent(FakeEvent @event) =>
        AddEvent(@event);
}

public class FakeContext : IContext
{
    public Task<bool> CommitAsync(CancellationToken cancellationToken = default)
    {
        return Task.FromResult(true);
    }
}

public class FakeEvent : DomainEvent
{

}

