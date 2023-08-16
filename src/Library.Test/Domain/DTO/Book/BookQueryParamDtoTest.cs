using AutoFixture;
using Library.Domain.DTO.Book;

namespace Library.Test.Domain.DTO.Book;

[TestClass]
public class BookQueryParamDtoTest
{
    private readonly Fixture _fixture = new();

    [TestMethod]
    public void Should_Create_Dto()
    {
        var param = _fixture.Create<BookQueryParamDto>();

        var dto = new BookQueryParamDto()
        {
            AuthorId = param.AuthorId,
            BookType = param.BookType,
            Genre = param.Genre,
            Id = param.Id,
            Title = param.Title,
            YearPublication = param.YearPublication
        };

        Assert.IsNotNull(dto);
    }
}
