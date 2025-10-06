![Local LLM image](llm.jpg)

# local-LLM
This project is an offline, portable LLM that can search for answers in a collection of PDF files that I will provide. The reason behind that was to create an AI assistant that you can carry with you everywhere, without any loss in functionality, that is offline for reasons of privacy and lack of limitaions on input and that can read a given body of knowledge for industry specific advice. So I created this step-by-step guide to assist also others who want to do the same.

First step (One time installation on a new Host Machine):
  - Install Docker Desktop. Leave the default settings and after installation run it. Docker needs to be running every time you want to access your LLM.

Second step:
  - Create the following folder structure in your external drive "Ollama\models".
  - Install Ollama.
  - Open Ollama. Go to its Settings and change the "Model Location" to show to your "Ollama\models" folder that you created earlier.

Third step:
  - Open a text editor and create the scripts "start_llm.bat" and "stop_llm.bat". Save these scripts in the root of your external drive (e.g. "E:\). You will find the code for both of them in the attached files. The first script checks if Docker is running, starts Ollama, and launches the OpenWebUI container with a bind mount for persistence. The second script safely stops and cleans up all running processes.

Fourth step:
  - After making sure that Docker is running, double-click on "start_llm.bat". If this is the first time you run it, it will check if Docker is running, start the ollama server and install OpenWebUI as a container on Docker. After it finishes this process, it will open a new tab in your browser that will take you to "http://localhost:3000". This is the OpenWebUI interface. The first time it will ask you to create an account (don't worry, this is created locally).

Fifth step:
  - Open a new Command Prompt.
  - Download your preferred LLM. I chose phi3:mini. If you want to download the same model, run the command "ollama pull phi3:mini". The LLM you can use largely depends on your device's specifications. To browse different LLM models, go to https://ollama.com/search.
  - After it is done, go back to OpenWebUI, choose the model you just downloaded from the drop-down list on the top left corner and ask a question to your new LLM.

Sixth step (Creating a KB of documents):
  - Open the sidebar on the left pane of OpenWebUI and choose Workspace.
  - Then choose the second tab Knowledge and click on the plus (+) sign on the right side of the page.
  - Give a name and a description to your Knowledge Base and click on "Create Knowledge".
  - Next choose the Collection you just created and click on the plus sign on the right to add your documents.
  - Once all documents have been uploaded, click on the tab that says Models and then the plus sign on the right, to create a new Model.
  - Give a name to your model, choose the LLM you downloaded as your base model and don’t forget to scroll down and click “Select Knowledge” to connect it with the knowledge base you created earlier.
  - Tick or untick any boxes regarding the extra functionality you might want and click “Save and Create”.

Final step:
  - Click “New Chat” on the sidebar on the left, choose the model you just created from the drop-down list on the top left corner and ask your local LLM any question you want and it will provide an answer from the files in your Collection with references.

If you have reached this far, congratulations! You did it! Now you have your offline LLM! Next time you want to use it at a new device, just download Docker and Ollama, change the Model location in Ollama and run the scripts we created earlier. And that’s it!
