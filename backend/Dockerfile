
FROM node:current-slim  


WORKDIR /backend

# Copy package.json and package-lock.json first (for caching)
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy the rest of the source code
COPY . .


EXPOSE 3000

# Start the app
CMD ["node", "app.js"]
