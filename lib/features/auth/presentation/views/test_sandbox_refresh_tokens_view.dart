import "package:flutter/material.dart";
import "package:flutter_application_1/features/auth/domain/params/params.dart";
import "package:flutter_application_1/features/auth/domain/usecases/usecases.dart";
import "package:flutter_application_1/features/auth/presentation/widgets/test_sandbox_refresh_tokens_card.dart";

class TestSandboxRefreshTokensView extends StatelessWidget {
  final TestSandboxRefreshTokensFetch _testSandboxRefreshTokensFetch;

  const TestSandboxRefreshTokensView({
    super.key,
    required TestSandboxRefreshTokensFetch testSandboxRefreshTokensFetch,
  }) : _testSandboxRefreshTokensFetch = testSandboxRefreshTokensFetch;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TestSandboxRefreshTokensCard(
          onInitFetch: () async {
            final result = await _testSandboxRefreshTokensFetch(
              const TestSandboxRefreshTokensFetchParams(
                emulateFailure: true,
                delay: Duration(microseconds: 600),
              ),
            );

            return result.fold((failure) => throw failure, (_) {});
          },
        ),
        TestSandboxRefreshTokensCard(
          onInitFetch: () async {
            await Future.delayed(const Duration(milliseconds: 600));
            final result = await _testSandboxRefreshTokensFetch(
              const TestSandboxRefreshTokensFetchParams(
                emulateFailure: true,
                delay: Duration(seconds: 1),
              ),
            );

            return result.fold((failure) => throw failure, (_) {});
          },
        ),
      ],
    );
  }
}
