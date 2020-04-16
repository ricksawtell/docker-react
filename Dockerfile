# Build Phase.   We tagges this as builder
FROM node:alpine
WORKDIR '/app'
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Prod phase.  We fire up nginx and get the results of the builder phase
# which is under the /app/build directory

FROM nginx

#Expose port number in AWS
EXPOSE 80

# Copy something over from the "builder" phase
COPY --from=0 /app/build /usr/share/nginx/html

#Don't need to add a start command here.  It's default command is start
