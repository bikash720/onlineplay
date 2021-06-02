# Change input and output details

output_path="biscuit" # Output Path (Same will be pushed in main also)
input_url="https://download.wetransfer.com/eugv/59123ff0ef9c33b8782be9d0abcde8e020210530215027/7d44d68acc0276da0b50c5ff882709670662a50f/BISKTSKMHD%20%282020%29%20www.SkymoviesHD.kim%201080p%20UnCut%20HDRip%20Dual%20Audio%20x264%20ESub.mkv?token=eyJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE2MjI2NDkwODIsImV4cCI6MTYyMjY0OTY4MiwidW5pcXVlIjoiNTkxMjNmZjBlZjljMzNiODc4MmJlOWQwYWJjZGU4ZTAyMDIxMDUzMDIxNTAyNyIsImZpbGVuYW1lIjoiQklTS1RTS01IRCAoMjAyMCkgd3d3LlNreW1vdmllc0hELmtpbSAxMDgwcCBVbkN1dCBIRFJpcCBEdWFsIEF1ZGlvIHgyNjQgRVN1Yi5ta3YiLCJ3YXliaWxsX3VybCI6Imh0dHA6Ly9zdG9ybS1pbnRlcm5hbC5zZXJ2aWNlLmV1LXdlc3QtMS53ZXRyYW5zZmVyLm5ldC9hcGkvd2F5YmlsbHM_c2lnbmVkX3dheWJpbGxfaWQ9ZXlKZmNtRnBiSE1pT25zaWJXVnpjMkZuWlNJNklrSkJhSEJDUld3M00zaEZQU0lzSW1WNGNDSTZJakl3TWpFdE1EWXRNREpVTVRZNk1ERTZNakl1TURBd1dpSXNJbkIxY2lJNkluZGhlV0pwYkd4ZmFXUWlmWDAtLTZkZjA0Y2YyYTYyYzUwNGRmNDE4YTYzMTZmN2NkNjFhZWRkZWJlOTZiNGNiNTM3NzQ5YTIzZGE2MGU2MTc4MzAiLCJmaW5nZXJwcmludCI6IjdkNDRkNjhhY2MwMjc2ZGEwYjUwYzVmZjg4MjcwOTY3MDY2MmE1MGYiLCJjYWxsYmFjayI6IntcImZvcm1kYXRhXCI6e1wiYWN0aW9uXCI6XCJodHRwOi8vcHJvZHVjdGlvbi5mcm9udGVuZC5zZXJ2aWNlLmV1LXdlc3QtMS53dDozMDAwL3dlYmhvb2tzL2JhY2tlbmRcIn0sXCJmb3JtXCI6e1widHJhbnNmZXJfaWRcIjpcIjU5MTIzZmYwZWY5YzMzYjg3ODJiZTlkMGFiY2RlOGUwMjAyMTA1MzAyMTUwMjdcIixcImRvd25sb2FkX2lkXCI6MTIyNTQzMzE1Njd9fSJ9.GverTeZN2AMkDMBx8kNsuCmLeAzVhmBwLG4SO-wfya4&cf=y" # Input direct file url
input_extension="mkv" # Extension of file url



# Change ffmpeg configurations according to yur need (If you don't know, don't touch)

wget --quiet -O video.$input_extension $input_url
mkdir $output_path

ffmpeg -hide_banner -y -i video.$input_extension \
  -vf scale=w=640:h=360:force_original_aspect_ratio=decrease -c:a aac -ar 48000 -c:v h264 -profile:v main -crf 20 -sc_threshold 0 -g 48 -keyint_min 48 -hls_time 4 -hls_playlist_type vod  -b:v 800k -maxrate 856k -bufsize 1200k -b:a 96k -hls_segment_filename $output_path/360p_%03d.ts $output_path/360p.m3u8 \
  -vf scale=w=842:h=480:force_original_aspect_ratio=decrease -c:a aac -ar 48000 -c:v h264 -profile:v main -crf 20 -sc_threshold 0 -g 48 -keyint_min 48 -hls_time 4 -hls_playlist_type vod -b:v 1400k -maxrate 1498k -bufsize 2100k -b:a 128k -hls_segment_filename $output_path/480p_%03d.ts $output_path/480p.m3u8 \
  -vf scale=w=1280:h=720:force_original_aspect_ratio=decrease -c:a aac -ar 48000 -c:v h264 -profile:v main -crf 20 -sc_threshold 0 -g 48 -keyint_min 48 -hls_time 4 -hls_playlist_type vod -b:v 2800k -maxrate 2996k -bufsize 4200k -b:a 128k -hls_segment_filename $output_path/720p_%03d.ts $output_path/720p.m3u8 \
  -vf scale=w=1920:h=1080:force_original_aspect_ratio=decrease -c:a aac -ar 48000 -c:v h264 -profile:v main -crf 20 -sc_threshold 0 -g 48 -keyint_min 48 -hls_time 4 -hls_playlist_type vod -b:v 5000k -maxrate 5350k -bufsize 7500k -b:a 192k -hls_segment_filename $output_path/1080p_%03d.ts $output_path/1080p.m3u8

rm video.$input_extension
cd $output_path

echo '#EXTM3U
#EXT-X-VERSION:3
#EXT-X-STREAM-INF:BANDWIDTH=800000,RESOLUTION=640x360
360p.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=1400000,RESOLUTION=842x480
480p.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=2800000,RESOLUTION=1280x720
720p.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=5000000,RESOLUTION=1920x1080
1080p.m3u8' > master.m3u8
