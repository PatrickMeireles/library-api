using Library.Data.Repository.Base;
using Library.Data.Repository.Mongo.Interface;
using Library.Domain.Model;
using Library.Infrastructure.Data.Mongo;

namespace Library.Data.Repository.Mongo;

public class BookMongoRepository : MongoRepositoryAsync<Book>, IBookMongoRepository
{
    public BookMongoRepository(MongoDbContext mongoContext) : base(mongoContext)
    {
    }
}
