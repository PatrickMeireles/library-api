using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Moq;
using System.Text;
using System.Text.Json;

namespace Library.Test.Helper
{
    public static class MockResponseHttpRequest
    {
        public static void Mock<TValue>(TValue value, Mock<HttpRequest> _mockHttpRequest, Mock<HttpContext> _mockHttpContext, ControllerBase controller, string pathResponse)
        {
            var json = JsonSerializer.Serialize(value);

            var stream = new MemoryStream(Encoding.UTF8.GetBytes(json));

            _mockHttpRequest.Setup(x => x.Body).Returns(stream);
            _mockHttpRequest.Setup(x => x.HttpContext).Returns(_mockHttpContext.Object);
            _mockHttpContext.Setup(x => x.Request).Returns(_mockHttpRequest.Object);
            _mockHttpRequest.Setup(x => x.Path).Returns(pathResponse);

            controller.ControllerContext = new ControllerContext()
            {
                HttpContext = _mockHttpContext.Object
            };
        }
    }
}
