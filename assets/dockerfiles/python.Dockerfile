FROM python:3.11-alpine

# Add node (with npm) to the python base.
RUN apk add --no-cache nodejs npm

# Create a directory for the node project for devops and go to it.
RUN mkdir -p /opt/node
WORKDIR /opt/node

# This is a cache-bust line in case you need it. Taken from https://stackoverflow.com/a/58801213/5583468
#ADD "https://www.random.org/cgi-bin/randbyte?nbytes=10&format=h" skipcache

# Copy in the package.json file with any dev dependencies.
COPY ./assets/packaging/package.json /opt/node
# Update the node installation with dependencies from package.json using npm.
RUN cd /opt/node && npm update -f

# Go to the python source directory.
WORKDIR /usr/src/app
# Update pip, just in case it's out of date.
RUN pip install --upgrade pip
# Copy in the requirements.txt file.
COPY ./hello_world/requirements.txt .
# Run pip to install python dependencies.
RUN pip install --no-cache-dir -r requirements.txt

# Run the python script through nodemon.
CMD [ "node", "/opt/node/node_modules/nodemon/bin/nodemon.js", "./hello_world.py" ]
