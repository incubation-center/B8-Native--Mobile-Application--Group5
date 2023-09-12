# Use an official Node.js runtime as a parent image
FROM node:18

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of application code to the working directory
COPY . .

# Build your TypeScript code
RUN npm run build

# Expose the port application will run on (adjust as needed)
EXPOSE 8000

# Define the NODE_ENV environment variable (e.g., 'development' or 'production')
ARG NODE_ENV
ENV NODE_ENV=${NODE_ENV}

# Command to run TypeScript application
CMD ["node", "dist/app.js"]
