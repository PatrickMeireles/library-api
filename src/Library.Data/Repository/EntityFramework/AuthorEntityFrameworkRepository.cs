using Library.Data.Repository.Base;
using Library.Data.Repository.EntityFramework.Interface;
using Library.Domain.Model;
using Library.Infrastructure.Data.EF;

namespace Library.Data.Repository.EntityFramework;

public class AuthorEntityFrameworkRepository : EntityFrameworkRepositoryAsync<Author>, IAuthorEntityFrameworkRepository
{
    public AuthorEntityFrameworkRepository(EntityFrameworkContext context) : base(context)
    {
    }
}
