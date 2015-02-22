
# YOU MUST SPECIFY $manga_name, $chapter_start and $chapter_end

$manga_name = 'naruto'
$chapter_start = 1
$chapter_end = 700
$local_drive = 'd:\Manga'







###############################
# DO NOT EDIT BELOW THIS LINE #
###############################


$url = "http://www.mangapanda.com/$manga_name"
$local_path = "$local_drive\$manga_name"

$webclient = New-Object System.Net.WebClient

For($j=$chapter_start; $j -le $chapter_end; $j++) {
	$total_pages = 2
	Write-Host "Chapter: $j"
	For($i=1; $i -le $total_pages; $i++) {
		
		Try {
			$html_string = $webclient.DownloadString("$url/$j/$i")
		} Catch [System.Net.WebException] {
			#$error[0]
			$html_string = $webclient.DownloadString("$url/$j/$i")
		}
		
		$result = $html_string -match ' of (\d+?)</div>'
		$total_pages = $matches[1]
		
		
		$result = $html_string -match 'src="(.*?)\.jpg"'
		$remote_file = "$($matches[1]).jpg"
		
		$file = "$local_path\$j-$i.jpg"
		Write-Host "$file of $total_pages"
		
		Try {
			$webclient.DownloadFile($remote_file, $file)
		} Catch [System.Net.WebException] {
			#$error[0]
			#Write-Error "Failed to download: $remote_file"
			$webclient.DownloadFile($remote_file, $file)
		}
	}
}


#Write-Host $file

