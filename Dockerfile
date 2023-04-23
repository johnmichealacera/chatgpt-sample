# Base image
FROM node:14-alpine

# Set working directory
WORKDIR /app

# Set environment variables
ENV VUE_APP_CHATGPT_API_KEY=''

# Set environment variable
ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

# Copy package.json and package-lock.json to container
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy source files to container
COPY . .

# Expose the app port
EXPOSE 8080

# Set environment-specific default command
CMD if [ "$NODE_ENV" = "production" ]; \
    then npm run build && npx serve dist -p 8080; \
    else npm run serve -- --port 8080; \
    fi

