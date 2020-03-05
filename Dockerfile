FROM homebrew/brew:latest

COPY brew-audit.json /

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
