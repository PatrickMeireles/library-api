using Library.Data.Cache;
using Library.Infrastructure.Data.Mongo;
using Library.Test.Domain.Model.Base;
using Microsoft.Extensions.Caching.Distributed;
using Microsoft.Extensions.Options;
using Moq;
using System.Linq.Expressions;
using System.Text;
using System.Text.Json;

namespace Library.Test.Data.Cache;

[TestClass]
public class CacheServiceTest
{
    private Mock<IDistributedCache> _mockDistributedCache;
    private CacheService _cacheService;


    [TestInitialize]
    public void Init()
    {
        _mockDistributedCache = new();
        var cacheSettings = new CacheSettings();

        IOptions<CacheSettings> IOptions = Options.Create(cacheSettings);

        _cacheService = new(_mockDistributedCache.Object, IOptions);
    }

    [TestMethod]
    [DataRow(null, null)]
    [DataRow(1, null)]
    [DataRow(null, 1)]
    [DataRow(2, 2)]

    public void Should_Create_CacheService(int? AbsoluteExpirationRelativeHours, int? SlidingExpirationMinutes)
    {
        var cacheSettings = new CacheSettings()
        {
            AbsoluteExpirationRelativeHours = AbsoluteExpirationRelativeHours,
            SlidingExpirationMinutes = SlidingExpirationMinutes
        };

        IOptions<CacheSettings> IOptions = Options.Create(cacheSettings);

        var cacheService = new CacheService(_mockDistributedCache.Object, IOptions);

        Assert.IsNotNull(cacheService);
    }

    [TestMethod]
    public async Task Should_GetAsync_Return_Ok()
    {
        var mockResponse = new FakeEntity(Guid.NewGuid());

        var encoding = JsonSerializer.SerializeToUtf8Bytes(mockResponse);

        _mockDistributedCache.Setup(GetAsyncExpression).ReturnsAsync(encoding);

        var result = await _cacheService.GetAsync<FakeEntity>(It.IsAny<string>(), default);

        Assert.IsNotNull(result);
        Assert.AreEqual(mockResponse.Id, result.Id);

        _mockDistributedCache.Verify(GetAsyncExpression, Times.Once);
    }

    [TestMethod]
    public async Task Should_GetAsync_Return_Default()
    {
        byte[] mockResult = default;

        _mockDistributedCache.Setup(GetAsyncExpression).ReturnsAsync(mockResult);

        var result = await _cacheService.GetAsync<FakeEntity>(It.IsAny<string>(), default);

        Assert.IsNull(result);

        _mockDistributedCache.Verify(GetAsyncExpression, Times.Once);
    }

    [TestMethod]
    public async Task Should_RemoveAsync_Return_Ok()
    {
        _mockDistributedCache.Setup(RemoveAsyncExpression).Returns(Task.CompletedTask);

        await _cacheService.RemoveAsync(It.IsAny<string>(), default);

        _mockDistributedCache.Verify(RemoveAsyncExpression, Times.Once);
    }

    [TestMethod]
    public async Task Should_SetAsync_Return_Ok()
    {
        var mockResponse = new FakeEntity(Guid.NewGuid());

        await _cacheService.SetAsync(It.IsAny<string>(), mockResponse, default);

        _mockDistributedCache.Verify(GetAsyncExpression, Times.Never);
    }

    private static Expression<Func<IDistributedCache, Task<byte[]>>> GetAsyncExpression =
        c => c.GetAsync(It.IsAny<string>(), It.IsAny<CancellationToken>());

    private static Expression<Func<IDistributedCache, Task>> RemoveAsyncExpression =
        c => c.RemoveAsync(It.IsAny<string>(), It.IsAny<CancellationToken>());

    private static Expression<Func<IDistributedCache, Task>> SetAsyncExpression =
        c => c.SetAsync(It.IsAny<string>(), It.IsAny<byte[]>(), It.IsAny<CancellationToken>());
}
