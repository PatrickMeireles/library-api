using Library.Domain.Enum;
using Library.Domain.Model.Base;

namespace Library.Domain.Model;

public class Book : AggregateRoot
{
    public string Title { get; init; } = "";
    public string Description { get; init; } = "";
    public int YearPublication { get; init; }
    public int Pages { get; init; }
    public BookType BookType { get; init; }
    public Genre Genre { get; init; }
    public ICollection<BookAuthor> BookAuthors { get; init; } = new List<BookAuthor>();

    public Book(Guid id) : base(id)
    {
    }

    protected Book(Guid id, string title, string description, int yearPublication, int pages, BookType bookType, Genre genre, ICollection<BookAuthor> bookAuthors) : base(id)
    {
        Title = title;
        Description = description;
        YearPublication = yearPublication;
        Pages = pages;
        BookType = bookType;
        Genre = genre;
        BookAuthors = bookAuthors;
    }

    public static Book Create(Guid id, string title, string description, int yearPublication, int pages, BookType bookType, Genre genre, ICollection<BookAuthor> bookAuthors)
    {
        return new(id, title, description, yearPublication, pages, bookType, genre, bookAuthors);
    }

    public static Book Create(Guid id, string title, string description, int yearPublication, int pages, BookType bookType, Genre genre, ICollection<Guid> authors)
    {
        var book = new Book(id,
            title,
            description,
            yearPublication,
            pages,
            bookType,
            genre,
            authors.Select(authorId =>
                    BookAuthor.Create(Guid.NewGuid(),
                                    id,
                                    authorId))
                    .ToList());

        return book;
    }
    public static Book Update(Guid id, string title, string description, int yearPublication, int pages, BookType bookType, Genre genre, ICollection<BookAuthor> bookAuthors)
    {
        var book = new Book(id, title, description, yearPublication, pages, bookType, genre, bookAuthors);
        book.SetUpdatedAt(DateTime.UtcNow);

        return book;
    }
    public static Book Update(Guid id, string title, string description, int yearPublication, int pages, BookType bookType, Genre genre, ICollection<Guid> authors)
    {
        var book = new Book(id,
            title,
            description,
            yearPublication,
            pages,
            bookType,
            genre,
            authors.Select(authorId =>
                    BookAuthor.Create(Guid.NewGuid(),
                                    id,
                                    authorId))
                    .ToList());

        book.SetUpdatedAt(DateTime.UtcNow);

        return book;
    }

    public void AddAuthors(BookAuthor bookAuthor) =>
        BookAuthors.Add(bookAuthor);
}
