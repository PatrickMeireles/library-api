﻿using Library.Data.Repository.Base;
using Library.Domain.Model;

namespace Library.Data.Repository.Mongo.Interface;

public interface IAuthorMongoRepository : IRepositoryAsync<Author>
{
}
