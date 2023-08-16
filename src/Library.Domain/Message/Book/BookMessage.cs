using Library.Domain.Enum;

namespace Library.Domain.Message.Book;

public class BookMessage
{
    public Guid Id { get; set; }
    public string Title { get; set; } = "";
    public string Description { get; set; } = "";
    public int YearPublication { get; set; }
    public int Pages { get; set; }
    public BookType BookType { get; set; }
    public Genre Genre { get; set; }
    public List<BookAuthorMessage> BookAuthors { get; set; } = new List<BookAuthorMessage>();
    public DateTime CreatedAt { get; set; }
    public DateTime? UpdatedAt { get; set; }

    public BookMessage()
    {

    }
}
