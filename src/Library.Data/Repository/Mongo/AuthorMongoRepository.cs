using Library.Data.Repository.Base;
using Library.Data.Repository.Mongo.Interface;
using Library.Domain.Model;
using Library.Infrastructure.Data.Mongo;

namespace Library.Data.Repository.Mongo;

public class AuthorMongoRepository : MongoRepositoryAsync<Author>, IAuthorMongoRepository
{
    public AuthorMongoRepository(MongoDbContext mongoContext) : base(mongoContext)
    {
    }
}
