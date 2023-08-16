using Library.Application.Handler.Author;
using Library.Application.Handler.Book;
using Library.Application.Mapper;
using Library.Application.Notification;
using Library.Application.Rules;
using Library.Application.Services;
using Library.Application.Services.Interface;
using Library.Domain.Command.Author;
using Library.Domain.Command.Book;
using Library.Domain.DTO.Base;
using MediatR;
using Microsoft.Extensions.DependencyInjection;

namespace Library.Application
{
    public static class Configure
    {
        public static void ConfigureApplication(this IServiceCollection services)
        {
            services.RegisterMappings();

            services.ConfigureServices();
            services.ConfigureHandlers();
            services.ConfigureRules();
            services.AddScoped<NotificationContext>();
        }

        private static void ConfigureServices(this IServiceCollection services)
        {
            services.AddScoped<IBookServices, BookServices>();
            services.AddScoped<IAuthorServices, AuthorServices>();
        }

        private static void ConfigureHandlers(this IServiceCollection services)
        {
            services.AddScoped<IRequestHandler<CreateBookCommand, CommandReturnDto>, CreateBookHandler>();
            services.AddScoped<IRequestHandler<RemoveBookCommand, CommandReturnDto>, RemoveBookHandler>();
            services.AddScoped<IRequestHandler<UpdateBookCommand, CommandReturnDto>, UpdateBookHandler>();

            services.AddScoped<IRequestHandler<CreateAuthorCommand, CommandReturnDto>, CreateAuthorHandler>();
            services.AddScoped<IRequestHandler<RemoveAuthorCommand, CommandReturnDto>, RemoveAuthorHandler>();
            services.AddScoped<IRequestHandler<UpdateAuthorCommand, CommandReturnDto>, UpdateAuthorHandler>();
        }

        private static void ConfigureRules(this IServiceCollection services)
        {
            services.AddScoped<AuthorRules>();
            services.AddScoped<BookRules>();
        }
    }
}
