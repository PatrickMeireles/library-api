﻿using AutoFixture;
using Library.Application.Mapper;
using Library.Infrastructure.Event.Book;
using Library.Infrastructure.EventHandler.Book;
using MassTransit;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Moq;
using System.Linq.Expressions;

namespace Library.Test.Infrastructure.EventHandler.Book;

[TestClass]
public class RemoveBookEventHandlerTest
{
    private Mock<IBus> _mockBus;
    private Mock<ISendEndpoint> _mockSendEndpoint;
    private IConfiguration _configuration;
    private RemoveBookEventHandler _handler;
    private Fixture _fixture;

    [TestInitialize]
    public void Init()
    {

        var myConfiguration = new Dictionary<string, string>
            {
                {"RabbitMq:RemoveBookQueue", "value"}
            };

        _mockBus = new();

        _configuration = new ConfigurationBuilder()
            .AddInMemoryCollection(myConfiguration)
            .Build();

        _mockSendEndpoint = new();

        _handler = new(_mockBus.Object, _configuration);

        _fixture = new();
        MappingConfiguration.RegisterMappings(new ServiceCollection());
    }

    [TestMethod]
    public async Task Should_Handle_Event()
    {
        var param = _fixture.Create<RemoveBookEvent>();

        _mockSendEndpoint.Setup(sendExpression).Returns(Task.CompletedTask);

        _mockBus.Setup(getSendEndpointExpression).ReturnsAsync(_mockSendEndpoint.Object);

        await _handler.Handle(param, default);

        _mockBus.Verify(getSendEndpointExpression, Times.Once);
    }

    private readonly Expression<Func<ISendEndpoint, Task>> sendExpression = c =>
        c.Send(It.IsAny<object>(), It.IsAny<CancellationToken>());

    private readonly Expression<Func<IBus, Task<ISendEndpoint>>> getSendEndpointExpression = c =>
        c.GetSendEndpoint(It.IsAny<Uri>());
}