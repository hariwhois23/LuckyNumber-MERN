FROM node:current-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies and auto-fix vulnerabilities
RUN npm install && npm audit fix --force && npm install -g serve

# Copy source code
COPY . .

# Build optimized frontend
RUN npm run build

# Expose app port
EXPOSE 5713

# Serve the production build
CMD ["serve", "-s", "dist", "-l", "5713"]
