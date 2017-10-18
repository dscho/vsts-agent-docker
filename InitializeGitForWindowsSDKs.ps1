$urlbase = "https://github.com/git-for-windows"
$git = ".\externals\git\cmd\git.exe"

$sdk32 = "C:\git-sdk-32-ci"
& $git init $sdk32
& $git -C $sdk32 config core.autocrlf false
& $git -C $sdk32 config core.untrackedCache true
& $git -C $sdk32 remote add -t master origin $urlbase/git-sdk-32
& $git -C $sdk32 pull --depth=1 origin master
$src = "$sdk32\usr\src"
New-Item -ItemType "directory" -Path $src
$build_extra = "$src\build-extra"
& $git init $build_extra
& $git -C $build_extra config core.autocrlf false
& $git -C $build_extra config core.untrackedCache true
& $git -C $build_extra remote add -t master origin $urlbase/build-extra
& $git -C $build_extra pull --depth=1 origin master

$sdk64 = "C:\git-sdk-64-ci"
& $git init $sdk64
& $git -C $sdk64 config core.autocrlf false
& $git -C $sdk64 config core.untrackedCache true
& $git -C $sdk64 remote add -t master origin $urlbase/git-sdk-64
& $git -C $sdk64 pull --depth=1 origin master
$src = "$sdk64\usr\src"
New-Item -ItemType "directory" -Path $src
$build_extra = "$src\build-extra"
& $git init $build_extra
& $git -C $build_extra config core.autocrlf false
& $git -C $build_extra config core.untrackedCache true
& $git -C $build_extra remote add -t master origin $urlbase/build-extra
& $git -C $build_extra pull --depth=1 origin master
