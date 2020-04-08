"%R%" CMD INSTALL --debug --build r
IF %ERRORLEVEL% NEQ 0 exit 1
