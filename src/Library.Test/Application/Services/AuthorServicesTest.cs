using AutoFixture;
using Library.Application.Services;
using Library.Data.Cache;
using Library.Data.Repository.Mongo.Interface;
using Library.Domain.Command.Author;
using Library.Domain.DTO.Author;
using Library.Domain.DTO.Base;
using Library.Domain.Model;
using Mapster;
using MediatR;
using Moq;
using System.Linq.Expressions;

namespace Library.Test.Application.Services;

[TestClass]
public class AuthorServicesTest
{
    private Mock<IMediator> _mockMediator;
    private Mock<IAuthorMongoRepository> _mockAuthorMongoRepository;
    private Mock<ICacheService> _mockCacheService;
    private AuthorServices _services;
    private Fixture _fixture;


    [TestInitialize]
    public void Init() 
    {
        _fixture = new();
        _mockMediator = new();
        _mockAuthorMongoRepository = new();
        _mockCacheService = new();
        _services = new(_mockMediator.Object, _mockAuthorMongoRepository.Object, _mockCacheService.Object);
    }

    [TestMethod]
    public async Task Should_Create_Return_Guid()
    {
        var param = _fixture.Create<AuthorRequestDto>();

        var mockResult = new CommandReturnDto();
        mockResult.Successfully();

        var expression = SendExpression();

        _mockMediator.Setup(expression)
            .ReturnsAsync(mockResult);

        var result = await _services.Create(param, default);

        Assert.IsNotNull(result);
        Assert.AreNotEqual(Guid.Empty, result);

        _mockMediator.Verify(expression, Times.Once);
    }

    [TestMethod]
    public async Task Should_Create_Return_Null()
    {
        var param = _fixture.Create<AuthorRequestDto>();

        var mockResult = new CommandReturnDto();
        mockResult.Unsuccessfully();

        var expression = SendExpression();

        _mockMediator.Setup(expression)
            .ReturnsAsync(mockResult);

        var result = await _services.Create(param, default);

        Assert.IsNull(result);
        Assert.AreNotEqual(Guid.Empty, result);

        _mockMediator.Verify(expression, Times.Once);
    }

    [TestMethod]
    public async Task Should_GetById_Return_Ok()
    {
        var id = Guid.NewGuid();

        var mockResult = new CommandReturnDto();
        mockResult.Successfully();

        var mockAuthor = _fixture.Create<Author>();

        var mockResponse = mockAuthor.Adapt<AuthorResponseDto>();

        var expression = GetByIdExpression(id);

        _mockAuthorMongoRepository.Setup(expression).ReturnsAsync(mockAuthor);

        var result = await _services.GetById(id, default);

        Assert.IsNotNull(result);
        Assert.AreEqual(mockAuthor.Id, mockResponse.Id);

        _mockAuthorMongoRepository.Verify(expression, Times.Once);
        _mockCacheService.Verify(GetCacheExpression, Times.Once);
        _mockCacheService.Verify(SetCacheExpression, Times.Once);
    }

    [TestMethod]
    public async Task Should_GetById_Return_Ok_FromCache()
    {
        var id = Guid.NewGuid();

        var mockResult = new CommandReturnDto();
        mockResult.Successfully();

        var mockAuthor = _fixture.Create<Author>();

        var mockResponse = mockAuthor.Adapt<AuthorResponseDto>();

        _mockCacheService.Setup(GetCacheExpression).Returns(Task.FromResult(mockAuthor));

        var expression = GetByIdExpression(id);

        var result = await _services.GetById(id, default);

        Assert.IsNotNull(result);
        Assert.AreEqual(mockAuthor.Id, mockResponse.Id);

        _mockAuthorMongoRepository.Verify(expression, Times.Never);
        _mockCacheService.Verify(GetCacheExpression, Times.Once);
        _mockCacheService.Verify(SetCacheExpression, Times.Never);
    }

    [TestMethod]
    public async Task Should_GetById_Return_Null()
    {
        var id = Guid.NewGuid();

        var mockResult = new CommandReturnDto();
        mockResult.Successfully();

        var mockAuthor = _fixture.Create<Author>();

        var mockResponse = mockAuthor.Adapt<AuthorResponseDto>();

        var expression = GetByIdExpression(id);

        var result = await _services.GetById(id, default);

        Assert.IsNull(result);

        _mockAuthorMongoRepository.Verify(expression, Times.Once);
    }

