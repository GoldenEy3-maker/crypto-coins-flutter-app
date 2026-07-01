class TestSandboxRefreshTokensFetchParams {
  final bool emulateFailure;
  final Duration delay;

  const TestSandboxRefreshTokensFetchParams({
    this.emulateFailure = false,
    this.delay = Duration.zero,
  });
}
