FROM mcr.microsoft.com/dotnet/sdk:6.0 AS sdk
WORKDIR /opt/dotnet/src/

COPY ./ ./
RUN dotnet restore
RUN dotnet build --no-restore -c Release
RUN dotnet publish --no-build -c Release -o ../artifacts/

FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /opt/dotnet/
COPY --from=sdk /opt/dotnet/artifacts/ ./
ENTRYPOINT ["dotnet", "api.dll"]
