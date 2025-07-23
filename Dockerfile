FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build

WORKDIR /app

COPY . .

WORKDIR /app/hello-world-api

RUN dotnet restore hello-world-api.csproj

RUN dotnet publish hello-world-api.csproj -c Release -o /app/out

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS runtime

WORKDIR /app

COPY --from=build /app/out ./

ENTRYPOINT ["dotnet", "hello-world-api.dll"]
