:: Description: copies a folder or file from GCP
:: Usage: gcs-copy [folder / file]

@echo off

if "%1"=="" (
  echo Usage: gcs-copy [folder / file]
  goto end
)

gsutil -m cp -r "%1" .

:end
