namespace Library.Domain.Model.Base;

public abstract class AggregateRoot : Entity
{
    protected AggregateRoot(Guid id) : base(id)
    {
    }
}
