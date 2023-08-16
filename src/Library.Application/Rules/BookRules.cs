using Library.Application.Notification;
using Library.Data.Repository.EntityFramework.Interface;
using Library.Domain.Model;
using System.Linq.Expressions;

namespace Library.Application.Rules;

public class BookRules
{
    private readonly IBookEntityFrameworkRepository _bookRepository;
    private readonly IAuthorEntityFrameworkRepository _authorRepository;
    private readonly NotificationContext _notification;

    public BookRules(IBookEntityFrameworkRepository bookRepository, IAuthorEntityFrameworkRepository authorRepository, NotificationContext notification)
    {
        _bookRepository = bookRepository;
        _notification = notification;
        _authorRepository = authorRepository;
    }

    public virtual async Task<bool> CreateIsValidAsync(Book param, CancellationToken cancellationToken = default)
    {
        if (await ExistBook(c => c.Title == param.Title, cancellationToken))
        {
            _notification.AddNotification("", $"Cannot register {param.Title} as a Book because already exist.");
            return await Task.FromResult(false);
        }

        if (!await ExistAuthors(param.BookAuthors.Select(c => c.AuthorId).ToArray(), cancellationToken))
        {
            _notification.AddNotification("", $"Cannot register {param.Title} as a Book because not found Author.");
            return await Task.FromResult(false);
        }

        return await Task.FromResult(true);
    }

    public virtual async Task<bool> UpdateIsValidAsync(Book param, CancellationToken cancellationToken = default)
    {
        if (await ExistBook(c => c.Title == param.Title && c.Id != param.Id, cancellationToken))
        {
            _notification.AddNotification("", $"Cannot register {param.Title} as a Book because already exist.");

            return await Task.FromResult(false);
        }

        if (!await ExistAuthors(param.BookAuthors.Select(c => c.AuthorId).ToArray(), cancellationToken))
        {
            _notification.AddNotification("", $"Cannot register {param.Title} as Book because not found Author.");
            return await Task.FromResult(false);
        }

        return await Task.FromResult(true);
    }

    private async Task<bool> ExistAuthors(Guid[] ids, CancellationToken cancellationToken)
    {
        var authors = await _authorRepository.Get(c => ids.Contains(c.Id), page: 1, pageSize: 1, cancellationToken: cancellationToken);

        if (authors == null || !authors.Any() || authors.Count() != ids.Length)
            return await Task.FromResult(false);

        return await Task.FromResult(true);
    }

    private async Task<bool> ExistBook(Expression<Func<Book, bool>> expression, CancellationToken cancellationToken = default)
    {
        var result = await _bookRepository.Get(expression, page: 1, pageSize: 1, cancellationToken: cancellationToken);

        return result.Any();
    }
}
