@echo off 
echo Starting your Portable LLM Server... 
echo. 

REM -- 1. Change to the drive where this script is located (the external drive) 
%~d1 
cd %~dp0 

REM -- 2. Check if Docker is FUNCTIONAL with a timeout loop (This is the key fix) 
echo Checking if Docker Desktop is ready... 
set MAX_ATTEMPTS=30 
set ATTEMPT=1 

:CHECK_DOCKER_LOOP 
REM Try to run a simple, harmless Docker command that doesn't create anything 
docker version --format "{{.Server.Version}}" >nul 2>&1 
if not errorlevel 1 ( 
	echo Docker is ready! 
	goto DOCKER_SUCCESS 
) 

echo [Attempt %ATTEMPT%/%MAX_ATTEMPTS%] Docker not ready yet... Waiting... 
if %ATTEMPT% GEQ %MAX_ATTEMPTS% ( 
	echo. 
	echo ERROR: Docker Desktop did not become ready in time. 
	echo. 
	echo TROUBLESHOOTING: 
	echo 1. Ensure Docker Desktop is installed and has been run at least once. 
	echo 2. Start Docker Desktop manually. Wait for the whale icon to stop animating. 
	echo 3. If using WSL2, ensure your Linux kernel is updated. 
	echo 4. Try restarting your computer if this is a fresh install. 
	echo. 
	pause 
	exit /b 1 
) 

REM Wait 2 seconds before trying again 
timeout /t 2 /nobreak >nul
set /a ATTEMPT+=1 
goto CHECK_DOCKER_LOOP 

:DOCKER_SUCCESS 

REM -- 3. Start the Ollama server in a new window. The /min flag starts it minimized. 
echo Starting Ollama server... 
start "Ollama Server" /min ollama serve 

REM -- 4. Give Ollama a few seconds to start up completely 
echo Waiting for Ollama to initialize... 
timeout /t 8 /nobreak >nul 

REM -- 5. Check if the OpenWebUI container already exists and remove it if it does 
echo Checking for existing container... 
docker ps -a --filter "name=open-webui" --format "{{.Names}}" | findstr "open-webui" >nul 
if not errorlevel 1 ( 
	echo Removing old open-webui container... 
	docker rm -f open-webui >nul 2>&1 
) 

REM -- 6. Start the OpenWebUI Docker container 
echo Starting new OpenWebUI Docker container... 
docker run -d -p 3000:8080 --add-host=host.docker.internal:host-gateway -v open-webui:/app/backend/data -e OLLAMA_BASE_URL=http://host.docker.internal:11434 --name open-webui --restart unless-stopped ghcr.io/open-webui/open-webui:main 

REM -- 7. Final instructions 
echo. 
echo ======================================== 
echo Startup complete! 
echo. 
echo 1. Your LLM is now running. 
echo 2. Open your browser and go to: http://localhost:3000 
echo 3. To stop everything, run the 'stop_llm.bat' script. 
echo ======================================== 
echo. 

REM -- Auto-open the browser for convenience 
start http://localhost:3000 
pause