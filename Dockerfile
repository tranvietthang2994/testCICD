# Giai đoạn 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /source

# Copy và restore dependencies
COPY *.csproj .
RUN dotnet restore

# Copy toàn bộ source code và publish
COPY . .
RUN dotnet publish -c Release -o /app/publish

# Giai đoạn 2: Chạy
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/publish .

# Mặc định .NET 8 chạy ở port 8080
EXPOSE 8080

# Thay "YourProjectName.dll" bằng tên file .dll chính của bạn
ENTRYPOINT ["dotnet", "YourProjectName.dll"]