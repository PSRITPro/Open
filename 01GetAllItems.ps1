Set-Location $PSScriptRoot
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$TransScriptFile = ".\logs\TransScript_$($timestamp).log"
Start-Transcript $TransScriptFile

# Define parameters
$siteUrl = "https://myorg.sharepoint.com/"
#Connect-PnPOnline -Url $siteUrl -UseWebLogin

# Set the document library name
$libraryName = "Documents"  # Replace with your document library name

$BatchSize = 500  # Define the batch size

# Create the CAML query
$CamlQuery = @"
<View Scope='RecursiveAll'>
  <Query>
    <Where>
      <Eq>
        <FieldRef Name='FSObjType' />
        <Value Type='Integer'>0</Value>
      </Eq>
    </Where>
  </Query>
  <RowLimit Paged='TRUE'>$BatchSize</RowLimit>
</View>
"@

$listItemsDetails = ".\logs\ListItems_$($timestamp).csv"

Get-PnPListItem -List $LibraryName -Query $CamlQuery | Select ID | Export-Csv -Path $listItemsDetails -NoTypeInformation

# Disconnect from SharePoint Online
#Disconnect-PnPOnline

Stop-Transcript