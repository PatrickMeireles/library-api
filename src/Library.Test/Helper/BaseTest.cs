using AutoFixture;

namespace Library.Test.Helper;

public class BaseTest
{
    public Fixture _fixture;

    public BaseTest()
    {
        _fixture = new Fixture();
        _fixture.Behaviors.Remove(new ThrowingRecursionBehavior());
        _fixture.Behaviors.Add(new OmitOnRecursionBehavior());
    }
}
