FROM node:latest AS builder

WORKDIR /app

# COpying package.json to install the dependencies
COPY package.json .
COPY package-lock.json .

# Installing the dependencies
RUN npm install

# Copying the source code
COPY . .

# Building the application
RUN npm run build

# Using lighter image for running the application build
FROM nginx:alpine

# Copying the build files to the nginx server
COPY --from=builder /app/build /usr/share/nginx/html

# Exposing the port
EXPOSE 80

# Running the nginx server
CMD ["nginx", "-g", "daemon off;"]
