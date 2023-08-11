import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 38,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const BetaAppBanner(),
          Row(
            children: [
              const Icon(
                Icons.person_pin,
                size: 18,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                FirebaseAuth.instance.currentUser!.displayName!,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BetaAppBanner extends StatelessWidget {
  const BetaAppBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.go('/');
      },
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
