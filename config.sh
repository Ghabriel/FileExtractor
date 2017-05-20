if check ".tar.bz2"; then
    tar --bzip2 -xvf ../$path

elif check ".tar.gz"; then
    tar -xvf ../$path

elif check ".tar.lzo"; then
    tar -xvf ../$path

elif check ".tar.lzma"; then
    tar --lzma -xvf ../$path

elif check ".tar.xz"; then
    tar --xz -xvf ../$path

elif check ".zip"; then
    unzip ../$path
else
	echo "Unknown file type"
	exit 1
fi
