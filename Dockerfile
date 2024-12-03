# Stage 1: Build the application
FROM node:alpine AS builder

# Set working directory
WORKDIR /usr/src/app

# Install dependencies (only production dependencies to reduce size)
COPY package*.json ./
RUN npm install --production

# Copy application files
COPY . .

# Stage 2: Create the final lightweight image
FROM node:alpine

# Set working directory
WORKDIR /usr/src/app

# Copy only the built application from the builder stage
COPY --from=builder /usr/src/app .

# Expose the port
EXPOSE 3000

# Run the application
CMD ["node", "app.js"]
