
# YOU MUST SPECIFY $manga_name, eg: (naruto, bleach)

$manga_name = 'naruto'








###############################
# DO NOT EDIT BELOW THIS LINE #
###############################



$local_drive = 'C:\'
$mangapanda = "http://www.mangapanda.com/"
$local_path = "$local_drive\$manga_name"
$manga_url = "$mangapanda$manga_name"

$webclient = New-Object System.Net.WebClient

$chapter_string = $webclient.DownloadString("$manga_url")
$result = $chapter_string -match '<a href="/naruto/(\d+?)">'
$end_chapter = $matches[1]

$result = $chapter_string -match '<th>Date Added</th>\n</tr>\n<tr>\n<td>((.|\n)*)'
$chapter_list = $matches[1]


#write-output $chapter_list
$result = $chapter_list -match '<a href="/(.*?)">'
$chapter_part = $matches[1]

$page_url = "$mangapanda$chapter_part"
write-host $page_url
$page_string = $webclient.DownloadString($page_url)
$result = $page_string -match '</select> of (\d+?)</div>'
$page_total = $matches[1]

write-host $page_total


<#
For($j=$chapter_start; $j -le $chapter_end; $j++) {
	$total_pages = 2
	Write-Host "Chapter: $j"
	For($i=1; $i -le $total_pages; $i++) {
		
		
		$html_string = $webclient.DownloadString("$url/$j/$i")
		
        
        
		
		$result = $html_string -match ' of (\d+?)</div>'
		$total_pages = $matches[1]
		
		
		$result = $html_string -match 'src="(.*?)\.jpg"'
		$remote_file = "$($matches[1]).jpg"
		
		$file = "$local_path\$j-$i.jpg"
		Write-Host "$file of $total_pages"
		
		
		$webclient.DownloadFile($remote_file, $file)
		
	}
}
#>

#Write-Host $file

