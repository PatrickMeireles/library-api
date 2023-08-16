using AutoFixture;
using Library.Api.Controllers;
using Library.Application.Services.Interface;
using Library.Domain.DTO.Author;
using Library.Domain.DTO.Base;
using Library.Test.Helper;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Moq;
using System.Linq.Expressions;

namespace Library.Test.Api.Controllers;

[TestClass]
public class AuthorsControllerTest
{
    private Mock<IAuthorServices> _mockAuthorServices;
    private AuthorsController _controller;
    private Fixture _fixture;
    private Mock<HttpRequest> _mockHttpRequest;
    private Mock<HttpContext> _mockHttpContext;

    [TestInitialize]
    public void Init()
    {
        _mockAuthorServices = new();
        _controller = new(_mockAuthorServices.Object);
        _fixture = new();
        _mockHttpRequest = new Mock<HttpRequest>();
        _mockHttpContext = new Mock<HttpContext>();
    }

    [TestMethod]
    public async Task Should_Post_Return_Created()
    {
        var model = _fixture.Create<AuthorRequestDto>();

        var id = Guid.NewGuid();

        Expression<Func<IAuthorServices, Task<Guid?>>> expression = c => c.Create(model, default);

        _mockAuthorServices.Setup(expression).ReturnsAsync(id);

        MockResponseHttpRequest.Mock(model, _mockHttpRequest, _mockHttpContext, _controller, $"/v1/authors/{id}");

        var response = await _controller.Post(model);

        Assert.IsNotNull(response);
        Assert.AreEqual(typeof(CreatedResult), response.GetType());

        _mockAuthorServices.Verify(expression, Times.Once);
    }

    [TestMethod]
    public async Task Should_Post_Return_BadRequest()
    {
        var model = _fixture.Create<AuthorRequestDto>();

        Expression<Func<IAuthorServices, Task<Guid?>>> expression = c => c.Create(model, default);

        Guid? mockResponse = null;

        _mockAuthorServices.Setup(expression).ReturnsAsync(mockResponse);

        var response = await _controller.Post(model);

        Assert.IsNotNull(response);
        Assert.AreEqual(typeof(BadRequestResult), response.GetType());

        _mockAuthorServices.Verify(expression, Times.Once);
    }

    [TestMethod]
    public async Task Should_GetById_Return_Ok()
    {
        var model = _fixture.Create<AuthorResponseDto>();

        Expression<Func<IAuthorServices, Task<AuthorResponseDto>>> expression = c => c.GetById(model.Id, default);

        _mockAuthorServices.Setup(expression).ReturnsAsync(model);

        var result = await _controller.GetById(model.Id);

        Assert.IsNotNull(result);
        Assert.AreEqual(typeof(OkObjectResult), result.GetType());

        _mockAuthorServices.Verify(expression, Times.Once);
    }

    [TestMethod]
    public async Task Should_GetById_Return_NotFound()
    {
        var id = Guid.NewGuid();

        AuthorResponseDto model = null;

        Expression<Func<IAuthorServices, Task<AuthorResponseDto>>> expression = c => c.GetById(id, default);
        var result = await _controller.GetById(id);

        _mockAuthorServices.Setup(expression).ReturnsAsync(model);

        Assert.IsNotNull(result);
        Assert.AreEqual(typeof(NotFoundResult), result.GetType());

        _mockAuthorServices.Verify(expression, Times.Once);
    }

    [TestMethod]
    public async Task Should_Get_Return_Ok()
    {
        var query = new AuthorQueryParamDto();

        var response = _fixture.CreateMany<AuthorResponseDto>();

        Expression<Func<IAuthorServices, Task<IEnumerable<AuthorResponseDto>>>> expression = c => c.GetAll(It.IsAny<PaginateRequest>(), query, default);

        _mockAuthorServices.Setup(expression)
            .ReturnsAsync(response);

        var result = await _controller.Get(query, default);

        Assert.IsNotNull(result);
        Assert.AreEqual(typeof(OkObjectResult), result.GetType());

        _mockAuthorServices.Verify(expression, Times.Once);
    }

    [TestMethod]
    public async Task Should_Remove_Return_Ok()
    {
        var id = Guid.NewGuid();

        Expression<Func<IAuthorServices, Task<bool>>> expression = c => c.Remove(id, default);

        _mockAuthorServices.Setup(expression)
            .ReturnsAsync(true);

        var result = await _controller.Remove(id);

        Assert.IsNotNull(result);
        Assert.AreEqual(typeof(OkResult), result.GetType());

        _mockAuthorServices.Verify(expression, Times.Once);
    }

    [TestMethod]
    public async Task Should_Remove_Return_NotFound()
    {
        var id = Guid.NewGuid();

        Expression<Func<IAuthorServices, Task<bool>>> expression = c => c.Remove(id, default);

        
        _mockAuthorServices.Setup(expression).ReturnsAsync(false);

        var result = await _controller.Remove(id);

        Assert.IsNotNull(result);
        Assert.AreEqual(typeof(NotFoundResult), result.GetType());

        _mockAuthorServices.Verify(expression, Times.Once);
    }

    [TestMethod]
    public async Task Should_Update_Return_Ok()
    {
        var id = Guid.NewGuid();

        var model = _fixture.Create<AuthorRequestDto>();

        Expression<Func<IAuthorServices, Task<bool>>> expression = c => c.Update(id, model, default);

        _mockAuthorServices.Setup(expression)
            .ReturnsAsync(true);

        var result = await _controller.Update(id, model, default);

        Assert.IsNotNull(result);
        Assert.AreEqual(typeof(OkResult), result.GetType());

        _mockAuthorServices.Verify(expression, Times.Once);
    }

    [TestMethod]
    public async Task Should_Update_Return_BadRequest()
    {
        var id = Guid.NewGuid();

        var model = _fixture.Create<AuthorRequestDto>();

        Expression<Func<IAuthorServices, Task<bool>>> expression = c => c.Update(id, model, default);

        var result = await _controller.Update(id, model, default);

        Assert.IsNotNull(result);
        Assert.AreEqual(typeof(NotFoundResult), result.GetType());

        _mockAuthorServices.Verify(expression, Times.Once);
    }
}
