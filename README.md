# FileExtractor
Easy-to-use file extractor that supports a wide variety of file extensions, given that specific extractors are available for any desired file type.

## Installation
Simply clone this repository and you're ready to go. You may want to add a symbolic link to somewhere like `/usr/local/bin` to make it easier to run, e.g:
```
cd /usr/local/bin
sudo ln -s path/to/extractor.sh x
```

## Usage
`x your_file folder_name`

If the `folder_name` is omitted, the name of the file will be used instead (without the extension).

## Extending FileExtractor
Add new entries to `settings.txt`, following its syntax rules, and then run `make`.

## Supported extensions
See the `settings.txt` file to see which extractors are used for each of the supported file types.
* .7z
* .cpio
* .jar
* .rar
* .tar.7z
* .tar.bz2
* .tar.gz
* .tar.lzo
* .tar.lzma
* .tar.xz
* .tar.Z
* .war
* .zip
