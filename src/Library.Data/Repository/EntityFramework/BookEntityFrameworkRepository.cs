using Library.Data.Repository.Base;
using Library.Data.Repository.EntityFramework.Interface;
using Library.Domain.Model;
using Library.Infrastructure.Data.EF;

namespace Library.Data.Repository.EntityFramework;

public class BookEntityFrameworkRepository : EntityFrameworkRepositoryAsync<Book>, IBookEntityFrameworkRepository
{
    public BookEntityFrameworkRepository(EntityFrameworkContext context) : base(context)
    {
    }
}
