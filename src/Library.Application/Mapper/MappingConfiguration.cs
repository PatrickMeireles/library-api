using Library.Domain.Command.Author;
using Library.Domain.Command.Book;
using Library.Domain.DTO.Author;
using Library.Domain.DTO.Book;
using Library.Domain.Enum;
using Library.Domain.Message.Author;
using Library.Domain.Message.Book;
using Library.Domain.Model;
using Mapster;
using Microsoft.Extensions.DependencyInjection;
using System.Reflection;

namespace Library.Application.Mapper;

public static class MappingConfiguration
{
    public static void RegisterMappings(this IServiceCollection services)
    {

        // Dto to Command
        TypeAdapterConfig<AuthorRequestDto, CreateAuthorCommand>.NewConfig();
        TypeAdapterConfig<AuthorRequestDto, UpdateAuthorCommand>.NewConfig();

        TypeAdapterConfig<BookRequestDto, CreateBookCommand>.NewConfig();
        TypeAdapterConfig<BookRequestDto, UpdateBookCommand>.NewConfig();

        // Command to Domain
        TypeAdapterConfig<CreateAuthorCommand, Author>.NewConfig()
            .MapWith(x => Author.Create(x.Id, x.Name, x.Biography, x.DateOfBirth));

        TypeAdapterConfig<UpdateAuthorCommand, Author>.NewConfig()
            .ConstructUsing(x => Author.Update(x.Id, x.Name, x.Biography, x.DateOfBirth));

        TypeAdapterConfig<CreateBookCommand, Book>.NewConfig().ConstructUsing(c => Book.Create(c.Id,
                                          c.Title,
                                          c.Description,
                                          c.YearPublication,
                                          c.Pages,
                                          (BookType)c.BookType,
                                          (Genre)c.Genre,
                                          c.Authors));

        TypeAdapterConfig<UpdateBookCommand, Book>.NewConfig().ConstructUsing(c => Book.Update(c.Id,
                                          c.Title,
                                          c.Description,
                                          c.YearPublication,
                                          c.Pages,
                                          (BookType)c.BookType,
                                          (Genre)c.Genre,
                                          c.Authors));

        // Domain To DTO
        TypeAdapterConfig<Author, AuthorResponseDto>.NewConfig();
        TypeAdapterConfig<Book, BookResponseDto>.NewConfig()
            .MapWith(c => new BookResponseDto
            {
                BookType = new((int)c.BookType, c.BookType.ToString()),
                Description = c.Description,
                Genre = new((int)c.Genre, c.Genre.ToString()),
                Id = c.Id,
                Pages = c.Pages,
                Title = c.Title,
                YearPublication = c.YearPublication,
                Authors = c.BookAuthors.Select(c => c.AuthorId)
            });

        // Domain To Message
        TypeAdapterConfig<BookAuthor, BookAuthorMessage>.NewConfig();

        TypeAdapterConfig<Book, CreateBookMessage>.NewConfig()
            .ConstructUsing(c => new CreateBookMessage()
            {
                BookAuthors = c.BookAuthors
                    .Select(c => c.Adapt<BookAuthorMessage>()).ToList(),
                BookType = c.BookType,
                CreatedAt = c.CreatedAt,
                Description = c.Description,
                Genre = c.Genre,
                Id = c.Id,
                Pages = c.Pages,
                Title = c.Title,
                UpdatedAt = c.UpdatedAt,
                YearPublication = c.YearPublication
            });

        TypeAdapterConfig<Book, UpdateBookMessage>.NewConfig()
            .ConstructUsing(c => new UpdateBookMessage()
            {
                BookAuthors = c.BookAuthors
                    .Select(c => c.Adapt<BookAuthorMessage>()).ToList(),
                BookType = c.BookType,
                CreatedAt = c.CreatedAt,
                Description = c.Description,
                Genre = c.Genre,
                Id = c.Id,
                Pages = c.Pages,
                Title = c.Title,
                UpdatedAt = c.UpdatedAt,
                YearPublication = c.YearPublication
            });

        TypeAdapterConfig<Author, CreateAuthorMessage>.NewConfig();
        TypeAdapterConfig<Author, UpdateAuthorMessage>.NewConfig();

        // Message To Domain
        TypeAdapterConfig<CreateBookMessage, Book>.NewConfig().ConstructUsing(c => Book.Create(c.Id,
                                          c.Title,
                                          c.Description,
                                          c.YearPublication,
                                          c.Pages,
                                          c.BookType,
                                          c.Genre,
                                          c.BookAuthors.Select(c => BookAuthor.Create(c.Id, c.BookId, c.AuthorId)).ToList()));

        TypeAdapterConfig<UpdateBookMessage, Book>.NewConfig().ConstructUsing(c => Book.Update(c.Id,
                                          c.Title,
                                          c.Description,
                                          c.YearPublication,
                                          c.Pages,
                                          c.BookType,
                                          c.Genre,
                                          c.BookAuthors.Select(c => BookAuthor.Create(c.Id, c.BookId, c.AuthorId)).ToList()));

        TypeAdapterConfig<CreateAuthorMessage, Author>.NewConfig()
            .ConstructUsing(x => Author.Create(x.Id, x.Name, x.Biography, x.DateOfBirth));

        TypeAdapterConfig<UpdateAuthorMessage, Author>.NewConfig()
            .ConstructUsing(x => Author.Update(x.Id, x.Name, x.Biography, x.DateOfBirth));

        TypeAdapterConfig<BookAuthorMessage, BookAuthor>.NewConfig()
            .MapWith(c => BookAuthor.Create(c.Id, c.BookId, c.AuthorId));

        TypeAdapterConfig.GlobalSettings.Scan(Assembly.GetExecutingAssembly());
    }
}
