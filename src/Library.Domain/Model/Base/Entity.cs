using System.ComponentModel.DataAnnotations;

namespace Library.Domain.Model.Base;

public abstract class Entity
{
    [Key]
    public Guid Id { get; protected set; }
    public DateTime CreatedAt { get; protected set; } = DateTime.Now;
    public DateTime? UpdatedAt { get; protected set; }

    protected Entity(Guid id)
    {
        Id = id;
    }

    protected Entity(Guid id, DateTime updatedAt)
    {
        Id = id;
        UpdatedAt = updatedAt;
    }

    protected Entity(Guid id, DateTime createdAt, DateTime? updatedAt)
    {
        Id = id;
        CreatedAt = createdAt;
        UpdatedAt = updatedAt;
    }

    protected void SetUpdatedAt(DateTime updateAt)
    {
        UpdatedAt = updateAt;
    }
}
