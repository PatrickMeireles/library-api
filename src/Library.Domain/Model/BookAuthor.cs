using Library.Domain.Model.Base;
using System.Text.Json.Serialization;

namespace Library.Domain.Model;

public class BookAuthor : Entity
{
    public Guid BookId { get; init; }
    public Guid AuthorId { get; init; }

    public Book Book { get; init; } = null!;
    public Author Author { get; init; } = null!;

    protected BookAuthor(Guid id, Guid bookId, Guid authorId) : base(id)
    {
        BookId = bookId;
        AuthorId = authorId;
    }

    public static BookAuthor Create(Guid id, Guid bookId, Guid authorId) =>
        new (id, bookId, authorId);

    [JsonConstructor]
    public BookAuthor(Guid id) : base(id)
    {

    }
}