    [TestMethod]
    public async Task Should_GetAll_Return_Ok()
    {
        int count = 5;

        var paginate = new PaginateRequest(1, 20);
        var param = new AuthorQueryParamDto();

        var mockResponse = _fixture.CreateMany<Author>(count);

        var expression = GetExpression(paginate.Page, paginate.Size);

        _mockAuthorMongoRepository.Setup(expression).ReturnsAsync(mockResponse);

        var result = await _services.GetAll(paginate, param, default);

        Assert.IsNotNull(result);
        Assert.IsTrue(result.Any());
        Assert.AreEqual(count, result.Count());

        _mockAuthorMongoRepository.Verify(expression, Times.Once);
    }

    [TestMethod]
    public async Task Should_Get_All_Return_Empty()
    {
        var paginate = new PaginateRequest(1, 20);
        var param = new AuthorQueryParamDto();

        var expression = GetExpression(paginate.Page, paginate.Size);

        _mockAuthorMongoRepository.Setup(expression).ReturnsAsync((List<Author>)null);

        var result = await _services.GetAll(paginate, param, default);

        Assert.IsNotNull(result);
        Assert.IsFalse(result.Any());
        Assert.AreEqual(0, result.Count());

        _mockAuthorMongoRepository.Verify(expression, Times.Once);
    }

    [TestMethod]
    public async Task Should_Remove_Return_True()
    {
        var param = new RemoveAuthorCommand(Guid.NewGuid());

        var mockResult = new CommandReturnDto();
        mockResult.Successfully();

        var expression = SendExpression();

        _mockMediator.Setup(expression).ReturnsAsync(mockResult);

        var result = await _services.Remove(param.Id);

        Assert.IsNotNull(result);
        Assert.IsTrue(result);

        _mockMediator.Verify(expression, Times.Once);
    }

    [TestMethod]
    public async Task Should_Remove_Return_False()
    {
        var param = new RemoveAuthorCommand(Guid.NewGuid());

        var mockResult = new CommandReturnDto();

        var expression = SendExpression();

        _mockMediator.Setup(expression).ReturnsAsync(mockResult);

        var result = await _services.Remove(param.Id);

        Assert.IsNotNull(result);
        Assert.IsFalse(result);

        _mockMediator.Verify(expression, Times.Once);
    }

    [TestMethod]
    public async Task Should_Update_Return_True()
    {
        var param = _fixture.Create<AuthorRequestDto>();

        var mockResult = new CommandReturnDto();
        mockResult.Successfully();

        var expression = SendExpression();

        _mockMediator.Setup(expression)
            .ReturnsAsync(mockResult);

        var result = await _services.Update(Guid.NewGuid(), param, default);

        Assert.IsNotNull(result);

        _mockMediator.Verify(expression, Times.Once);
    }

    [TestMethod]
    public async Task Should_Update_Return_False()
    {
        var param = _fixture.Create<AuthorRequestDto>();

        var mockResult = new CommandReturnDto();

        var expression = SendExpression();

        _mockMediator.Setup(expression)
            .ReturnsAsync(mockResult);

        var result = await _services.Update(Guid.NewGuid(), param, default);

        Assert.IsNotNull(result);

        _mockMediator.Verify(expression, Times.Once);
    }

    [TestMethod]
    public void Should_Dispose()
    {
        var dispose = _services.DisposeAsync();

        Assert.IsNotNull(dispose);
    }

    private static Expression<Func<IMediator, Task<CommandReturnDto>>> SendExpression() =>  c => 
        c.Send(It.IsAny<IRequest<CommandReturnDto>>(), It.IsAny<CancellationToken>());

    private static Expression<Func<IAuthorMongoRepository, Task<IEnumerable<Author>>>> GetExpression(int page, int size) =>
            c => c.Get(It.IsAny<Expression<Func<Author, bool>>>(), page, size, default);

    private static Expression<Func<IAuthorMongoRepository, Task<Author>>> GetByIdExpression(Guid id) =>
            c => c.GetById(id, default);

    private static Expression<Func<ICacheService, Task>> GetCacheExpression =>
        c => c.GetAsync<Author>(It.IsAny<string>(), It.IsAny<CancellationToken>());

    private static Expression<Func<ICacheService, Task>> SetCacheExpression =>
        c => c.SetAsync<Author>(It.IsAny<string>(), It.IsAny<Author>(), It.IsAny<CancellationToken>());
}

