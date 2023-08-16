using Library.Application.Notification;
using Library.Data.Context;
using Library.Infrastructure.Event.Base;
using Library.Test.Helper;
using Moq;
using System.Linq.Expressions;

namespace Library.Test.Application.Handler
{
    [TestClass]
    public class CommandHandlerTest
    {
        private Mock<IContext> _mockContext;
        private Mock<DomainHandler> _mockDomainHandler;
        private Mock<NotificationContext> _mockNotificationContext;
        private FakeCommandHandler _commandHandler;

        [TestInitialize]
        public void Init()
        {
            _mockContext = new();
            _mockDomainHandler = new();
            _mockNotificationContext = new();

            _commandHandler = new(_mockContext.Object, _mockDomainHandler.Object, _mockNotificationContext.Object);
        }

        [TestMethod]
        public async Task Should_CommitAsync_Return_True()
        {
            Expression<Func<IContext, Task<bool>>> contextExpression = c =>
                c.CommitAsync(It.IsAny<CancellationToken>());

            _mockContext.Setup(contextExpression).ReturnsAsync(true);

            var result = await _commandHandler.CallCommit();

            Assert.IsTrue(result);

            _mockContext.Verify(contextExpression, Times.Once);
            _mockNotificationContext.Verify(c => c.AddNotification(It.IsAny<string>(), It.IsAny<string>()), Times.Never);
        }

        [TestMethod]
        public async Task Should_CommitAsync_Return_False()
        {
            Expression<Func<IContext, Task<bool>>> contextExpression = c =>
                c.CommitAsync(It.IsAny<CancellationToken>());

            _mockContext.Setup(contextExpression).ThrowsAsync(new Exception());

            var result = await _commandHandler.CallCommit();

            Assert.IsFalse(result);

            _mockContext.Verify(contextExpression, Times.Once);
            _mockNotificationContext.Verify(c => c.AddNotification(It.IsAny<string>(), It.IsAny<string>()), Times.Once);
        }

        [TestMethod]
        public void Should_Add_Event()
        {
            var @event = new FakeEvent();

            _commandHandler.CallAddEvent(@event);

            _mockDomainHandler.Verify(c => c.AddEvent(It.IsAny<DomainEvent>()), Times.Once);
        }
    }
}
