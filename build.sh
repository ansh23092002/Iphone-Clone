#!/bin/bash

# iPhone Clone - Build Script
# This script builds the iPhone Clone project for production

set -e  # Exit on any error

echo "============================================"
echo "    iPhone Clone - Build Script"
echo "============================================"
echo

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

print_info() {
    echo -e "${BLUE}[i]${NC} $1"
}

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    print_error "package.json not found. Please run this script from the project root directory."
    exit 1
fi

# Step 1: Install dependencies
print_info "Step 1/5: Installing dependencies..."
if [ ! -d "node_modules" ]; then
    npm install
    if [ $? -eq 0 ]; then
        print_status "Dependencies installed successfully"
    else
        print_error "Failed to install dependencies"
        exit 1
    fi
else
    print_status "Dependencies already installed"
fi

echo

# Step 2: Run linting
print_info "Step 2/5: Running linting..."
npm run lint
if [ $? -eq 0 ]; then
    print_status "Linting completed successfully"
else
    print_warning "Linting failed, but continuing with build..."
fi

echo

# Step 3: Build the application
print_info "Step 3/5: Building application..."
npm run build
if [ $? -eq 0 ]; then
    print_status "Build completed successfully"
else
    print_error "Build failed"
    exit 1
fi

echo

# Step 4: Check build output
print_info "Step 4/5: Checking build output..."
if [ -d "dist" ]; then
    BUILD_SIZE=$(du -sh dist | cut -f1)
    print_status "Build output created in dist/ (${BUILD_SIZE})"
else
    print_error "Build output directory not found"
    exit 1
fi

echo

# Step 5: Start preview server (optional)
print_info "Step 5/5: Starting preview server..."
print_info "Preview server will be available at: http://localhost:4173"
print_info "Press Ctrl+C to stop the server"

# Start preview server in background
npm run preview &
PREVIEW_PID=$!

# Wait a moment for server to start
sleep 3

# Check if server is running
if kill -0 $PREVIEW_PID 2>/dev/null; then
    print_status "Preview server started successfully (PID: $PREVIEW_PID)"
    echo
    echo "============================================"
    echo "           Build Summary"
    echo "============================================"
    echo "Build Output: $(pwd)/dist"
    echo "Build Size:   ${BUILD_SIZE}"
    echo "Preview URL:  http://localhost:4173"
    echo "============================================"
    echo
    print_status "Build completed successfully! 🎉"
    echo
    print_info "Press Ctrl+C to stop the preview server and exit"
    wait $PREVIEW_PID
else
    print_error "Preview server failed to start"
    exit 1
fi