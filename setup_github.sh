#!/bin/bash

# Script to push project_mern_memories to your GitHub account
# Run this after installing Xcode command line tools

echo "Setting up git repository..."

# Initialize git repository
git init

# Add all files
git add .

# Create initial commit
git commit -m "Initial commit: Cloned from adrianhajdin/project_mern_memories"

# Set remote origin to your GitHub account
git remote add origin https://github.com/Mukul9090/project_mern_memories.git || \
git remote set-url origin https://github.com/Mukul9090/project_mern_memories.git

# Rename branch to main (if needed)
git branch -M main

echo ""
echo "✅ Repository is ready!"
echo ""
echo "📝 Next steps:"
echo "1. Create a new repository named 'project_mern_memories' on GitHub at: https://github.com/Mukul9090"
echo "2. Then run: git push -u origin main"
echo ""
echo "Or if you want to push to an existing repository with a different name, update the remote URL above."

