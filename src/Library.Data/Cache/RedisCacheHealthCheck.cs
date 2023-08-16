using Microsoft.Extensions.Caching.StackExchangeRedis;
using Microsoft.Extensions.Diagnostics.HealthChecks;
using Microsoft.Extensions.Options;
using StackExchange.Redis;

namespace Library.Data.Cache;

public class RedisCacheHealthCheck : IHealthCheck
{
    private readonly RedisCacheOptions _options;
    private readonly ConnectionMultiplexer _redis;

    public RedisCacheHealthCheck(IOptions<RedisCacheOptions> optionsAccessor)
    {
        _options = optionsAccessor.Value;
        _redis = ConnectionMultiplexer.Connect(GetConnectionOptions());
    }

    public Task<HealthCheckResult> CheckHealthAsync(HealthCheckContext context, CancellationToken cancellationToken = default)
    {
        var isConnected = _redis.IsConnected;

        var task = Task.FromResult(isConnected ? HealthCheckResult.Healthy() : HealthCheckResult.Unhealthy("Redis connection not working!") );

        return task;
    }

    private ConfigurationOptions GetConnectionOptions()
    {
        ConfigurationOptions redisConnectionOptions = (_options.ConfigurationOptions != null)
            ? ConfigurationOptions.Parse(_options.ConfigurationOptions.ToString())
            : ConfigurationOptions.Parse(_options.Configuration);

        redisConnectionOptions.AbortOnConnectFail = false;

        return redisConnectionOptions;
    }
}
