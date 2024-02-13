# Setting base image
FROM node:18

# Update npm
RUN npm update -g

# Install tools
RUN npm install -g vue@latest
RUN npm install -g create-vue

# Setting
WORKDIR /app
