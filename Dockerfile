
 # Step 1: Build the static app using an Alpine image
FROM golang:1.20-alpine AS builder

# Set up working directory
WORKDIR /app

# Copy the dispatcher and static files
COPY dispatcher.go ./
COPY static/ static/

# Install dependencies and build the dispatcher
RUN go build -o /dispatcher dispatcher.go

# Step 2: Create the final lightweight image
FROM alpine:3.18

# Install certificates for HTTPS requests
RUN apk --no-cache add ca-certificates

# Set up working directory
WORKDIR /app

# Copy the built dispatcher and static files from the builder stage
COPY --from=builder /dispatcher /app/
COPY --from=builder /app/static /app/static

# Expose port 80 for the application
EXPOSE 80

# Run the dispatcher
CMD ["/app/dispatcher"]


# OLD CODE
# ---------------------
# # Use a lightweight web server image
# FROM nginx:alpine

# # Copy the static assets to the appropriate location in the container
# COPY static /usr/share/nginx/html/static

# # Expose the desired port (e.g., 80)
# EXPOSE 80

# # Start the web server
# CMD ["nginx", "-g", "daemon off;"]