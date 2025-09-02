@echo off 
echo Stopping your Portable LLM Server... 
echo. 

REM -- 1. Stop and remove the OpenWebUI Docker container 
echo Stopping Docker container... 
docker stop open-webui 2>nul 
echo Removing Docker container... 
docker rm open-webui 2>nul 

REM -- 2. Stop the Ollama server process 
echo Stopping Ollama server... 
taskkill /IM "ollama_app.exe" /F /T 2>nul 
taskkill /IM "ollama.exe" /F /T 2>nul 

echo. 
echo All services have been stopped. It is now safe to close any windows and eject your drive. 
pause