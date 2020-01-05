Get-ChildItem ./ -Recurse | ForEach-Object {
    if ($_ -match '.import$') {
        Remove-Item $_.FullName -Recurse -Force
    }
}