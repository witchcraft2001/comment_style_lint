# Comment Style Lint

A custom lint rule for Dart/Flutter projects that enforces consistent comment formatting by requiring a space after comment symbols (`//`). This helps maintain a clean and readable codebase by ensuring consistent comment style across your project.

[![Pub Version](https://img.shields.io/pub/v/comment_style_lint)](https://pub.dev/packages/comment_style_lint)
[![Dart CI](https://github.com/witchcraft2001/comment_style_lint/actions/workflows/dart.yml/badge.svg)](https://github.com/witchcraft2001/comment_style_lint/actions/workflows/dart.yml)

## Features

- 🔍 Enforces a space after single-line comment symbols (`//`)
- 🛠️ Provides automatic fixes for comment formatting
- ⚡ Integrates with Dart's analyzer and custom_lint
- 📝 Supports both Dart and Flutter projects
- 🔄 Real-time linting in your IDE

## Getting started

Add this package to your `pubspec.yaml`:

```yaml
dev_dependencies:
  comment_style_lint:
    git:
      url: https://github.com/witchcraft2001/comment_style_lint.git
```

Create or update the `analysis_options.yaml` file in your project root:

```yaml
include: package:flutter_lints/flutter.yaml

analyzer:
  plugins:
    - custom_lint

custom_lint:
  rules:
    - comment_space_required: true
```

## Usage

The linter will automatically check your code for proper comment formatting. Here are some examples:

```dart
// This is correct
//This is incorrect

// This is also correct
//This is also incorrect

// This is a long comment that explains
// something important about the code
//This is incorrect because it has no space
```

When the linter finds incorrect formatting, it will:
1. Show a warning message with a red squiggly line
2. Provide a quick fix option to add the missing space
3. Allow you to apply the fix automatically with a single click

### IDE Integration

The linter works seamlessly with:
- VS Code
- Android Studio
- IntelliJ IDEA

## Additional information

### How it works

The package uses the `custom_lint` framework to create a custom lint rule that:
1. Scans your Dart code for comments
2. Checks if there's a space after the `//` symbol
3. Reports issues when spaces are missing
4. Provides automatic fixes

### Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Getting help

If you encounter any issues or have questions:
- Open an issue on [GitHub](https://github.com/witchcraft2001/comment_style_lint/issues)

### Roadmap

We're planning to add:
- Support for multi-line comments (`/* */`)
- Customizable spacing rules
- Integration with other linting tools
- More detailed documentation

### License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
