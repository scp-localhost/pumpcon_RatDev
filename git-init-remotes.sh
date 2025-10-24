#!/bin/bash

# === CONFIG ===
REPO_NAME="pumpcon_RatDev"
LOCAL_GITLAB_URL="http://192.168.0.15/scp-localhost/$REPO_NAME.git"
GITHUB_URL="git@github.com:scp-localhost/$REPO_NAME.git"
GITLAB_PUBLIC_URL="https://gitlab.com/scp-localhost/$REPO_NAME.git"
DEFAULT_BRANCH="patient0"
COMMIT_MESSAGE="Initial commit (automated)"

# === INIT ===
if [ ! -d .git ]; then
  echo "🌀 Initializing Git repo..."
  git init -b "$DEFAULT_BRANCH"
fi

# === REMOTE SETUP ===
echo "🔗 Setting up remotes..."
git remote remove origin 2>/dev/null
git remote remove github 2>/dev/null
git remote remove gitlab-public 2>/dev/null

git remote add origin "$LOCAL_GITLAB_URL"
git remote add github "$GITHUB_URL"
git remote add gitlab-public "$GITLAB_PUBLIC_URL"

# === STAGE + COMMIT ===
if [ -z "$(git status --porcelain)" ]; then
  echo "✅ No changes to commit."
else
  echo "📦 Adding and committing changes..."
  git add .
  git commit -m "$COMMIT_MESSAGE"
fi

# === PUSH TO ALL ===
echo "🚀 Pushing to local GitLab (origin)..."
git push -u origin "$DEFAULT_BRANCH"

echo "🚀 Pushing to GitHub..."
git push -u github "$DEFAULT_BRANCH"

echo "🚀 Pushing to Public GitLab..."
git push -u gitlab-public "$DEFAULT_BRANCH"

echo "✅ All remotes initialized and pushed."
