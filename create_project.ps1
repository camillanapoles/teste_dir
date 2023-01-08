
function WriteLog
{
    Param ([string]$LogString)

        $Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
        $LogMessage = "$Stamp $LogString"
        Add-content $LogFile -value $LogMessage
}


function make_project 
{
    Param (
        [string]$directory_name,
        [string]$project_name,
        [string]$python_version
    )

    WriteLog "Starting script"
    $directory_name = Read-Host -Prompt 'Directory Name: '    
    mkdir $directory_name && Set-Location $_
    WriteLog "Directory created"
    
    $project_name = Read-Host -Prompt 'Project Name: '
    poetry new $project_name
    WriteLog "Poetry project created"    

    $python_version = pyenv versions

    Write-Host "Python version: $python_version" 
    $condition = Read-Host -Prompt 'Deseja trocar a versão do python? (y/N)'   
    
    if ( $condition -eq 'y' -or $condition -eq 'Y' )
    {
        $python_version = Read-Host -Prompt 'Digite a versao do Python version: '
        pyenv install $python_version
        
    }    

    pyenv local $python_version
    WriteLog "Python version set"
    
    poetry install
    WriteLog "Poetry environment installed"

    poetry shell
    WriteLog "Poetry environment activated"

    Write-Host "You input server" # '$Servers' and '$User' on '$Date'" 
}

# git init
# git remote add origin https://github.com/fbraza/summarize_dataframe.git
# gig python
# Write-Output ".*\n!.gitignore" > .gitignore
# Write-Output "# Summarize dataframe" > README.md
# git add .
# git commit -m "build: first commit. Environment built"
# git push -u origin master