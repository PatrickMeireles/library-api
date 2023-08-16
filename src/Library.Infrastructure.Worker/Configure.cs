using Library.Infrastructure.Worker.Consumer.Author;
using Library.Infrastructure.Worker.Consumer.Book;
using MassTransit;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace Library.Infrastructure.Worker;

public static class Configure
{
    public static void ConfigureInfrastructureWorker(this IServiceCollection services, IConfiguration configuration)
    {
        services.AddMassTransit(c =>
        {
            c.AddConsumer<CreateAuthorConsumer>();
            c.AddConsumer<RemoveAuthorConsumer>();
            c.AddConsumer<UpdateAuthorConsumer>();
            c.AddConsumer<CreateBookConsumer>();
            c.AddConsumer<RemoveBookConsumer>();
            c.AddConsumer<UpdateBookConsumer>();

            c.UsingRabbitMq((ctx, cfg) =>
            {
                var stringConnection = configuration["RabbitMq:ConnectionString"];
                cfg.Host(stringConnection);

                cfg.ConfigureEndpoints(ctx);

                cfg.ReceiveEndpoint(configuration["RabbitMq:CreateBookQueue"], e =>
                {
                    e.PrefetchCount = 10;
                    e.ConfigureConsumer<CreateBookConsumer>(ctx);
                });

                cfg.ReceiveEndpoint(configuration["RabbitMq:CreateAuthorQueue"], e =>
                {
                    e.PrefetchCount = 10;
                    e.ConfigureConsumer<CreateAuthorConsumer>(ctx);
                });

                cfg.ReceiveEndpoint(configuration["RabbitMq:RemoveAuthorQueue"], e =>
                {
                    e.PrefetchCount = 10;
                    e.ConfigureConsumer<RemoveAuthorConsumer>(ctx);
                });

                cfg.ReceiveEndpoint(configuration["RabbitMq:UpdateAuthorQueue"], e =>
                {
                    e.PrefetchCount = 10;
                    e.ConfigureConsumer<UpdateAuthorConsumer>(ctx);
                });

                cfg.InjectQueue<RemoveBookConsumer>(ctx, configuration["RabbitMq:RemoveBookQueue"]);
                cfg.InjectQueue<UpdateBookConsumer>(ctx, configuration["RabbitMq:UpdateBookQueue"]);
            });
        });
    }

    private static void InjectQueue<T>(this IRabbitMqBusFactoryConfigurator configurator, IBusRegistrationContext context, string queue) where T : class, IConsumer
    {
        configurator.ReceiveEndpoint(queue, e =>
        {
            e.PrefetchCount = 10;
            e.ConfigureConsumer(context, typeof(T));
        });
    }
}