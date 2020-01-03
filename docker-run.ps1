[CmdletBinding(PositionalBinding=$false)]

param(
  [string]
  [Parameter(
    Mandatory=$true,
    HelpMessage= "Enter the command and arguments (in string format) to run in the container. For example: `"npm install`"",
    Position=0
  )]
  [alias("e")] 
  $execute,
  [string]
  [ValidateNotNullOrEmpty()]
  [alias("p")] 
  $publishPorts = "8000:8000",
  [string]
  [ValidateNotNullOrEmpty()]
  [alias("v")] 
  $volumePaths = "$(Get-Location):/development",
  [string]
  [ValidateNotNullOrEmpty()]
  [alias("w")] 
  $workdirPath = "/development",
  [string]
  [ValidateNotNullOrEmpty()]
  [alias("i")] 
  $imageName = "node:12.13.1-alpine3.10"
);

$exec = $execute.split(" ");
$command, $arguments = $exec;

docker run --interactive --tty --rm `
  --publish $publishPorts `
  --volume $volumePaths `
  --workdir $workdirPath `
  $imageName $command $arguments

<#
REFERENCES
  Passing parameters to script file: 
  https://windows.tips.net/T002902_Passing_Parameters_to_a_PowerShell_Script.html

  Parameters options: 
  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_advanced_parameters?view=powershell-6

  Shift arrays: 
  https://devblogs.microsoft.com/powershell/powershell-tip-how-to-shift-arrays/

  Convert strings to arrays: 
  https://practical-admin.com/blog/powershell-convert-string-to-array/

  CmdletBinding positional binding: 
  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_cmdletbindingattribute?view=powershell-6#positionalbinding

  Escaping in powershell:
  http://www.rlmueller.net/PowerShellEscape.htm
#>