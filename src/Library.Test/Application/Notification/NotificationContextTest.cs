using AutoFixture;
using Library.Application.Notification;

namespace Library.Test.Application.Notification;

[TestClass]
public class NotificationContextTest
{
    private Fixture _fixture;

    [TestInitialize]
    public void Init()
    {
        _fixture = new();
    }

    [TestMethod]
    [DataRow(1)]
    [DataRow(5)]
    [DataRow(10)]
    public void Should_Add_Notification_With_Notification_Object(int count)
    {
        var context = new NotificationContext();

        var notifications = _fixture.CreateMany<Library.Application.Notification.Notification>(count);

        foreach(var notification in notifications)
            context.AddNotification(notification);

        Assert.IsNotNull(context);
        Assert.IsTrue(context.HasNotifications);
        Assert.AreEqual(count, context.Notifications.Count);
    }

    [TestMethod]
    [DataRow(1)]
    [DataRow(5)]
    [DataRow(10)]
    public void Should_Add_Notification_With_String_Parameter(int count)
    {
        var context = new NotificationContext();

        var notifications = _fixture.CreateMany<Library.Application.Notification.Notification>(count);

        foreach (var notification in notifications)
            context.AddNotification(notification.Key, notification.Message);

        Assert.IsNotNull(context);
        Assert.IsTrue(context.HasNotifications);
        Assert.AreEqual(count, context.Notifications.Count);
    }
}
