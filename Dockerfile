# Build Phase.   We tagges this as builder
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Prod phase.  We fire up nginx and get the results of the builder phase
# which is under the /app/build directory

FROM nginx
# Copy something over from the "builder" phase
COPY --from=builder /app/build /usr/share/nginx/html

#Don't need to add a start command here.  It's default command is start
