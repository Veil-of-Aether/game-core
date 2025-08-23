# Contributing to *The Veil of Aether*

Thank you for your interest in contributing to the Veil of Aether! Please read the guidelines if you aren't yet familiar with them.

## Table of Contents
- [Code of Conduct](#code-of-conduct)
- [How to Contribute](#how-to-contribute)
  - [Reporting Problems](#reporting-problems)
  - [Suggesting Plot Elements](#suggesting-plot-elements)
  - [Submitting Changes](#submitting-changes)
- [Style Guide](#style-guide)
- [License](#license)

---

### Code of Conduct

We’re committed to creating a welcoming and respectful environment for everyone. All contributors are expected to:

- Be kind and constructive in all communications.

- Respect differing opinions and experiences.

- Avoid personal attacks, harassment, and discriminatory language.

see [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) for more details. By participating in this project, you agree to uphold these standards.

---

### How to Contribute

#### Reporting Problems

If you encounter a problem or inconsistency, please check the [issues](https://gitlab.com/veil-of-aether/game-core/-/issues) to see if it has already been reported. If not, you can report it by opening a new issue.

- Provide a **clear description** of the issue.
- If applicable, explain how you would recommend it be fixed

#### Suggesting Features

We welcome suggestions for new features or game mechanics! If you have an idea, feel free to open a [new issue](https://gitlab.com/veil-of-aether/game-core/-/issues) with a label that describes the feature you want.

- Explain in detail what this feature is
- Describe how the feature would add to gameplay
- Keep the feature aligned with the vision and theme of *The Veil of Aether*.

#### Submitting Changes

We are happy to accept direct contributions! Here's how to get started:

Please note that this guide expects you to be at least somewhat familiar with both Git and GitLab

1. **Fork** the repository
2. **Clone** your repository onto you local machine
  ```bash
  git clone git@gitlab.com:yourname/yourrepo
  ```
3. **Create a new branch** for your contribution
  - choose a descriptive name for your branch
  ```bash
  git checkout -b yourbranchname
  ```
3. **Make your changes**, following the style guide below.
  - make any necessary changes using whatever tools are necessary
4. **Commit** your changes with a clear, descriptive message:
   ```bash
   git commit -m "a short description of changes"
   git push
   ```
5. **Create a merge request** to the main repository. Be sure to explain what your changes do and why they are necessary.
  - Write a descriptive summary of your changes before submitting your merge request

A maintainer will review your merge request

---

### Style Guide

To maintain consistency across the repository, please follow these style guidelines:

- **Language**: This should be obvious, but please don't attempt to use any programming language other than GDScript in the project
- **Comments**: Please add comments to describe what your code is doing. This helps both you and anyone else working with your code determine what each part of your code does
- **Naming Conventions**: Functions and variables should be in lower_snake_case, while constants should be in UPPER_SNAKE_CASE. This helps us keep the codebase consistent.
- **File Names**: File names should be in lower_snake_case and each script should match the name of what it is for, with the .gd extension.
- **Commit Messages**: Use clear, descriptive commit messages. Start with a short summary of the change, followed by a detailed explanation if necessary.
  
Example:
```bash
Added crouching

This change allows the player to crouch using the shift key.
```

### License

By contributing to ***The Veil of Aether*'s game core repository**, you agree that your contributions will be licensed under the [GNU General Public License v3.0 or later](LICENSE).
