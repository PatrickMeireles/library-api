using AutoFixture;
using Library.Infrastructure.Helper;
using Library.Test.Helper;
using MediatR;
using Moq;
using System.Linq.Expressions;

namespace Library.Test.Infrastructure.Helper;

[TestClass]
public class MediatorExtensionTest
{
    private readonly Fixture _fixture = new();

    [TestMethod]
    public async Task Should_DispatchDomainEvents()
    {
        Mock<IMediator> _mockMediatr = new();

        var events = _fixture.CreateMany<FakeDomainEvent>(1);

        _mockMediatr.Setup(publishExpression).Returns(Task.CompletedTask);

        await MediatorExtension.DispatchDomainEvents(_mockMediatr.Object, events, default);

        _mockMediatr.Verify(publishExpression, Times.Exactly(events.Count()));
    }

    private static Expression<Func<IMediator, Task>> publishExpression = c =>
        c.Publish(It.IsAny<INotification>(), It.IsAny<CancellationToken>());
}


