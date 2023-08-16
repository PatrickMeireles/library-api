using Library.Domain.DTO.Base;

namespace Library.Test.Domain.DTO;

[TestClass]
public class PaginateRequestTest
{
    [TestMethod]
    [DataRow(1, 20)]
    [DataRow(-1, 20)]
    [DataRow(1, 100)]
    [DataRow(-100, 1000)]
    public void Should_Return_Paginate(int page, int size)
    {
        var paginateRequest = new PaginateRequest(page, size);

        Assert.IsNotNull(paginateRequest);
    }

    [TestMethod]
    public void Should_Return_Default()
    {
        var paginateRequest = PaginateRequest.Default;

        Assert.IsNotNull (paginateRequest);
        Assert.AreEqual(1, paginateRequest.Page);
        Assert.AreEqual(50, paginateRequest.Size);
    }
}
