# Setting a base image for the build phase (fetching node dependencies, building the application, etc)
FROM node:alpine as builder

# Setting the work directory
WORKDIR '/app'

# Fetching the list of dependencies
COPY package.json .
# Installing the dependencies
RUN npm install
# Copying the results into the container
COPY . .
# Building the application
RUN npm run build

# Setting a base image for the second phase: using nginx with the built application
FROM nginx

# Copying the built application from the previous phase.
COPY --from=builder /app/build /usr/share/nginx/html
