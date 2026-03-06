# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Run on iOS simulator
flutter run

# Build
flutter build ios

# Analyze/lint
flutter analyze

# Run tests
flutter test

# Run a single test file
flutter test test/path/to/test_file.dart

# Get dependencies
flutter pub get
```

## Architecture

This is a Flutter app using Firebase (Auth + Realtime Database) with `go_router` for navigation, `provider` for state management, and `dio` for HTTP requests.

### Packages

- **Provider** — state management
- **go_router** — routing
- **Dio** — sending HTTP requests

### Layer Structure

- **`lib/models/`** — Plain data classes (e.g., `UserModel`)
- **`lib/repositories/`** — Direct Firebase calls and API requests (Auth, Realtime Database, Dio). All Firebase/HTTP interactions should live here.
- **`lib/services/`** — Business logic layer that wraps repositories. Both services and repositories use singleton pattern via `instance` static getter.
- **`lib/screens/`** — Full-page widgets. Each screen defines its own `routeName`, `push`, and `go` static members.
- **`lib/widgets/`** — Reusable widgets, including stream-based data widgets.
- **`lib/utils/`** — Utility files and helpers.

### Firebase Database Structure

```
/members/{uid}/
  name: string
  nickname: string
  posts/{postId}/
    title: string
```

---

## Naming Conventions

File paths follow this pattern: `{layer}/{modulename}/{submodulename}.filename.dart`

- `screens/{modulename}/{submodulename}.filename.dart`
- `modules/{modulename}/{submodulename}.filename.dart`
- `repositories/{modulename}/{submodulename}.filename.dart`
- `services/{modulename}/{submodulename}.filename.dart`
- `utils/{modulename}/{submodulename}.filename.dart`
- `widgets/{modulename}/{submodulename}.filename.dart`

Rules:
- If it needs more submodules, the name should be something like `posts.submodule.dart`
- Use a dot in the file name for every module and submodule separator
- If the name after the module/submodule parts is two or more words, use underscore instead of dot

Examples:
- `screens/home/home.screen.dart`
- `services/user/user.service.dart`
- `widgets/user/posts/user.posts_a_long_name_file.dart`

---

## Models

- Must have a `copyWith` method
- Must have a `fromJson` method
- If needed later, also add the inverse of `fromJson` (i.e., `toJson`)
- Files should only be responsible for structuring data

---

## Repositories

- Must be singleton (via `instance` static getter)
- Responsible for handling CRUD operations, sending API requests, and database interactions
- If a method needs to accept data, it should accept a Model, not direct values
- Repositories are called by services, not by screens or widgets directly

---

## Screens

- Must have at least 3 static methods: `routeName`, `go`, and `push`
- Should be lean — if a screen file becomes too long, extract widgets into the `widgets/` directory
- For navigation, always use the `go` or `push` static methods defined in each screen file
- Pass arguments via `state.extra` in GoRouter, and handle them with pattern matching

Example route definition:
```dart
GoRoute(
  path: "/",
  builder: (BuildContext context, GoRouterState state) {
    final extra = state.extra;

    if (extra case {"title": String title}) {
      return HomeScreen(title: title);
    }

    return const HomeScreen(title: "Default");
  },
),
```

Example static method usage:
```dart
HomeScreen.go(context, extra: {"title": "Cool title"});
```

---

## Services

- Must be singleton (via `instance` static getter)
- Service files call repository files
- Repository classes expect a Model as an argument, so service files should create the model and pass it to repository methods

---

## Widgets

- Keep widget files short and easy to read/understand
- For shared/reusable widgets, use `widgets/common/someReusableWidget.dart`
- For module-specific widgets, organize under the module's directory
- Avoid using `provider.watch()` — use `Selector` only
- Keep `context.select` usage in small, focused widgets; create a new widget if needed

Example of a widget using `Selector`:
```dart
Center(
  child: Selector<CounterProvider, int>(
    selector: (_, provider) => provider.count.count,
    builder: (BuildContext context, int value, Widget? child) {
      return Text("$value");
    },
  ),
),
```

---

## Router (`router.dart`)

- This file should remain clean
- Only 1 level deep — do not nest routes
- Use the screen's static `routeName` for path values
- Pass arguments via the `extra` field from `GoRouterState`

---

## States (ChangeNotifier)

- State files are only about handling state
- Each state file should have a matching model
- State methods should accept models as parameters instead of direct values
- State classes must have a static `.of()` method that returns `context.read<StateClass>()`
- State classes must extend `ChangeNotifier`
- Always use `StateClass.of(context).someMethod()` to update state — never hold a direct reference to the state instance and call methods on it

Example:
```dart
static MyState of(BuildContext context) => context.read<MyState>();
```

---

## Provider Usage

- Do NOT use `MultiProvider()`
- Instead, wrap only the "parent widget" that actually needs the provider so its children have access
- Do not wrap the entire app with providers unnecessarily

---

## Sample Flow

When a user clicks a button:

```dart
ElevatedButton(
  /// sample usage
  /// final someModelIfReturnValIsNeeded = SomeService.instance.someMethod(someData1: 1, someData2: 2)
  /// SomeState.of(context).someMethodToUpdateTheState(someModelIfReturnValIsNeeded)
  onPressed: () {
    SomeScreen.push(context);
  },
  child: Text("SomeText"),
)
```

---

## Forms

- Use the `Form` widget with a `GlobalKey<FormState>`
- Use `TextFormField` (not `TextField`) inside forms
- Always add a `validator` to each `TextFormField`
- Call `_formKey.currentState!.validate()` before processing submission

Example:
```dart
final _formKey = GlobalKey<FormState>();

Form(
  key: _formKey,
  child: Column(
    children: [
      TextFormField(
        controller: _controller,
        decoration: const InputDecoration(labelText: "Field"),
        validator: (value) =>
            (value == null || value.trim().isEmpty) ? "Field is required" : null,
      ),
      ElevatedButton(
        onPressed: () {
          if (!_formKey.currentState!.validate()) return;
          // proceed
        },
        child: const Text("Submit"),
      ),
    ],
  ),
)
```

---

## Key Widgets

- **`UserReady`** — Wraps `FirebaseAuth.authStateChanges()` stream; calls `yes()` when logged in, `no()` otherwise.
- **`UserData`** — StreamBuilder that reads the current user's `/members/{uid}` node and provides a `UserModel`.
- **`UserPosts`** — StreamBuilder that reads `/members/{uid}/posts` and provides `List<Map<String, String>>` with an injected `id` key.
