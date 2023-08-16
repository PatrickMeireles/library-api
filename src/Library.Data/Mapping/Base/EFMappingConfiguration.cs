using Library.Domain.Model.Base;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Library.Data.Mapping.Base;

public abstract class EFMappingConfiguration<T> : IEntityTypeConfiguration<T> where T : Entity
{
    public void Configure(EntityTypeBuilder<T> builder)
    {
        builder.HasKey(x => x.Id);


        builder.Property(c => c.CreatedAt).IsRequired();
        builder.Property(c => c.UpdatedAt).IsRequired(false);
    }

    public abstract void BuildMapping(EntityTypeBuilder<T> builder);
}
