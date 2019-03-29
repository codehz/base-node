FROM codehz/node:latest

LABEL "name"="node-builder"
LABEL "maintainer"="CodeHz <CodeHz@outlook.com>"
LABEL "version"="0.0.1"

LABEL "com.github.actions.name"="Node Builder"
LABEL "com.github.actions.description"="Build minimal node image"
LABEL "com.github.actions.icon"="terminal"
LABEL "com.github.actions.color"="lime"

COPY "entrypoint.sh" "/entrypoint.sh"
ENTRYPOINT ["/entrypoint.sh"]