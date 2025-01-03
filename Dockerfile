# Docker image for E4GL_BF4Status_DiscordBot
# Creator:  H3dius/Hedius gitlab.com/hedius
FROM arm64v8/python:3.12

# User and Group ID of the account used for execution
ARG UID=4000
ARG GID=4000

LABEL maintainer="Hedius @ gitlab.com/hedius" \
      description="image for E4GL_BF4StatusBot" \
      version="1.2.0"

# account for execution of script
RUN groupadd -r -g $GID  pythonRun && \
    useradd -r -g pythonRun -u $UID pythonRun

COPY --chown=pythonRun:pythonRun src /usr/src/app

WORKDIR /usr/src/app

# Install dependencies
RUN python3 -m pip install --upgrade pip
#RUN pip3 install --no-cache-dir -r requirements.txt # Some dependencies were crashing my Container, then I added a manually setup:
RUN python3 -m pip install --upgrade pip
RUN pip3 install --no-cache-dir setuptools==69.0.3
RUN pip3 install --no-cache-dir nextcord==2.5.0
RUN pip3 install --no-cache-dir aiohttp==3.9.1
RUN pip3 install --no-cache-dir numpy==1.26.2
RUN pip3 install --no-cache-dir dynaconf==3.2.4


RUN chown pythonRun:pythonRun -R /usr/src/app

USER pythonRun:pythonRun

CMD ["python3", "runBF4StatusBot.py", "-c", "/usr/src/app/config"]FROM arm64v8/python:3.12


