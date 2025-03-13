FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 5264

ENV ASPNETCORE_URLS=http://+:5264

USER app
FROM --platform=$BUILDPLATFORM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG configuration=Release
WORKDIR /src
COPY ["src/poc.keycloak.api/poc.keycloak.api.csproj", "poc.keycloak.api/"]
RUN dotnet restore "./poc.keycloak.api/poc.keycloak.api.csproj"
COPY . .


RUN dotnet build "src/poc.keycloak.api/poc.keycloak.api.csproj" -c $configuration -o /app/build

FROM build AS publish
ARG configuration=Release
RUN dotnet publish "src/poc.keycloak.api/poc.keycloak.api.csproj" -c $configuration -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "poc.keycloak.api.dll"]
