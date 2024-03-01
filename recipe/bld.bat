@echo on

bash %RECIPE_DIR%/build_win.sh
IF %ERRORLEVEL% NEQ 0 exit 1

copy %RECIPE_DIR%\configure.win r
IF %ERRORLEVEL% NEQ 0 exit 1

copy %RECIPE_DIR%\install.libs.R r\src
IF %ERRORLEVEL% NEQ 0 exit 1

echo "CXX17STD=-std=c++17" >>%R_MAKEVARS_SITE%

type %R_MAKEVARS_SITE%

set "MAKEFLAGS=-j%CPU_COUNT%"
"%R%" CMD INSTALL --build r
IF %ERRORLEVEL% NEQ 0 exit 1
