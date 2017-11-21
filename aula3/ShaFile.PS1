
function Get-FileSHA1 {
    param(
        [Parameter(
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = "FullName",
            Mandatory = $true
        )]
        [String] $filePath
    )

    begin {
        $sha1 = New-Object System.Security.Cryptography.SHA1Managed
        $prettyHashSB = New-Object System.Text.StringBuilder
    }

    process {
        $fileContent = Get-Content $filePath
        $fileBytes = [System.Text.Encoding]::UTF8.GetBytes($fileContent)

        $hash = $sha1.ComputeHash($fileBytes)

        foreach ($byte in $hash) {
            $hexaNotation = $byte.ToString("X2")
            $prettyHashSB.Append($hexaNotation) > $null
        }

        $prettyHashSB.ToString() 
        $prettyHashSB.Clear() > $null
    }

    end {
        $sha1.Dispose()
    }
}


















function Get-FileSHA256() {
    
}
function Get-FileSHA384() {
    
}
function Get-FileSHA512() {
    
}


