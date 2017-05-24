# --------------------------------------------------------------- #
# --- THIS FILE IS AUTO-GENERATED. Edit settings.txt instead! --- #
# --------------------------------------------------------------- #

if check ".tar.7z"; then
    tar -cvf $files | 7z a -si $output

elif check ".7z"; then
    7z a $output $files

elif check ".cpio"; then
	ls $files | cpio -ov > $output

elif check ".ear"; then
    jar -cvf $output $files

elif check ".jar"; then
    jar -cvf $output $files

elif check ".war"; then
    jar -cvf $output $files

elif check ".tar.bz2"; then
    tar -acvf $output $files

elif check ".tar.gz"; then
    tar -acvf $output $files

elif check ".tar.lzma"; then
    tar -acvf $output $files

elif check ".tar.lzo"; then
    tar -acvf $output $files

elif check ".tar.lz"; then
    tar -acvf $output $files

elif check ".tar.xz"; then
    tar -acvf $output $files

elif check ".zip"; then
    zip $output $files
else
	echo >&2 "Unknown file type"
	exit 1
fi
