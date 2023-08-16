using AutoFixture;
using Library.Infrastructure.Event.Base;
using Library.Test.Helper;

namespace Library.Test.Infrastructure.Event.Base;

[TestClass]
public class DomainHandlerTest
{
    private Fixture _fixture = new();

    [TestMethod]
    [DataRow(2)]
    [DataRow(5)]
    public void Should_Add_Event(int count)
    {
        DomainHandler handler = new DomainHandler();

        var domainEvents = _fixture.CreateMany<FakeDomainEvent>(count);

        foreach (var domainEvent in domainEvents)
            handler.AddEvent(domainEvent);

        var handlerDomainEvents = handler.DomainEvents;

        Assert.IsTrue(handlerDomainEvents.Any());
        Assert.AreEqual(count, handlerDomainEvents.Count);
    }

    [TestMethod]
    [DataRow(10)]
    public void Should_Clear_Events(int count)
    {
        DomainHandler handler = new DomainHandler();

        var domainEvents = _fixture.CreateMany<FakeDomainEvent>(count);

        foreach (var domainEvent in domainEvents)
            handler.AddEvent(domainEvent);

        handler.ClearEvents();

        var handlerDomainEvents = handler.DomainEvents;

        Assert.IsFalse(handlerDomainEvents.Any());
        Assert.AreEqual(0, handlerDomainEvents.Count);
    }
}
