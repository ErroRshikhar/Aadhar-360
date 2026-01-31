import 'package:flutter/material.dart';
import '../main.dart'; // Import the global state

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<UserProfile>(
      valueListenable: currentUser,
      builder: (context, user, child) {
        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          appBar: AppBar(
            title: const Text("Settings & Profile", style: TextStyle(fontWeight: FontWeight.bold)),
            backgroundColor: const Color(0xFF0D47A1),
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          body: ListView(
            children: [
              _buildProfileHeader("${user.firstName} ${user.lastName}"),
              const SizedBox(height: 10),
              _buildInfoTile(
                Icons.badge_outlined, 
                "Email / Aadhaar ID", 
                user.id.isEmpty ? "Not Provided" : user.id,
                () => _showEditDialog("Identity", user.id, (val) => user.id = val),
              ),
              _buildInfoTile(
                Icons.phone_android_outlined, 
                "Linked Mobile", 
                user.phoneNumber.isEmpty ? "Add Number" : user.phoneNumber,
                () => _showEditDialog("Phone Number", user.phoneNumber, (val) => user.phoneNumber = val),
              ),
              const Divider(indent: 20, endIndent: 20, height: 40),
              _buildFAQSection(),
              const Divider(height: 40),
              _buildAdminAccess(), // Restricted gateway
              const SizedBox(height: 50),
            ],
          ),
        );
      },
    );
  }

  // --- UI BUILDERS (Profile, Tiles, FAQ) ---

  Widget _buildProfileHeader(String name) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: const BoxDecoration(
        color: Color(0xFF0D47A1),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: Column(
        children: [
          const CircleAvatar(radius: 50, backgroundColor: Colors.white24, child: Icon(Icons.person, size: 60, color: Colors.white)),
          const SizedBox(height: 15),
          Text(name, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          const Text("Verified Resident | Raipur", style: TextStyle(color: Colors.white70, fontSize: 13, letterSpacing: 1)),
        ],
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String value, VoidCallback onTap) {
    return ListTile(
      leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: const Color(0xFF0D47A1), size: 20)),
      title: Text(title, style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold)),
      subtitle: Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF1E293B))),
      trailing: const Icon(Icons.edit_note, size: 22, color: Colors.blueGrey),
      onTap: onTap,
    );
  }

  void _showEditDialog(String label, String initialValue, Function(String) onSave) {
    TextEditingController editController = TextEditingController(text: initialValue);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Update $label"),
        content: TextField(controller: editController, decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)))),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(onPressed: () { onSave(editController.text); currentUser.value = currentUser.value; Navigator.pop(context); }, child: const Text("Save")),
        ],
      ),
    );
  }

  Widget _buildFAQSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), child: Text("Support / सहायता", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF1E293B)))),
        _buildFAQItem("Is my data secure?", "क्या मेरा डेटा सुरक्षित है?", "Aadhaar 360 uses 2026-standard end-to-end encryption."),
        _buildFAQItem("Center Stress Levels?", "सेंटर स्ट्रेस लेवल क्या है?", "Real-time crowd analysis for Raipur centers."),
      ],
    );
  }

  Widget _buildFAQItem(String qEng, String qHin, String ans) {
    return ExpansionTile(
      leading: const Icon(Icons.help_outline, color: Colors.blueGrey, size: 20),
      title: Text(qEng, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
      subtitle: Text(qHin, style: const TextStyle(fontSize: 12, color: Colors.blueGrey)),
      children: [Padding(padding: const EdgeInsets.all(20.0), child: Text(ans, style: const TextStyle(fontSize: 13, color: Colors.blueGrey, height: 1.5)))],
    );
  }

  // --- ADMIN PORTAL LOGIC ---

  Widget _buildAdminAccess() {
    return ListTile(
      leading: const Icon(Icons.admin_panel_settings, color: Colors.red),
      title: const Text("UIDAI Official Portal", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
      subtitle: const Text("Restricted Access: District Oversight"),
      onTap: _showLoginDialog,
    );
  }

  void _showLoginDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Official Regional Login"),
        content: TextField(
          controller: _passController,
          obscureText: true,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: "Enter 4-digit Admin Key"),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              if (_passController.text == "1234") {
                _passController.clear();
                Navigator.pop(context);
                // SUCCESS: Open the Official Dashboard
                Navigator.push(context, MaterialPageRoute(builder: (context) => const OfficialDashboard()));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Access Denied: Incorrect Password"), backgroundColor: Colors.red));
              }
            }, 
            child: const Text("Authorize"),
          ),
        ],
      ),
    );
  }
}

// --- NEW: THE OFFICIAL DASHBOARD PAGE ---
class OfficialDashboard extends StatelessWidget {
  const OfficialDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9),
      appBar: AppBar(
        title: const Text("UIDAI Raipur Admin"),
        backgroundColor: Colors.red.shade900,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("District Oversight: Raipur", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
            const SizedBox(height: 20),
            
            // Resource Gap Analysis
            _buildAdminCard("Facility Requirement", "Naya Raipur Sector 25", "High Priority: Projected 500+ daily enrollments.", Icons.add_business),
            _buildAdminCard("Staffing Deficit", "ASK Pandri (Shyam Plaza)", "Action Required: Add +3 operators to reduce 45m wait.", Icons.person_add_alt_1),
            
            const SizedBox(height: 30),
            const Text("Recent Citizen Feedback", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const Divider(),
            _buildFeedbackListTile("GPO Jaistambh", "Smooth process for seniors today.", Colors.green),
            _buildFeedbackListTile("ASK Pandri", "Server lag during biometric sync.", Colors.orange),
            _buildFeedbackListTile("Naya Raipur", "Hardware fault in Scanner 2.", Colors.red),
            
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminCard(String title, String area, String detail, IconData icon) {
    return Card(
      elevation: 0, margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15), side: BorderSide(color: Colors.red.shade100)),
      child: ListTile(
        leading: Icon(icon, color: Colors.red.shade900, size: 30),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text("$area\n$detail", style: const TextStyle(fontSize: 12)),
      ),
    );
  }

  Widget _buildFeedbackListTile(String loc, String msg, Color status) {
    return ListTile(
      leading: CircleAvatar(radius: 5, backgroundColor: status),
      title: Text(loc, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
      subtitle: Text(textDirection: TextDirection.ltr, msg, style: const TextStyle(fontSize: 12)),
      contentPadding: EdgeInsets.zero,
    );
  }
}
