# Use a lightweight web server image
FROM nginx:alpine

# Copy the static assets to the appropriate location in the container
COPY static /usr/share/nginx/html/static

# Expose the desired port (e.g., 80)
EXPOSE 80

# Start the web server
CMD ["nginx", "-g", "daemon off;"]