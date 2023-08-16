using Library.Api.Filter;
using Library.Application;
using Library.Data;
using Library.Infrastructure;
using Library.Infrastructure.Worker;
using Microsoft.AspNetCore.Mvc;

var builder = WebApplication.CreateBuilder(args);

AppContext.SetSwitch("Npgsql.EnableLegacyTimestampBehavior", true);

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

builder.Services.AddApiVersioning(opt =>
{
    opt.DefaultApiVersion = new ApiVersion(1, 0);
    opt.AssumeDefaultVersionWhenUnspecified = true;
    opt.ReportApiVersions = true;
});

builder.Services.AddVersionedApiExplorer(setup =>
{
    setup.GroupNameFormat = "'v'VVV";
    setup.SubstituteApiVersionInUrl = true;
});


builder.Services.ConfigureApplication();
builder.Services.ConfigureData(builder.Configuration);
builder.Services.ConfigureInfrastructure();
builder.Services.ConfigureInfrastructureWorker(builder.Configuration);

builder.Services.AddMvc(options => options.Filters.Add<NotificationFilter>());

builder.Services.Configure<RouteOptions>(options =>
{
    options.LowercaseUrls = true;
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.MapControllers();

app.UseHttpsRedirection();

app.Run();
