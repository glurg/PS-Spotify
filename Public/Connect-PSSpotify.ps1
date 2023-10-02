function Connect-PSSpotify {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$ClientID,
        [Parameter(Mandatory)]
        [string]$ClientSecret
    )
    
    begin {
        $password = ConvertTo-SecureString $ClientSecret -AsPlainText -Force
        $credential = New-Object System.Management.Automation.PSCredential ($ClientID,$password)

        $body = @{ 
            grant_type = 'client_credentials' 
        }

    }
    
    process {
        Invoke-RestMethod -Method Post -Uri "https://accounts.spotify.com/api/token" -Authentication Basic -Credential $credential -Body $body
    }
    
    end {
        
    }
}