dotnet restore ..\src\DlibDotNet
dotnet build -c Release ..\src\DlibDotNet
dotnet build -c Release_Xamarin.iOS ..\src\DlibDotNet
dotnet build -c Release ..\src\DlibDotNet.Extensions