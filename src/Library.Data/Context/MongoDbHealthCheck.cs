using Library.Infrastructure.Data.Mongo;
using Microsoft.Extensions.Diagnostics.HealthChecks;
using Microsoft.Extensions.Options;
using MongoDB.Bson;
using MongoDB.Driver;

namespace Library.Data.Context;

public class MongoDbHealthCheck : IHealthCheck
{
    private IMongoDatabase MongoDatabase { get; set; }
    public MongoClient MongoClient { get; set; }
    private string DatabaseName { get; set; }
    public MongoDbHealthCheck(IOptions<MongoSettings> configuration)
    {
        MongoClient = new MongoClient(configuration.Value.Connection);
        MongoDatabase = MongoClient.GetDatabase(configuration.Value.DatabaseName);
        DatabaseName = configuration.Value.DatabaseName;
    }

    public async Task<HealthCheckResult> CheckHealthAsync(HealthCheckContext context, CancellationToken cancellationToken = default)
    {
        var healthCheckResultHealthy = await CheckMongoDBConnectionAsync();


        if (healthCheckResultHealthy)
        {
            return HealthCheckResult.Healthy($"MongoDB database {DatabaseName} health check success");
        }

        return HealthCheckResult.Unhealthy($"MongoDB database {DatabaseName} health check failure");
    }

    private async Task<bool> CheckMongoDBConnectionAsync()
    {
        try
        {
            await MongoDatabase.RunCommandAsync((Command<BsonDocument>)"{ping:1}");
        }

        catch (Exception)
        {
            return false;
        }

        return true;
    }
}
