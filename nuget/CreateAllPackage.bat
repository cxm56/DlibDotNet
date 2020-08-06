dotnet restore ..\src\DlibDotNet
dotnet build -c Release ..\src\DlibDotNet
dotnet build -c Release_Xamarin.iOS ..\src\DlibDotNet

pwsh CreatePackage.ps1 CPU
pwsh CreatePackage.ps1 CUDA-92
pwsh CreatePackage.ps1 CUDA-100
pwsh CreatePackage.ps1 CUDA-101
pwsh CreatePackage.ps1 CUDA-102
pwsh CreatePackage.ps1 MKL
pwsh CreatePackage.ps1 UWP
pwsh CreatePackage.ps1 iOS

nuget pack nuspec\DlibDotNet.Extensions.nuspec