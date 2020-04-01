bash %RECIPE_DIR%/build_win.sh
IF %ERRORLEVEL% NEQ 0 exit 1
cp %RECIPE_DIR%/configure.win r
IF %ERRORLEVEL% NEQ 0 exit 1
cp %RECIPE_DIR%/install.libs.R r/src
IF %ERRORLEVEL% NEQ 0 exit 1
"%R%" CMD INSTALL --build r
IF %ERRORLEVEL% NEQ 0 exit 1
