using Library.Data.Cache;
using Library.Data.Context;
using Library.Data.Repository.EntityFramework;
using Library.Data.Repository.EntityFramework.Interface;
using Library.Data.Repository.Mongo;
using Library.Data.Repository.Mongo.Interface;
using Library.Infrastructure.Data.EF;
using Library.Infrastructure.Data.Mongo;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace Library.Data;

public static class Configure
{
    public static void ConfigureData(this IServiceCollection services, IConfiguration configuration)
    {
        services.AddRepositories();
        services.ConfigureSqlServer(configuration);
        services.ConfigureMongoDb(configuration);
        services.ConfigureRedis(configuration);
        services.AddHealthCheck();

    }

    public static void AddRepositories(this IServiceCollection services)
    {
        services.AddScoped<IBookEntityFrameworkRepository, BookEntityFrameworkRepository>();
        services.AddScoped<IAuthorEntityFrameworkRepository, AuthorEntityFrameworkRepository>();

        services.AddScoped<IAuthorMongoRepository, AuthorMongoRepository>();
        services.AddScoped<IBookMongoRepository, BookMongoRepository>();
    }

    public static void ConfigureSqlServer(this IServiceCollection services, IConfiguration configuration)
    {
        var connectionString = configuration["ConnectionStrings:EF_CONNECTIONSTRING"];

        if (string.IsNullOrWhiteSpace(connectionString))
            throw new ArgumentException("String Connection to use Sql Server was not found.");

        var options = new DbContextOptionsBuilder<EntityFrameworkContext>();
        options.UseNpgsql(connectionString);
        _ = new EntityFrameworkContext(options.Options);

        services.AddDbContext<EntityFrameworkContext>(options =>
        {
            options.UseNpgsql(connectionString);
            options.EnableSensitiveDataLogging();
            options.UseQueryTrackingBehavior(QueryTrackingBehavior.NoTracking);
        });
    }

    private static void ConfigureMongoDb(this IServiceCollection services, IConfiguration configuration)
    {
        var param = configuration.GetSection("MongoDatabase");

        var connectionString = param["ConnectionString"];

        if (string.IsNullOrWhiteSpace(connectionString))
            throw new ArgumentException("String Connection to use MongoDb was not found.");

        services.PostConfigure<MongoSettings>(c =>
        {
            c.Connection = param["ConnectionString"];
            c.DatabaseName = param["DatabaseName"];
        });

        services.AddScoped<MongoDbContext>();
    }

    private static void ConfigureRedis(this IServiceCollection services, IConfiguration configuration)
    {
        services.AddScoped<ICacheService, CacheService>();

        services.PostConfigure<RedisSettings>(c =>
        {
            c.Configuration = configuration["Redis:ConnectionString"];
        });

        var trySlidingExpiration = int.TryParse(configuration["CacheConfiguration:AbsoluteExpirationHours"], out int slidingExpiration);
        var tryAbsoluteExpirationRelativeToNow = int.TryParse(configuration["CacheConfiguration:SlidingExpirationMinutes"], out int absoluteExpirationRelativeToNow);

        services.PostConfigure<CacheSettings>(c =>
        {
            c.SlidingExpirationMinutes = trySlidingExpiration ? null : slidingExpiration;
            c.AbsoluteExpirationRelativeHours = tryAbsoluteExpirationRelativeToNow ? null : absoluteExpirationRelativeToNow;
        });

        services.AddStackExchangeRedisCache(options =>
        {
            options.Configuration = configuration["Redis:ConnectionString"];
        });
    }


    private static void AddHealthCheck(this IServiceCollection services)
    {
        services.AddHealthChecks()
                .AddDbContextCheck<EntityFrameworkContext>("Npgsql");

        services.AddHealthChecks()
            .AddCheck<MongoDbHealthCheck>("Mongo");

        services.AddHealthChecks()
           .AddCheck<RedisCacheHealthCheck>("Redis");

        
    }
}
