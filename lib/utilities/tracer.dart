void trace() {
  //*  The code inside the assert function will be removed when the app is
  //* compiled in release mode, so it won't have any performance impact on
  //* the final app.
  // Only execute the code in debug mode.
  assert(() {
    print(StackTrace.current.toString().split('\n')[2]);
    return true;
  }());
}
