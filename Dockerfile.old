FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /app

COPY *.sln .
COPY web/*.csproj ./web/
RUN dotnet restore -r linux-musl-x64

COPY web/. ./web/
WORKDIR /app/web
RUN dotnet publish -c Release -o out -r linux-musl-x64 --self-contained false --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:7.0-alpine-amd64
WORKDIR /app
COPY --from=build /app/web/out ./

ENTRYPOINT ["dotnet", "web.dll"]