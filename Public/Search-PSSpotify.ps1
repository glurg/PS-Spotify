function Search-PSSpotify {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$AccessToken, 
        [Parameter(Mandatory)]
        [ValidateSet("album", "artist", "playlist", "track", "show", "episode", "audiobook")]
        [string]$ResultType,
        [Parameter(Mandatory)]
        [string]$SearchQuery
    )
    <#
    .SYNOPSIS
    Search Spotify

    .Parameter SearchQuery

    .EXAMPLE
    Search-PSSpotify -ResultType artist -AccessToken $authResponse.access_token -SearchQuery "artist:Giraffage"
    Returns
    https://api.spotify.com/v1/search?q=artist%3aGiraffage&type=artist

    external_urls : @{spotify=https://open.spotify.com/artist/4kubsO16bEfCADaVUyoYb6}
    followers     : @{href=; total=115225}
    genres        : {chillwave, future bass, vapor twitch}
    href          : https://api.spotify.com/v1/artists/4kubsO16bEfCADaVUyoYb6
    id            : 4kubsO16bEfCADaVUyoYb6
    images        : {@{height=640; url=https://i.scdn.co/image/ab6761610000e5ebb81dce5c729faec402c4daf1; width=640}, @{height=320;
                    url=https://i.scdn.co/image/ab67616100005174b81dce5c729faec402c4daf1; width=320}, @{height=160;
                    url=https://i.scdn.co/image/ab6761610000f178b81dce5c729faec402c4daf1; width=160}}
    name          : Giraffage
    popularity    : 45
    type          : artist
    uri           : spotify:artist:4kubsO16bEfCADaVUyoYb6

    external_urls : @{spotify=https://open.spotify.com/artist/6HGP6S4ydDgY3CElZiZJYC}
    followers     : @{href=; total=0}
    genres        : {}
    href          : https://api.spotify.com/v1/artists/6HGP6S4ydDgY3CElZiZJYC
    id            : 6HGP6S4ydDgY3CElZiZJYC
    images        : {}
    name          : Giraffage
    popularity    : 0
    type          : artist
    uri           : spotify:artist:6HGP6S4ydDgY3CElZiZJYC
    #>
    
    begin {
        $SearchQuery = [System.Web.HttpUtility]::UrlEncode($SearchQuery)
        $ResultType = [System.Web.HttpUtility]::UrlEncode($ResultType)

        $uri = "https://api.spotify.com/v1/search?q=$SearchQuery&type=$ResultType"

        $header = @{ 
            Authorization = "Bearer $AccessToken"
        }
    }
    
    process {
        return (Invoke-RestMethod -Method Get -Uri $uri -Headers $header)."$($ResultType)s".items
        
    }
    
    end {
        
    }
}