Param()

# import class and function
$ScriptPath = $PSScriptRoot
$DlibDotNetRoot = Split-Path $ScriptPath -Parent
$NugetPath = Join-Path $DlibDotNetRoot "nuget" | `
             Join-Path -ChildPath "BuildUtils.ps1"
import-module $NugetPath -function *

$OperatingSystem="ios"

# Store current directory
$Current = Get-Location
$DlibDotNetRoot = (Split-Path (Get-Location) -Parent)
$DlibDotNetSourceRoot = Join-Path $DlibDotNetRoot src

$BuildSourceHash = [Config]::GetBinaryLibraryIOSHash()

$BuildTargets = @()
# $BuildTargets += New-Object PSObject -Property @{ Platform = "ios"; Target = "arm";   Architecture = 64; RID = "$OperatingSystem-arm64";             iOSPlatform = "OS64" }
$BuildTargets += New-Object PSObject -Property @{ Platform = "ios"; Target = "arm";   Architecture = 64; RID = "$OperatingSystem-arm64-simulator"; iOSPlatform = "SIMULATOR64" }
$BuildTargets += New-Object PSObject -Property @{ Platform = "ios"; Target = "arm";   Architecture = 64; RID = "$OperatingSystem-arm64";           iOSPlatform = "OS64" }

foreach($BuildTarget in $BuildTargets)
{
   $target = $BuildTarget.Target
   $architecture = $BuildTarget.Architecture
   $rid = $BuildTarget.RID
   $option = $BuildTarget.iOSPlatform

   $Config = [Config]::new($DlibDotNetRoot, "Release", $target, $architecture, "ios", $option)
   $libraryDir = Join-Path "artifacts" $Config.GetArtifactDirectoryName()
   $build = $Config.GetBuildDirectoryName("")

   foreach ($key in $BuildSourceHash.keys)
   {
      $srcDir = Join-Path $DlibDotNetSourceRoot $key

      # Move to build target directory
      Set-Location -Path $srcDir

      $arc = $Config.GetArchitectureName()
      Write-Host "Build $key [$arc] for $target" -ForegroundColor Green
      Build -Config $Config

      if ($lastexitcode -ne 0)
      {
         Set-Location -Path $Current
         exit -1
      }
   }
  
   # Copy output binary
   foreach ($key in $BuildSourceHash.keys)
   {
      $srcDir = Join-Path $DlibDotNetSourceRoot $key
      $dll = $BuildSourceHash[$key]
      $dstDir = Join-Path $Current $libraryDir

      # ios/runtimes/ios-arm64/native/libDlibDotNetNativeDnn.a
      switch($option.ToLower())
      {
         "os64"
         {
            CopyiOSToArtifact -configuration "Release-iphoneos" `
                              -srcDir $srcDir `
                              -build $build `
                              -libraryName $dll `
                              -dstDir $dstDir `
                              -platform "ios"
         }
         "simulator64"
         {
            CopyiOSToArtifact -configuration "Release-iphonesimulator" `
                              -srcDir $srcDir `
                              -build $build `
                              -libraryName $dll `
                              -dstDir $dstDir `
                              -platform "ios-simulator"
         }
         "combined"
         {
            CopyiOSToArtifact -configuration "Release-iphoneos" `
                              -srcDir $srcDir `
                              -build $build `
                              -libraryName $dll `
                              -dstDir $dstDir `
                              -platform "ios-combined"
         }
      }
   }
}

# Move to Root directory 
Set-Location -Path $Current