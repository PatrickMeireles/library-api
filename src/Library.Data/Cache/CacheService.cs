using Microsoft.Extensions.Caching.Distributed;
using Microsoft.Extensions.Options;
using System.Text.Json;

namespace Library.Data.Cache;

public class CacheService : ICacheService
{
    private readonly IDistributedCache _cache;
    private readonly DistributedCacheEntryOptions _distributedCacheEntryOptions;

    public CacheService(IDistributedCache cache, IOptions<CacheSettings> cacheSettings)
    {
        _cache = cache;
        _distributedCacheEntryOptions = new DistributedCacheEntryOptions();

        if (cacheSettings.Value.AbsoluteExpirationRelativeHours.HasValue)
            _distributedCacheEntryOptions.AbsoluteExpirationRelativeToNow = TimeSpan.FromHours(cacheSettings.Value.AbsoluteExpirationRelativeHours.Value);

        if (cacheSettings.Value.SlidingExpirationMinutes.HasValue)
            _distributedCacheEntryOptions.SlidingExpiration = TimeSpan.FromHours(cacheSettings.Value.SlidingExpirationMinutes.Value);
    }

    public virtual async Task<T?> GetAsync<T>(string key, CancellationToken cancellationToken = default)
    {
        var value = await _cache.GetAsync(key, cancellationToken);

        if (value == null)
            return default;

        var deserialize = JsonSerializer.Deserialize<T>(value);

        return deserialize;
    }

    public virtual async Task RemoveAsync(string key, CancellationToken cancellationToken = default)
    {
        await _cache.RemoveAsync(key, cancellationToken);
    }

    public virtual async Task SetAsync<T>(string key, T value, CancellationToken cancellationToken = default)
    {
        var encoding = JsonSerializer.SerializeToUtf8Bytes(value);

        await _cache.SetAsync(key, encoding, _distributedCacheEntryOptions, cancellationToken);
    }
}
