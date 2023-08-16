using Library.Data.Repository.Base;
using Library.Domain.Model;

namespace Library.Data.Repository.EntityFramework.Interface;

public interface IAuthorEntityFrameworkRepository : IRepositoryAsync<Author>
{
}
