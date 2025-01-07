part of 'app_bloc.dart';

sealed class AppEvent {
  const AppEvent();
}

final class AppUserSubscriptionRequested extends AppEvent {
  const AppUserSubscriptionRequested();
}

final class AppLogoutPressed extends AppEvent {
  const AppLogoutPressed();
}

final class AppEmailVerified extends AppEvent {
  const AppEmailVerified();
}

/*
In this code, the `_onUserSubscriptionRequested` method is an event handler for the `AppUserSubscriptionRequested` event in the `AppBloc` class. This method is responsible for handling user subscription requests and updating the application state accordingly.

The method signature indicates that it is asynchronous and returns a `Future<void>`. It takes two parameters: an `AppUserSubscriptionRequested` event and an `Emitter<AppState>` to emit new states.

```dart
Future<void> _onUserSubscriptionRequested(
  AppUserSubscriptionRequested event,
  Emitter<AppState> emit,
)
```

Inside the method, the `emit.onEach` function is used to listen to the stream of user data from the `_authenticationRepository`. The `onData` callback is triggered whenever new user data is received, and it emits a new `AppState` with the updated user information.

```dart
emit.onEach(
  _authenticationRepository.user,
  onData: (user) => emit(AppState(user: user)),
  onError: addError,
)
```

If an error occurs while listening to the user stream, the `onError` callback will handle it by calling the `addError` method. This ensures that any issues during the subscription process are properly managed and do not crash the application.

he authStateChanges method from FirebaseAuth listens for changes in the authentication state, including updates to user properties. When such changes occur, the stream will emit a new User object with the updated properties
 */
