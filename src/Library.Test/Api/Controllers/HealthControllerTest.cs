using Library.Api.Controllers;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Diagnostics.HealthChecks;
using System.Collections.ObjectModel;
using System.Net;
using System.Text.Json;

namespace Library.Test.Api.Controllers;

[TestClass]
public class HealthControllerTest
{
    private HealthController _controller;

    [TestMethod]
    public async Task Should_Get_Return_Ok()
    {
        var healthCheckService = new FakeHealthCheckService(HealthStatus.Healthy);
        _controller = new HealthController(healthCheckService);

        var result = await _controller.Get(default);

        var expectedResult = "{\"status\":\"Healthy\",\"details\":[{\"name\":\"entryReport\",\"status\":\"Healthy\",\"description\":null}]}";

        var jsonResult = JsonSerializer.Serialize(((OkObjectResult)result).Value);

        Assert.IsNotNull(result);
        Assert.AreEqual(typeof(OkObjectResult), result.GetType());
        Assert.AreEqual(expectedResult, jsonResult);
    }

    [TestMethod]
    public async Task Should_Get_Return_Unavailable()
    {
        var healthCheckService = new FakeHealthCheckService(HealthStatus.Unhealthy);
        _controller = new HealthController(healthCheckService);

        var expectedResult = "{\"status\":\"Unhealthy\",\"details\":[{\"name\":\"entryReport\",\"status\":\"Unhealthy\",\"description\":null}]}";

        var result = await _controller.Get(default);
        var objectResult = (ObjectResult)result;
        var jsonResult = JsonSerializer.Serialize(objectResult.Value);

        Assert.IsNotNull(result);
        Assert.AreEqual(typeof(ObjectResult), result.GetType());
        Assert.AreEqual((int)HttpStatusCode.ServiceUnavailable, objectResult.StatusCode);
        Assert.AreEqual(expectedResult, jsonResult);
    }

    public class FakeHealthCheckService : HealthCheckService
    {
        private readonly HealthStatus _healthStatus;

        public FakeHealthCheckService(HealthStatus healthStatus)
        {
            _healthStatus = healthStatus;
        }

        public override Task<HealthReport> CheckHealthAsync(Func<HealthCheckRegistration, bool> predicate, CancellationToken cancellationToken = default)
        {
            var healhReportEntry = new HealthReportEntry(_healthStatus, default, new TimeSpan(1, 1, 1, 1), default, default);
            var dictionary = new Dictionary<string, HealthReportEntry> { { "entryReport", healhReportEntry } };
            var readOnlyDictionary = new ReadOnlyDictionary<string, HealthReportEntry>(dictionary);

            return Task.FromResult(new HealthReport(readOnlyDictionary, new TimeSpan(1, 1, 1, 1)));
        }
    }
}
