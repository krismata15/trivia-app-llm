import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          BetaAppBanner(),
        ],
      ),
    );
  }
}

class BetaAppBanner extends StatelessWidget {
  const BetaAppBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        children: [
          const Text('Trivia App'),
          const SizedBox(
            width: 4,
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.blue.withOpacity(0.3),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 12,
              ),
              child: Text(
                'Alpha',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
