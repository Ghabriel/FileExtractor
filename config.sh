# --------------------------------------------------------------- #
# --- THIS FILE IS AUTO-GENERATED. Edit settings.txt instead! --- #
# --------------------------------------------------------------- #

if check ".tar.7z"; then
    7z x $BUNDLE_FILENAME
    tar -xvf $filename.tar
    rm -f $filename.tar

elif check ".7z"; then
    7z x $BUNDLE_FILENAME

elif check ".cpio"; then
    cpio -iv < $BUNDLE_FILENAME

elif check ".ear"; then
    jar -xvf $BUNDLE_FILENAME

elif check ".jar"; then
    jar -xvf $BUNDLE_FILENAME

elif check ".war"; then
    jar -xvf $BUNDLE_FILENAME

elif check ".rar"; then
    unrar x $BUNDLE_FILENAME

elif check ".tar.bz2"; then
    tar -xvf $BUNDLE_FILENAME

elif check ".tar.gz"; then
    tar -xvf $BUNDLE_FILENAME

elif check ".tar.lzo"; then
    tar -xvf $BUNDLE_FILENAME

elif check ".tar.lz"; then
    tar -xvf $BUNDLE_FILENAME

elif check ".tar.xz"; then
    tar -xvf $BUNDLE_FILENAME

elif check ".tar.lzma"; then
    tar --lzma -xvf $BUNDLE_FILENAME

elif check ".tar.Z"; then
    tar --gzip -xvf $BUNDLE_FILENAME

elif check ".zip"; then
    unzip $BUNDLE_FILENAME
else
	echo >&2 "Unknown file type"
	exit 1
fi
