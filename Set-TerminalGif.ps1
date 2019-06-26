$TerminalProfileSettings = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\RoamingState\profiles.json"
$GifFolder = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\Gifs"

Function Test-GifPath{
    param(
        [Parameter(Mandatory=$true,
        ValueFromPipelineByPropertyName=$true,
        Position=0)]
        [String]
        $FolderName
    )
    if(!(Test-Path $FolderName)){
        #Folder Does not exist - create
        New-Item -ItemType Directory -Path $FolderName
        return $true
    }
    else{
        return $true
    }

}

Function Get-RandomGif{
    param(
        [Parameter(Mandatory=$true,
        ValueFromPipelineByPropertyName=$true,
        Position=0)]
        [String]
        $FolderName
    )

    [Array]$Gifs = Get-ChildItem -Path $GifFolder -Include "*.gif" -Recurse



    if($Gifs.Length -gt 0){
        return ($Gifs[(Get-Random -Maximum $Gifs.length)]).FullName
    }

}

Function Get-Profiles{
    param(
        [Parameter(Mandatory=$true,
        ValueFromPipelineByPropertyName=$true,
        Position=0)]
        [String]
        $ProfileFile
    )
    $json = Get-Content $ProfileFile | ConvertFrom-Json 
    return $json
}

Function Set-ProfileGif{
    param(
        [Parameter(Mandatory=$true,
        ValueFromPipelineByPropertyName=$true,
        Position=0)]
        [String]
        $ProfileFile,
        [Parameter(Mandatory=$true,
        ValueFromPipelineByPropertyName=$true,
        Position=1)]
        [String]
        $GifsFolder
    )
    $settings = Get-Profiles -ProfileFile $TerminalProfileSettings
    foreach($profile in $settings.profiles){
        if($profile.backgroundImage -ne $null){
            $gif = Get-RandomGif -FolderName $GifsFolder
            $gif = $gif -replace '\\', '/'
            $profile.backgroundImage = $gif
        }
    }
    $outputFile = $settings | ConvertTo-Json -Depth 10
   # Write-Host $outputFile
    Set-Content -Path $TerminalProfileSettings -Value $outputFile    

}

if(Test-GifPath $GifFolder){
    Set-ProfileGif -ProfileFile $TerminalProfileSettings -GifsFolder $GifFolder
}


