#!/bin/bash

# Function to check if a directory is a Maven project
is_maven_project() {
  if [ -f "pom.xml" ]; then
    return 0
  else
    return 1
  fi
}

# Function to check if a directory is a Gradle project
is_gradle_project() {
  if [ -f "build.gradle" ]; then
    return 0
  else
    return 1
  fi
}

# Function to search and replace string in pom.xml file
replace_string_in_pom() {
  search_string=$1
  replace_string=$2
  sed -i "s/$search_string/$replace_string/g" "pom.xml"
}

# Function to create a branch, commit changes, and push
create_branch_commit_push() {
  branch_name=$1
  commit_message=$2

  git checkout -b "$branch_name"
  git add .
  git commit -m "$commit_message"
  git push origin "$branch_name"
}

# Main script starts here

if [ $# -eq 0 ]; then
  echo "Usage: $0 <repo> or $0 -csv <path_to_csv>"
  exit 1
fi

if [ "$1" = "-csv" ]; then
  csv_path=$2
  IFS=$'\n' read -d '' -r -a repos < "$csv_path"
else
  repos=("$@")
fi

read -p "Enter the string to search for in pom.xml: " search_string

read -p "Enter the string to replace it with: " replace_string

for repo in "${repos[@]}"; do
  # Clone the repo
  git clone "$repo"

  # Get the repo name
  repo_name=$(basename "$repo" .git)

  # Move into the repo directory
  cd "$repo_name" || continue

  # Check if it's a Maven project
  if is_maven_project; then
    echo "Maven project found: $repo_name"

    # Perform search and replace in pom.xml
    replace_string_in_pom "$search_string" "$replace_string"

    # Commit changes and push to a branch
    create_branch_commit_push "update_$search_string" "Updated $search_string to $replace_string"
  elif is_gradle_project; then
    echo "Gradle project found: $repo_name"
    # Add code here for Gradle-specific actions (if needed)
  else
    echo "Not a Maven or Gradle project: $repo_name"
  fi

  # Move back to the original directory for the next iteration
  cd ..
done
