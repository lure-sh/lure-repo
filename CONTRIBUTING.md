# Contributing to LURE's default repo

## Table of Contents

- [How to add a package](#how-to-add-a-package)
- [Pull Request guidelines](#pull-request-guidelines)
    - [Commit titles](#commit-titles)
    - [Pull Request titles](#pull-request-titles)

## How to add a package

1. To create the package, have a look at LURE's [Build Script documentation](https://github.com/Arsen6331/lure/blob/master/docs/packages/build-scripts.md). You can also use any of the existing packages in this repository as examples.
2. Once you've created the package, make sure it follows the [Package Conventions](https://github.com/Arsen6331/lure/blob/master/docs/packages/conventions.md).
3. When you're sure everything is correct, read through the [Adding Packages documentation](https://github.com/Arsen6331/lure/blob/master/docs/packages/adding-packages.md), which will explain how packages are stored in LURE repos and what the submission process will look like.
4. Create a PR that conforms to the following guidelines in the [Pull Request guidelines](#pull-request-guidelines) section.
5. Fix any issues the LURE repo bot reports, and wait for your PR to be merged.
6. You're done! The [LURE web interface](https://lure.arsenm.dev) should automatically update to show your new package. You can share your addition on LURE's [subreddit](https://reddit.com/r/linux_user_repository)!

## Pull Request guidelines

### Commit titles

Commit titles should be formatted as `$action($modified_package): $info`. The package may be omitted if it's not being modified (such as if it's being added or deleted), or if no package is being modified. Here are some examples:

- `add: jetbrains-toolbox`
- `del: jetbrains-toolbox`
- `upg(obsidian): 1.1.9`
- `fix(admc): remove unnecessary dependencies`
- `doc: add rules for PR and commit titles to contribution guidelines`
- `translate(go-bin): ru, es, zh`

### Pull Request titles

While PRs that make multiple changes are discouraged, if one is submitted, it should be titled with all the changes separated by semicolons. For example:

- `add: jetbrains-toolbox; upg(obsidian): 1.1.9`

If the PR is not named as such, it will be renamed before merging.
