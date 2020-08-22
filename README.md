Trustping 
================================================================================
[![Codemagic build status](https://api.codemagic.io/apps/5f002d46f9543e1013b521cf/5f002d46f9543e1013b521ce/status_badge.svg)](https://codemagic.io/apps/5f002d46f9543e1013b521cf/5f002d46f9543e1013b521ce/latest_build)

Homepage: https://trustping.github.io/

**NOTE: this is alpha, don't use it.**

TODO what is trustping


## Tech
Trustping uses Dart/Flutter, Firebase, and the Matrix protocol.


## Development
Requirements:
- Install [dart and flutter](https://flutter.dev/docs/get-started/install)
- Setup  [vscode](https://code.visualstudio.com/) and the [flutter extension](https://flutter.dev/docs/development/tools/vs-code)
- Install `make` or [`remake`](https://github.com/rocky/remake)

Then:
```bash
# Clone the project

# Automatically build router and dataclasses
remake watch

# Manually delete conflicting output
flutter pub pub run build_runner build --delete-conflicting-outputs

# Run tests
remake test
```

## Architecture
The code layout is based on an ajusted version of the [starter_architecture_flutter_firebase](https://github.com/bizz84/starter_architecture_flutter_firebase) by  [Andrea Bizzotto](https://codewithandrea.com/).
Check out [REDME_old.md](README_old.md) for an overview.