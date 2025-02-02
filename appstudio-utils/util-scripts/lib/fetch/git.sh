
git-fetch-repo() {
  local repo=$1
  local ref_or_sha=$2
  local directory="$3"

  mkdir -p "$directory"
  cd "$directory"

  # Git clone might work but this avoids downloading the entire repo
  git init -q .
  git fetch -q --depth 1 --no-tags $repo $ref_or_sha
  git checkout -q FETCH_HEAD

  git rev-parse FETCH_HEAD
}

git-fetch-policies() {
  echo "Fetching policies from $POLICY_REPO_REF at $POLICY_REPO"
  echo "sha: $( git-fetch-repo $POLICY_REPO $POLICY_REPO_REF $POLICIES_DIR )"

  # Clean up files we don't need including .git
  cd $POLICIES_DIR
  rm -rf .git .github .gitignore README.md Makefile scripts
}
