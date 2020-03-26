cp ${RECIPE_DIR}/configure.win r
IF %ERRORLEVEL% NEQ 0 exit 1
"%R%" CMD INSTALL --build r
IF %ERRORLEVEL% NEQ 0 exit 1
