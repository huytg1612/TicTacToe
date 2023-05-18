FROM mcr.microsoft.com/dotnet/sdk:3.1 as build
WORKDIR /src
COPY ./TicTacToe.csproj ./
RUN dotnet restore TicTacToe.csproj
COPY ./ ./
RUN dotnet build -c Release -o /app/build

FROM build as publish
RUN dotnet publish -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:3.1 as final
WORKDIR /app
EXPOSE 80
EXPOSE 443
COPY --from=publish /app/publish .
ENTRYPOINT [ "dotnet", "TicTacToe.dll" ]