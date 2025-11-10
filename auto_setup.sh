#!/bin/bash

# Auto-setup script that waits for git to be available, then sets up the repository

echo "⏳ Waiting for Xcode Command Line Tools installation to complete..."
echo "   (Please complete the installation dialog if it's still open)"
echo ""

# Wait for git to be available (check every 5 seconds, max 5 minutes)
MAX_WAIT=60
WAIT_COUNT=0

while ! git --version &>/dev/null; do
    if [ $WAIT_COUNT -ge $MAX_WAIT ]; then
        echo "❌ Timeout: Git is still not available. Please ensure Xcode Command Line Tools installation is complete."
        exit 1
    fi
    sleep 5
    WAIT_COUNT=$((WAIT_COUNT + 5))
    echo "   Still waiting... ($WAIT_COUNT seconds)"
done

echo "✅ Git is now available!"
echo ""

# Navigate to project directory
cd "$(dirname "$0")"

# Initialize git repository
echo "📦 Initializing git repository..."
git init

# Add all files
echo "📝 Adding files..."
git add .

# Create initial commit
echo "💾 Creating initial commit..."
git commit -m "Initial commit: Cloned from adrianhajdin/project_mern_memories"

# Set remote origin to your GitHub account
echo "🔗 Setting up remote repository..."
git remote add origin https://github.com/Mukul9090/project_mern_memories.git 2>/dev/null || \
git remote set-url origin https://github.com/Mukul9090/project_mern_memories.git

# Rename branch to main
git branch -M main

echo ""
echo "✅ Repository setup complete!"
echo ""
echo "📋 Next steps:"
echo "1. Go to https://github.com/Mukul9090 and create a new repository named 'project_mern_memories'"
echo "   (Do NOT initialize with README, .gitignore, or license)"
echo ""
echo "2. Once the repository is created, run:"
echo "   git push -u origin main"
echo ""
echo "3. Enter your GitHub username and password/token when prompted"
echo ""

