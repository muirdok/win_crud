$test1 = -Not (Test-Path -Path "C:\tmp")
$test2 = -Not (Test-Path -Path "C:\tmd")

If (($test1) -and ($test2)) {"TESTS ARE PASSES"}
Else {exit 1}