using Library.Domain.Model.Base;

namespace Library.Test.Helper;

public class FakeAggregateRoot : AggregateRoot
{
    public FakeAggregateRoot(Guid id) : base(id)
    {
    }
}
