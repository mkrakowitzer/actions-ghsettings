FROM debian
WORKDIR .
# Copy our static executable.
RUN apt-get update && apt-get install -y curl jq zip &&  apt-get clean
RUN export GHSETTINGS=$(curl -s https://api.github.com/repos/mkrakowitzer/ghsettings/releases/latest | jq -r '.assets[].browser_download_url') && curl -L $GHSETTINGS -O
RUN unzip gh-settings.zip && rm -f gh-settings.zip && chmod 700 ./ghsettings
# Run the hello binary.
ENTRYPOINT ["/ghsettings"]
