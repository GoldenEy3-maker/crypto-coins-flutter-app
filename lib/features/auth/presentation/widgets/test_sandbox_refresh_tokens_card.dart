import "package:flutter/material.dart";

class TestSandboxRefreshTokensCard extends StatefulWidget {
  final Future<void> Function() _onInitFetch;

  const TestSandboxRefreshTokensCard({
    super.key,
    required Future<void> Function() onInitFetch,
  }) : _onInitFetch = onInitFetch;

  @override
  State<StatefulWidget> createState() => _TestSandboxRefreshTokensCardState();
}

class _TestSandboxRefreshTokensCardState
    extends State<TestSandboxRefreshTokensCard> {
  bool _isLoading = false;
  String _status = "";

  @override
  void initState() {
    setState(() {
      _isLoading = true;
    });

    widget
        ._onInitFetch()
        .then((_) {
          if (!mounted) return;
          setState(() {
            _status = "success";
          });
        })
        .catchError((error) {
          if (!mounted) return;
          setState(() {
            _status = "error: $error";
          });
        })
        .whenComplete(() {
          if (!mounted) return;
          setState(() {
            _isLoading = false;
          });
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _isLoading ? const CircularProgressIndicator() : Text(_status),
    );
  }
}
