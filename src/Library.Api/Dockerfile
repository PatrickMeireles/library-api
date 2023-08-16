#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["Library.Api/Library.Api.csproj", "Library.Api/"]
COPY ["Library.Application/Library.Application.csproj", "Library.Application/"]
COPY ["Library.Data/Library.Data.csproj", "Library.Data/"]
COPY ["Library.Domain/Library.Domain.csproj", "Library.Domain/"]
COPY ["Library.Infrastructure/Library.Infrastructure.csproj", "Library.Infrastructure/"]
COPY ["Library.Infrastructure.Worker/Library.Infrastructure.Worker.csproj", "Library.Infrastructure.Worker/"]
RUN dotnet restore "Library.Api/Library.Api.csproj"
COPY . .
WORKDIR "/src/Library.Api"
RUN dotnet build "Library.Api.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Library.Api.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Library.Api.dll"]