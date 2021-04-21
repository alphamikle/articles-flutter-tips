import 'package:flutter/cupertino.dart';

abstract class BaseState {
  List<VoidCallback> get hooks;

  void registerHook(VoidCallback callback);

  void initState();

  void dispose();

  void addListenersTo(Listenable listenable) {
    for (final hook in hooks) {
      listenable.addListener(hook);
    }
  }

  void removeListenersFrom(Listenable listenable) {
    for (final hook in hooks) {
      listenable.removeListener(hook);
    }
  }

  void runHooks() {
    for (final hook in hooks) {
      hook();
    }
  }
}
