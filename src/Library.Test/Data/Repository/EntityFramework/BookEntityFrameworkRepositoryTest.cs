using Library.Data.Repository.EntityFramework;
using Library.Infrastructure.Data.EF;
using Moq;

namespace Library.Test.Data.Repository.EntityFramework;

[TestClass]
public class BookEntityFrameworkRepositoryTest
{
    [TestMethod]
    public void Should_Create_Repository()
    {
        var context = new Mock<EntityFrameworkContext>();

        var repository = new BookEntityFrameworkRepository(context.Object);

        Assert.IsNotNull(repository);
    }
}
