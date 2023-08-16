using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Diagnostics.HealthChecks;
using System.Net;

namespace Library.Api.Controllers;

[Route("api/[controller]")]
[ApiController]
[ApiVersionNeutral]
public class HealthController : ControllerBase
{
    private readonly HealthCheckService _healthCheckService;

    public HealthController(HealthCheckService healthCheckService) =>
        _healthCheckService = healthCheckService;

    [HttpGet]
    public async Task<IActionResult> Get(CancellationToken cancellationToken = default)
    {
        var checkHealth = await _healthCheckService.CheckHealthAsync(cancellationToken);

        var data = new
        {
            status = checkHealth.Status.ToString(),
            details = checkHealth.Entries.Select(x =>
                new
                {
                    name = x.Key,
                    status = x.Value.Status.ToString(),
                    description = x.Value.Description
                })
        };

        if (checkHealth.Status == HealthStatus.Healthy)
        {
            return Ok(data);
        }
        else
        {
            var serviceUnavailable = new ObjectResult(data)
            {
                StatusCode = (int)HttpStatusCode.ServiceUnavailable
            };

            return serviceUnavailable;
        }
    }
}
