# Migration Steps for the Unity Package Release Workflow

This manual describes the migration steps required to update the Unity package
release workflow so it works with the signing feature introduced in Unity 6.3.

## Step 1 - Add CHANGELOG.md

Create CHANGELOG.md in the repository root based on the following file:

https://gist.githubusercontent.com/keijiro/5fc40f713538a819329685d30ee782ff/raw/f3490453d1ae8d70ce0b7d0e6391fc657e4863ff/CHANGELOG.md

Remove any placeholders and append entries for the two most recent versions.

The “two most recent versions” refers to the latest two releases available on
GitHub. These can be listed using the following `gh` command:

```
gh release list --limit 2
```

Summarize the details of these releases based on the release notes (also
retrievable with `gh`) and the git commit logs.

## Step 2 - Update package.json

Update package.json inside Packages/jp.keijiro.(package-id). Use the following
file as a reference:

https://raw.githubusercontent.com/keijiro/UnityCustomPackageTest/refs/heads/master/Packages/jp.keijiro.unity-custom-package-test/package.json

Reorder the elements to match the reference and add missing fields such as
changelogUrl. Derive the URLs from the git remote. Remove unused entries such as
`keywords` and `unityRelease`.

Add an empty changelog entry inside the "_upm" element. This value will be
generated when preparing the next release, so it should remain empty for now.

## Step 3 - Copy CHANGELOG.md

Copy the CHANGELOG.md created in Step 1 into the package directory.

## Step 4 - Create AGENTS.md

Copy the following AGENTS.md file into the repository root:

https://raw.githubusercontent.com/keijiro/UnityCustomPackageTest/refs/heads/master/AGENTS.md

## Step 5 - Ignore the tarball

Add "/*.tgz" to .gitignore.

## Step 6 - Remove the .github Directory

Delete the .github directory because GitHub Actions are no longer required.

## Step 7 - Finish Up

Finally, ask the user to perform the following actions:

- Open this project in the Unity Editor to generate .meta files.
- Commit and push every change if there are no issues.
