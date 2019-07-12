"%R%" CMD INSTALL --build r\.
IF %ERRORLEVEL% NEQ 0 exit 1
