# --------------------------------------------------------------- #
# --- THIS FILE IS AUTO-GENERATED. Edit settings.txt instead! --- #
# --------------------------------------------------------------- #

if check ".tar.7z"; then
    7z x ../$path
    tar -xvf $filename.tar
    rm -f $filename.tar

elif check ".7z"; then
    7z x ../$path

elif check ".cpio"; then
    cpio -iv < ../$path

elif check ".jar"; then
    jar -xvf ../$path

elif check ".war"; then
    jar -xvf ../$path

elif check ".rar"; then
    unrar x ../$path

elif check ".tar.bz2"; then
    tar --bzip2 -xvf ../$path

elif check ".tar.gz"; then
    tar -xvf ../$path

elif check ".tar.lzo"; then
    tar -xvf ../$path

elif check ".tar.lzma"; then
    tar --lzma -xvf ../$path

elif check ".tar.xz"; then
    tar --xz -xvf ../$path

elif check ".tar.Z"; then
    tar --gzip -xvf ../$path

elif check ".zip"; then
    unzip ../$path
else
	echo "Unknown file type"
	exit 1
fi
