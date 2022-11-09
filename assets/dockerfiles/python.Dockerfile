FROM python:3.11-alpine


RUN apk add --no-cache nodejs npm

RUN mkdir -p /opt/node
WORKDIR /opt/node
ADD "https://www.random.org/cgi-bin/randbyte?nbytes=10&format=h" skipcache
COPY ./assets/packaging/package.json /opt/node
RUN cd /opt/node && npm update -f

WORKDIR /usr/src/app

RUN pip install --upgrade pip

COPY ./hello_world/requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

CMD [ "node", "/opt/node/node_modules/nodemon/bin/nodemon.js", "./hello_world.py" ]
