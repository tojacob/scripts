[CmdletBinding(PositionalBinding=$false)]
param(
  [string]
  [Parameter(
    Mandatory=$true,
    HelpMessage= "Enter the command and arguments (in string format separate for an space) to run in the container. For example: `"npm install`"",
    Position=0
  )]
  [alias("e")] 
  $execute,
  [string]
  [Parameter(
    HelpMessage= "Enter the ports (in string format separate for an space) to set in the container. For example: `"3000:3000 8080:8080`"",
    Position=1
  )]
  [ValidateNotNullOrEmpty()]
  [alias("p")] 
  $publishPorts = "3000:3000",
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

# Format port list
[array] $publishPortsWithFormat = $publishPorts.split(" ");

for ($i=0; $i -lt $publishPortsWithFormat.length; $i++) {
  $publishPortsWithFormat[$i] = "-p=" + $publishPortsWithFormat[$i];
}

# Get command and arguments to run
$exec = $execute.split(" ");
$command, $arguments = $exec;

# Run the container 
docker run --interactive --tty --rm `
  $publishPortsWithFormat `
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

  Array list (array add method):
  https://mcpmag.com/articles/2019/04/10/managing-arrays-in-powershell.aspx

  Loop array:
  https://powertoe.wordpress.com/2009/12/14/powershell-part-4-arrays-and-for-loops/
#>