using Library.Data.Mapping.Base;
using Library.Domain.Model;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Library.Data.Mapping;

public class BookMapping : EFMappingConfiguration<Book>, IEFMappingEntrypoint
{
    public override void BuildMapping(EntityTypeBuilder<Book> builder)
    {
        builder.Property(e => e.Title).IsRequired().HasMaxLength(50);
        builder.Property(e => e.Description).IsRequired().HasColumnType("Text");
        builder.Property(e => e.YearPublication).IsRequired();
        builder.Property(e => e.Pages).IsRequired();
        builder.Property(e => e.BookType).HasConversion(typeof(int)).IsRequired();
        builder.Property(e => e.Genre).HasConversion(typeof(int)).IsRequired();

        builder.HasMany(c => c.BookAuthors)
               .WithOne()
                .IsRequired()
                .OnDelete(DeleteBehavior.Cascade);
    }
}
