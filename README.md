<p align="center">
  <a href="http://codely.tv">
    <img src="http://codely.tv/wp-content/uploads/2016/05/cropped-logo-codelyTV.png" width="192px" height="192px"/>
  </a>
</p>

<h1 align="center">
  👤 Assign Pull Request by modified path
</h1>

<p align="center">
    <a href="https://github.com/CodelyTV"><img src="https://img.shields.io/badge/CodelyTV-OS-green.svg?style=flat-square" alt="codely.tv"/></a>
    <a href="http://pro.codely.tv"><img src="https://img.shields.io/badge/CodelyTV-PRO-black.svg?style=flat-square" alt="CodelyTV Courses"/></a>
    <a href="https://github.com/marketplace/actions/pull-request-assign-by-path"><img src="https://img.shields.io/github/v/release/CodelyTV/assign-by-path?style=flat-square" alt="GitHub Action version"></a>
</p>

<p align="center">
    Assign Pull Requests to your GitHub teams or individual users based on the paths of the modified files
</p>

## 🚀 Usage

☝️ Create a file named `assign-by-path.yml` inside the `.github/workflows` directory and paste:

```yml
name: assign-by-path

on: [push]

jobs:
  assigner:
    runs-on: ubuntu-latest
    name: 👤 Assign by path
    steps:
      - uses: codelytv/assign-by-path@v1
        with:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

✌️ Create a file named `assign_by_path_mappings.yml` inside the `.github` directory.

This file must contain the association between your GitHub teams or people to assign PRs (mapping keys) and paths.

In the following example, we will be assigning the PRs that modifies files inside the `src/mooc` folder to the `mooc` team:

```yml
assign:
  mooc: ["src/mooc", "src/shared"]
  retention: ["src/retention"]
  backoffice: ["src/backoffice", "src/analytics"]
```

## 💡 Use case examples

You can combine this action with others such as:

* Notify to the Slack channel `#mooc-team` when a PR has been assigned to the `mooc` GitHub team
* Send an email to `mooc-team+notifications@example.com` when a PR has been assigned to the `mooc` GitHub team
* You name it! Composition over Inheritance FTW! 😊

## ⚖️ License

[MIT](LICENSE)
