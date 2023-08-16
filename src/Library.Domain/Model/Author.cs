using Library.Domain.Model.Base;

namespace Library.Domain.Model;

public class Author : AggregateRoot
{
    public string Name { get; init; } = string.Empty;
    public string Biography { get; init; } = string.Empty;
    public DateTime DateOfBirth { get; init; }

    public ICollection<BookAuthor> BookAuthors { get; private set; } = new List<BookAuthor>();

    public Author(Guid id) : base(id)
    {
    }

    protected Author(Guid id, string name, string biography, DateTime dateOfBirth) : base(id)
    {
        Name = name;
        Biography = biography;
        DateOfBirth = dateOfBirth;
    }

    public static Author Create(Guid id, string name, string biography, DateTime dateOfBirth)
    {
        var author = new Author(id, name, biography, dateOfBirth);

        return author;
    }

    public static Author Update(Guid id, string name, string biography, DateTime dateOfBirth)
    {
        var author = new Author(id, name, biography, dateOfBirth);
        author.SetUpdatedAt(DateTime.Now);

        return author;
    }
}
