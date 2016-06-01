$TaskSequence = "<TaskSequenceName>"
$SiteCode = "<SiteCode>"
$ComputerName = "<ConfigMgrServerName>"
$ExportDir = "C:\Program Files\Microsoft Deployment Toolkit\SCCM"
$NewTemplateName = "My Own Custom Template"
$NewFileName = "MyOwnCustomTemplate.xml"
$BootImageID = "<ImageID>"

# List Task Sequences
$Ts = Get-WmiObject SMS_TaskSequencePackage -Namespace root\sms\site_$SiteCode -ComputerName $ComputerName | Select * | Where-Object {$_.Name -eq $TaskSequence}

# Export Task Sequences
cd C:
cd $ExportDir
Get-WmiObject SMS_TaskSequencePackage -Namespace root\sms\site_$SiteCode -ComputerName $ComputerName
$Ts = [wmi]”$($Ts.__PATH)”
Set-Content -Path $NewFileName -Value "<?xml version=`"1.0`"?>
    <SmsTaskSequencePackage xmlns:xsi=`"http://www.w3.org/2001/XMLSchema-instance`" xmlns:xsd=`"http://www.w3.org/2001/XMLSchema`">
	<BootImageID>$BootImageID</BootImageID>
	<Category />
	<DependentProgram />
	<Description />
	<Duration>360</Duration>
	<Name>$NewTemplateName</Name>
	<ProgramFlags>152084496</ProgramFlags>
	<SequenceData>"
Add-Content -Path $NewFileName -Value $Ts.Sequence
Add-Content -Path $NewFileName -Value '	</SequenceData>
	<SourceDate>2007-07-17T18:21:22</SourceDate>
	<SupportedOperatingSystems />
	<IconSize>0</IconSize>
    </SmsTaskSequencePackage>'