#!/bin/bash

# Your GitHub personal access token
GITHUB_TOKEN="YOUR_PERSONAL_ACCESS_TOKEN"

# Base URL for the GitHub API
GITHUB_API="https://api.github.com"

# Function to search for repositories
search_repositories() {
    query="$1"
    url="$GITHUB_API/search/repositories?q=$query"
    response=$(curl -s -H "Authorization: token $GITHUB_TOKEN" "$url")
    echo "$response" | jq '.items[] | .name, .description, .html_url'
}

# Function to get repository details
get_repository_details() {
    owner="$1"
    repo="$2"
    url="$GITHUB_API/repos/$owner/$repo"
    response=$(curl -s -H "Authorization: token $GITHUB_TOKEN" "$url")
    echo "$response" | jq '.name, .description, .html_url, .language, .stargazers_count, .forks_count'
}

# Main menu
while true; do
    clear
    echo "GitHub Interaction Script"
    echo "1. Search for repositories"
    echo "2. Get repository details"
    echo "3. Quit"
    read -p "Enter your choice: " choice

    case $choice in
        1)
            read -p "Enter search query: " query
            search_repositories "$query"
            read -p "Press Enter to continue..."
            ;;
        2)
            read -p "Enter owner (username/organization): " owner
            read -p "Enter repository name: " repo
            get_repository_details "$owner" "$repo"
            read -p "Press Enter to continue..."
            ;;
        3)
            echo "Goodbye!"
            exit 0
            ;;
        *)
            echo "Invalid choice. Please try again."
            read -p "Press Enter to continue..."
            ;;
    esac
done
