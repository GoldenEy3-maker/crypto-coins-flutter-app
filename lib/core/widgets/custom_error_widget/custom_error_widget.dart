import "package:flutter/material.dart";

class CustomErrorWidget extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const CustomErrorWidget({
    super.key,
    required this.error,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: .center,
        children: [
          const Icon(Icons.error, color: Colors.red, size: 60),
          const SizedBox(height: 16),
          Padding(
            padding: const .symmetric(horizontal: 16),
            child: Text(
              error,
              textAlign: .center,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: onRetry,
            style: ButtonStyle(
              backgroundColor: .all(Colors.amber),
              foregroundColor: .all(Colors.black),
            ),
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }
}
