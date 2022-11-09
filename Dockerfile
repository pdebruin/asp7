# https://github.com/dotnet/dotnet-docker/blob/main/samples/aspnetapp/Dockerfile.alpine-x64
FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /source

COPY web/*.csproj .
RUN dotnet restore -r linux-musl-x64

COPY web/. .
RUN dotnet publish -c Release -o /app -r linux-musl-x64 --self-contained false --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:7.0-alpine-amd64
WORKDIR /app
COPY --from=build /app .

ENTRYPOINT ["./web"]