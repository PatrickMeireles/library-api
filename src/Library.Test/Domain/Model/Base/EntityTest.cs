using Library.Domain.Model.Base;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.Json.Serialization;
using System.Threading.Tasks;

namespace Library.Test.Domain.Model.Base;

[TestClass]
public class EntityTest
{
    [TestMethod]
    public void Should_Create_Using_Constructor_With_Id_CreatedAt_UpdatedAt_Parameters()
    {
        var id = Guid.NewGuid();
        var createdAt = DateTime.Now;
        var updatedAt = DateTime.Now;

        FakeEntity entity = new FakeEntity(id, createdAt, updatedAt);

        Assert.IsNotNull(entity);
        Assert.AreEqual(id, entity.Id);
        Assert.AreEqual(createdAt, entity.CreatedAt);
        Assert.AreEqual(updatedAt, entity.UpdatedAt);
    }

    [TestMethod]
    public void Should_Create_Using_Constructor_With_Id_UpdatedAt_Parameters()
    {
        var id = Guid.NewGuid();
        var updatedAt = DateTime.Now;

        FakeEntity entity = new FakeEntity(id, updatedAt);

        Assert.IsNotNull(entity);
        Assert.AreEqual(id, entity.Id);
        Assert.AreEqual(updatedAt, entity.UpdatedAt);
    }
}

public class FakeEntity : Entity
{
    [JsonConstructor]
    public FakeEntity(Guid id) : base(id)
    {
        
    }

    public FakeEntity(Guid id, DateTime updatedAt) : base(id, updatedAt)
    {
    }

    public FakeEntity(Guid id, DateTime createdAt, DateTime? updatedAt) : base(id, createdAt, updatedAt)
    {
    }
}
