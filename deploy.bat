@REM 临时目录名变量
set TEMP_DIR=%tmp_gitbook_0718%

@REM 判断临时目录是否存在，如果存在则删除目录
if exist %TEMP_DIR% rmdir /s /q %TEMP_DIR%

@REM 创建临时目录
mkdir %TEMP_DIR%

@REM 通过 gitbook 命令进行编译
gitbook build

@REM 将 _book 下所有文件复制到临时目录
xcopy /s /y _book %TEMP_DIR%

@REM 切换到 gh-pages 分支
git checkout -b gh-pages

@REM 清空该分支下的所有文件
git rm -rf .

@REM 将临时目录中的文件复制到该分支
xcopy /s /y %TEMP_DIR% .

@REM 提交到本地仓库
git add .

@REM 提交到远程仓库
git commit -m "publish book"

@REM 推送到远程仓库
git push origin gh-pages

@REM 切换回主分支
git checkout main

@REM 删除临时目录
rmdir /s /q %TEMP_DIR%
