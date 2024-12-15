FROM node:18-slim

# Install dependencies for Playwright
RUN apt-get update && apt-get install -y \
    libglib2.0-0 \
    libnss3 \
    libnspr4 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libdbus-1-3 \
    libxcb1 \
    libxkbcommon0 \
    libx11-6 \
    libxcomposite1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libpango-1.0-0 \
    libcairo2 \
    libasound2 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci

# Copy the rest of the code
COPY . .

# Install Playwright browsers
RUN npx playwright install

# Command to run tests
CMD ["npx", "playwright", "test"]

# Docker comands needed for:
#
#   C:\code\docker_playwright_demo>docker build -t my-playwright-project .  
#
#   docker run --rm -v "%cd%/playwright-report:/app/playwright-report" my-playwright-project using CMD
#   docker run --rm -v "${PWD}/playwright-report:/app/playwright-report" my-playwright-project using Powershell
#
#   npx playwright show-report