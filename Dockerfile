# Use a lightweight base image
FROM nginx:alpine

# Set the working directory
WORKDIR /usr/share/nginx/html

# Copy the static files to the working directory
COPY . .

# Expose port 80 (the default port for HTTP)
EXPOSE 80

# Start the nginx server
CMD ["nginx", "-g", "daemon off;"]


# # Use a base image with Node.js
# FROM node:14 as builder

# # Set the working directory inside the container
# WORKDIR /app

# # Copy the package.json and package-lock.json files
# COPY package*.json ./

# # Install dependencies
# RUN npm install

# # Copy the rest of the application files
# COPY . .

# # Build the Angular app
# RUN npm run build --prod

# # Use a lightweight base image to serve the app
# FROM nginx:alpine

# # Copy the built application files to the Nginx public directory
# COPY --from=builder /app/dist/* /usr/share/nginx/html/

# # Expose port 80
# EXPOSE 80

# # Start Nginx when the container starts
# CMD ["nginx", "-g", "daemon off;"]