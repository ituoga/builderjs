FROM node:14.21.0-alpine
RUN apk add python3 py3-pip python3-dev make g++ alpine-sdk 
RUN ln -sf /usr/bin/python3 /usr/bin/python
RUN npm install -g node-gyp prebuild-install
RUN apk add bash
RUN npm install -g opencollective-postinstall
RUN echo "#!/bin/bash -x" > /usr/local/bin/hack.sh
RUN echo "echo wrapper" >> /usr/local/bin/hack.sh
RUN echo "source /.entrypoint.env 2>/dev/null" >> /usr/local/bin/hack.sh
RUN echo "python --version" >> /usr/local/bin/hack.sh
RUN echo "exec /bin/bash \"\$@\"" >> /usr/local/bin/hack.sh
RUN chmod +x /usr/local/bin/hack.sh

RUN mv /usr/local/bin/npm /usr/local/bin/npm2
RUN echo "#!/bin/sh" > /usr/local/bin/npm
RUN echo "export PYTHON=/usr/bin/python3" >> /usr/local/bin/npm
RUN echo "export npm_config_script_shell=/usr/local/bin/hack.sh" >> /usr/local/bin/npm
RUN echo "/usr/local/bin/npm2 config set python /usr/bin/pytnon3" >> /usr/local/bin/npm
RUN echo "printenv > /.entrypoint.env" >> /usr/local/bin/npm
RUN echo "/usr/local/bin/npm2 \$@" >> /usr/local/bin/npm
RUN chmod +x /usr/local/bin/npm
RUN npm i -g laravel-mix
ENV npm_config_script_shell=/usr/local/bin/hack.sh