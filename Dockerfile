#FROM node:18-slim
FROM mcr.microsoft.com/playwright:v1.48.1-focal

# Install dependencies for Playwright
RUN apt-get update && apt-get upgrade -y

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