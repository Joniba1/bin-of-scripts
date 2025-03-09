:: Description: Reduces the size of a video by scaling it to 720p and compressing it using H.264 codec. Audio quality is preserved.
:: Output: Saves the reduced video in the same directory as the input file with a "_reduced" appended to the original path.
:: Usage: reduce-video.bat [video path]

@echo off

if "%~1"=="" (
    echo Usage: %~nx0 input_file
    echo Input file path must be provided.
    exit /b 1
)

set "INPUT_FILE=%~1"
 
ffmpeg -hide_banner -loglevel error -i "%INPUT_FILE%" -vf scale=1280:720 -c:v libx264 -crf 23 -preset veryslow -c:a copy "%OUTPUT_FILE%"