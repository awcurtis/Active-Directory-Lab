$DEFAULT_PASSWORD = "0rg@n1z@t10n!"
$USER_LIST = Get-Content .\Users.txt
$user_number = 0

$password = ConvertTo-SecureString $DEFAULT_PASSWORD -AsPlainText -Force
New-ADOrganizationalUnit -Name _SALES -ProtectedFromAccidentalDeletion $false

foreach ($name in $USER_LIST) {
    $first_name = $name.Split(" ")[0].ToLower()
    $last_name = $name.Split(" ")[1].ToLower()
    $username = "$($first_name.Substring(0,1))$($last_name)".ToLower()
    $user_number++
    Write-Host "Now creating user $($user_number) of $($USER_LIST.Length): $($username)"

    New-AdUser -AccountPassword $password `
        -GivenName $first_name `
        -Surname $last_name `
        -DisplayName $username `
        -Name $username `
        -EmployeeID $username `
        -PasswordNeverExpires $false `
        -ChangePasswordAtLogon $true `
        -Path "ou=_SALES,$(([ADSI]`"").distinguishedName)" `
        -Enabled $true
}