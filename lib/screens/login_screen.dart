import 'package:flutter/material.dart';
import '../main.dart'; // Import the notifier we created above

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _idController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _handleLogin() {
    if (_firstNameController.text.isEmpty || _phoneController.text.isEmpty || _idController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("कृपया सभी विवरण भरें (Please fill all details)")),
      );
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("पासवर्ड मेल नहीं खाते (Passwords do not match)")),
      );
      return;
    }

    // UPDATE GLOBAL STATE
    currentUser.value = UserProfile(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
      id: _idController.text.trim(),
    );

    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            const SizedBox(height: 60),
            _buildHeader(),
            const SizedBox(height: 30),
            
            // Name Row
            Row(
              children: [
                Expanded(child: _buildTextField(_firstNameController, "First Name", "पहला नाम")),
                const SizedBox(width: 15),
                Expanded(child: _buildTextField(_lastNameController, "Last Name", "अंतिम नाम")),
              ],
            ),
            const SizedBox(height: 15),
            _buildTextField(_phoneController, "Phone Number", "फ़ोन नंबर", icon: Icons.phone_android),
            const SizedBox(height: 15),
            _buildTextField(_idController, "Email / Aadhaar", "ईमेल / आधार", icon: Icons.badge_outlined),
            const SizedBox(height: 15),
            _buildTextField(_passwordController, "Password", "पासवर्ड", isPass: true, icon: Icons.lock_outline),
            const SizedBox(height: 15),
            _buildTextField(_confirmPasswordController, "Confirm", "पुष्टि करें", isPass: true, icon: Icons.verified_user_outlined),
            
            const SizedBox(height: 30),
            _buildLoginButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 45, backgroundColor: Colors.blue.shade50,
          child: Icon(Icons.account_balance_rounded, size: 50, color: Colors.blue.shade900),
        ),
        const SizedBox(height: 15),
        Text("Aadhaar 360", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.blue.shade900)),
        const Text("Digital Identity Hub | रायपुर", style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String hint, {bool isPass = false, IconData? icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(" $label", style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          obscureText: isPass,
          decoration: InputDecoration(
            prefixIcon: icon != null ? Icon(icon, size: 20, color: Colors.blue.shade900) : null,
            hintText: hint,
            filled: true, fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey.shade200)),
            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity, height: 55,
      child: ElevatedButton(
        onPressed: _handleLogin,
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade900, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
        child: const Text("Create Account / लॉगिन", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
