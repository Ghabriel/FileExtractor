# --------------------------------------------------------------- #
# --- THIS FILE IS AUTO-GENERATED. Edit settings.txt instead! --- #
# --------------------------------------------------------------- #

if check ".7z"; then
    7z l $path

elif check ".cpio"; then
    cpio -itv < $path

elif check ".ear"; then
    jar -tvf $path

elif check ".jar"; then
    jar -tvf $path

elif check ".war"; then
    jar -tvf $path

elif check ".rar"; then
	unrar l $path

elif check ".tar.bz2"; then
    tar -tvf $path

elif check ".tar.gz"; then
    tar -tvf $path

elif check ".tar.lzo"; then
    tar -tvf $path

elif check ".tar.lz"; then
    tar -tvf $path

elif check ".tar.xz"; then
    tar -tvf $path

elif check ".tar.lzma"; then
    tar --lzma -tvf $path

elif check ".tar.Z"; then
    tar --gzip -tvf $path

elif check ".zip"; then
    unzip -l $path
else
	echo >&2 "Unknown file type"
	exit 1
fi
