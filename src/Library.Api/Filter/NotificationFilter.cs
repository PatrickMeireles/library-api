using Library.Application.Notification;
using Microsoft.AspNetCore.Mvc.Filters;
using System.Net;
using System.Text.Json;
using System.Text.Json.Serialization;

namespace Library.Api.Filter;

public class NotificationFilter : IAsyncResultFilter
{
    private readonly NotificationContext _notificationContext;

    public NotificationFilter(NotificationContext notificationContext)
    {
        _notificationContext = notificationContext;
    }

    public async Task OnResultExecutionAsync(ResultExecutingContext context, ResultExecutionDelegate next)
    {
        if (!context.ModelState.IsValid)
        {
            var ErrorsTuple = new List<Tuple<string, string>>();

            foreach (var key in context.ModelState.Keys)
            {
                var modelState = context.ModelState[key];

                if (modelState is not null)
                {
                    ErrorsTuple.Add(new(key, string.Join(',', modelState.Errors.Select(c => c.ErrorMessage))));
                }
            }

            var errors = ErrorsTuple.Select(c => new
            {
                Title = c.Item1,
                Detail = c.Item2
            }).ToList();

            var result = BuildResponseObject(context.HttpContext.Request?.Path.Value ?? "", context.HttpContext.TraceIdentifier, errors);

            var content = SerializeResponse(result);

            await BuildResponseContext(context, content);

            return;
        }

        if (_notificationContext.HasNotifications)
        {
            var errors = _notificationContext.Notifications.Select(c => new
            {
                Title = c.Key,
                Detail = c.Message
            }).ToList();

            var result = BuildResponseObject(context.HttpContext.Request?.Path.Value ?? "", context.HttpContext.TraceIdentifier, errors);

            var content = SerializeResponse(result);

            await BuildResponseContext(context, content);

            return;
        }

        await next();
    }

    private static string SerializeResponse(object result)
    {
        var options = new JsonSerializerOptions
        {
            DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull,
            PropertyNamingPolicy = JsonNamingPolicy.CamelCase
        };

        return JsonSerializer.Serialize(result, options);
    }

    private static async Task BuildResponseContext(ResultExecutingContext context, string content)
    {
        context.HttpContext.Response.StatusCode = (int)HttpStatusCode.BadRequest;
        context.HttpContext.Response.ContentType = "application/problem+json";
        await context.HttpContext.Response.WriteAsync(content);
    }

    private static object BuildResponseObject(string instance, string traceIdentifier, IEnumerable<object> errors)
    {
        return new
        {
            Status = (int)HttpStatusCode.BadRequest,
            Type = "One or more errors occurred in the process.",
            Instance = instance,
            TraceId = traceIdentifier,
            Errors = errors
        };
    }
}
