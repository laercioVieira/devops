[console]::ForegroundColor = "white"
[console]::BackgroundColor = "black"

if( $(Get-ExecutionPolicy) -ne "Unrestricted") {
	Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force
}

# PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force
# PowerShellGet\Update-Module posh-git
Import-Module posh-git
Add-PoshGitToProfile -AllHosts
$GitPromptSettings.DefaultPromptSuffix='`n$([DateTime]::now.ToString("yyyy-MM-dd HH:mm:ss")) > '

function funcmvnear{
        $args = "clean install -Dservidor=wildfly antrun:run"
        $cmd = "`'$Env:M2_HOME\bin\mvn.cmd`' $args"
        Invoke-Expression "& $cmd"
    }

function funcmvninst{
        $args = "clean install"
        $cmd = "`'$Env:M2_HOME\bin\mvn.cmd`' $args"
        Invoke-Expression "& $cmd"
    }

function funcmvndeploy{
        $args = "clean deploy"
        $cmd = "`'$Env:M2_HOME\bin\mvn.cmd`' $args"
        Invoke-Expression "& $cmd"
    }

function funcgitcompush{
        write-Host "Message: $args"
        if ($args -like '* #*') { 
            git add -A;
            git commit -am "$args"
            git push
        } else {
          write-host "informe o id da task usando #. Uso: gitcompush 'Comentario #000' "
        }
    }

function funcgitstatus{
         git status
    }

function funcgitpull{
         git pull
         git status
    }

function functail{
         Get-Content $args -Wait -Tail 30
    }

Set-Alias gcp funcgitcompush
Set-Alias gs funcgitstatus
Set-Alias gpu funcgitpull
Set-Alias mvnear funcmvnear
Set-Alias mvninst funcmvninst
Set-Alias mvndeploy funcmvndeploy
Set-Alias tail functail

cls
date