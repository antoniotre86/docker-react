# Build phase
# the "as builder" sets the tag for this section
FROM node:alpine
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Run phase
# don't need to set a new tag here
FROM nginx 
EXPOSE 80
COPY --from=0 /app/build /usr/share/nginx/html  
# "--from" references the files in the container created in the referenced block
# no need for a cmd; nginx base image has it set up already