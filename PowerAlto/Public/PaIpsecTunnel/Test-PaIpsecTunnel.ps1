function Test-PaIpsecTunnel {
    [CmdletBinding(SupportsShouldProcess = $True)]
    Param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Name
    )

    BEGIN {
        $VerbosePrefix = "Test-PaIpsecTunnel:"
    }

    PROCESS {
        $Cmd = "<test><vpn><ipsec-sa><tunnel>$Name</tunnel></ipsec-sa></vpn></test>"

        $CommandBeingRun = [regex]::split($Cmd, '[<>\/]+') | Select-Object -Unique | Where-Object { $_ -ne "" }
        if ($PSCmdlet.ShouldProcess("Running Operational Command: $CommandBeingRun")) {
            $Query = Invoke-PaApiOperation -Cmd $Cmd
            $Results = $Query.response.result
        }
    }

    END {
        $Results.member
    }
}
