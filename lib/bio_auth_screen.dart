import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class BiometricAuthScreen extends StatelessWidget {
  const BiometricAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.fingerprint,
                  size: 100, color: Colors.blueAccent),
              const SizedBox(height: 20),
              const Text(
                'Biometric Authentication',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Authenticate to continue',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[400], fontSize: 16),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  final LocalAuthentication auth = LocalAuthentication();
                  final bool canAuthenticateWithBiometrics =
                      await auth.canCheckBiometrics;

                  final bool canAuthenticate = canAuthenticateWithBiometrics ||
                      await auth.isDeviceSupported();

                  if (canAuthenticate) {
                    bool isAuthenticated = await auth.authenticate(
                        localizedReason: 'Auth with biometrics',
                        options: const AuthenticationOptions(
                          stickyAuth: true,
                          useErrorDialogs: true,
                        ));

                    if (isAuthenticated) {
                      if (!context.mounted) return;
                      showSuccessSnackBar(context);
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  // primary: Colors.blueAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Authenticate',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Navigate to alternative login
                },
                child: Text(
                  'Use PIN instead',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void showSuccessSnackBar(BuildContext context) {
  final snackBar = SnackBar(
    content: const Text(
      'Auth Successful',
      style: TextStyle(color: Colors.white, fontSize: 16),
    ),
    backgroundColor: Colors.green,
    behavior:
        SnackBarBehavior.floating, // Makes the SnackBar float above the content
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    duration: const Duration(seconds: 2),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
