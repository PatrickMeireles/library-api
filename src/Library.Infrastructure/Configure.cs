using Library.Infrastructure.Event.Base;
using Microsoft.Extensions.DependencyInjection;
using System.Reflection;

namespace Library.Infrastructure;

public static class Configure
{
    public static void ConfigureInfrastructure(this IServiceCollection services)
    {
        services.AddScoped<DomainHandler>();

        services.AddMediatR(cfg => cfg.RegisterServicesFromAssembly(Assembly.GetExecutingAssembly()));
    }
}
