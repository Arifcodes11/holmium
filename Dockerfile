# Step 1: Use Ubuntu as base image
FROM ubuntu:22.04

# Step 2: Install Node.js v22.14.0 and npm
RUN apt-get update && apt-get install -y curl ca-certificates gnupg && \
  mkdir -p /etc/apt/keyrings && \
  curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
  NODE_MAJOR=22 && \
  echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_22.x nodistro main" > /etc/apt/sources.list.d/nodesource.list && \
  apt-get update && \
  apt-get install -y nodejs && \
  node -v && \
  npm -v && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Step 3: Create app directory
WORKDIR /app

# Step 4: Copy package.json and package-lock.json for better caching
COPY package*.json ./

# Step 5: Install dependencies
RUN npm install --production

# Step 6: Copy remaining source files
COPY . .

# Step 7: Expose port 3000
EXPOSE 3000

# Step 8: Run the application
CMD ["npm", "start"]