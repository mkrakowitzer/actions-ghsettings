FROM alpine
WORKDIR .
# Copy our static executable.
RUN apk update && apk add curl jq zip && rm -rf /var/cache/apk/*
RUN export GHSETTINGS=$(curl -s https://api.github.com/repos/mkrakowitzer/ghsettings/releases/latest | jq -r '.assets[].browser_download_url') && curl -L $GHSETTINGS -O
RUN unzip gh-settings.zip && rm -f gh-settings.zip && chmod 700 ./ghsettings
# Run the hello binary.
ENTRYPOINT ["/ghsettings"]
