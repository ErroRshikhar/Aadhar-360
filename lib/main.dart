import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'app.dart'; 
import 'core/theme.dart';

// --- 1. GLOBAL USER PROFILE MODEL ---
class UserProfile {
  String firstName;
  String lastName;
  String id; // Email or Aadhaar
  String phoneNumber;

  UserProfile({
    this.firstName = "",
    this.lastName = "",
    this.id = "",
    this.phoneNumber = "",
  });
}

// --- 2. GLOBAL STATE NOTIFIERS ---

// Tracks user data (First Name, Last Name, Phone, etc.)
final ValueNotifier<UserProfile> currentUser = ValueNotifier(UserProfile());

// Language Notifier: 'en' for English, 'hi' for Hindi
final ValueNotifier<Locale> appLocale = ValueNotifier(const Locale('en'));

// Navigation Notifier: Keeps the tab index alive during state swaps
final ValueNotifier<int> homeTabIndex = ValueNotifier(0);

void main() {
  runApp(const Aadhaar360App());
}

class Aadhaar360App extends StatelessWidget {
  const Aadhaar360App({super.key});

  @override
  Widget build(BuildContext context) {
    // 3. Listen for Language changes globally
    return ValueListenableBuilder<Locale>(
      valueListenable: appLocale,
      builder: (context, locale, child) {
        return MaterialApp(
          title: 'Aadhaar 360',
          theme: AppTheme.lightTheme,
          debugShowCheckedModeBanner: false,
          
          locale: locale,
          
          // --- ROUTE MANAGEMENT ---
          initialRoute: '/login',
          routes: {
            '/login': (context) => const LoginScreen(),
            '/home': (context) => const AadharApp(), 
          },
        );
      },
    );
  }
}
