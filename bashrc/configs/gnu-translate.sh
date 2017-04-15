export GNU_WEB_BASE_PATH="$HOME/projects/gnu.org"

gnu-mk-po() {
	local path=$(echo $1 | sed 's/.*:\/\/[^\/]*\///')
	local dir=$(dirname $path)
	local filebase=$(basename $path .en.html)
	filebase=$(basename $filebase .html)

	local zh_cn_dir="$GNU_WEB_BASE_PATH/www-zh-cn/$dir"
	local www_dir="$GNU_WEB_BASE_PATH/www/$dir/po"

	mkdir -p $zh_cn_dir

	cp "$www_dir/$filebase.pot" "$zh_cn_dir/$filebase.zh-cn.po"
}

gnu-submit-po() {
	local path=$(echo $1 | sed 's/.*:\/\/[^\/]*\///')
	local dir=$(dirname $path)
	local filebase=$(basename $path .en.html)
	filebase=$(basename $filebase .html)

	local zh_cn_dir="$GNU_WEB_BASE_PATH/www-zh-cn/$dir"
	local www_dir="$GNU_WEB_BASE_PATH/www/$dir/po"

	local zh_cn_fn="$zh_cn_dir/$filebase.zh-cn.po"
	if ! [[ -f $zh_cn_fn ]]; then
		echo Cannot find file $zh_cn_fn
		return -1
	fi
	cp $zh_cn_fn $www_dir
}
