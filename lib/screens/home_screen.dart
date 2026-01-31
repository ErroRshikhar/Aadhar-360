import 'package:flutter/material.dart';
import '../main.dart'; // Import the global currentUser state

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Listen to the global currentUser notifier instead of Route arguments
    return ValueListenableBuilder<UserProfile>(
      valueListenable: currentUser,
      builder: (context, user, child) {
        // Use the first name from the global state, default to "Citizen" if empty
        final String displayName = user.firstName.isNotEmpty 
            ? "${user.firstName} ${user.lastName}" 
            : "Citizen";

        return Scaffold(
          backgroundColor: const Color(0xFFF8FAFC),
          body: CustomScrollView(
            slivers: [
              // 2. Luxury Collapsible Header (Now dynamic)
              _buildSliverHeader(displayName),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 3. Point-based Intro Section (Bilingual)
                      _buildPointIntroSection(),
                      const SizedBox(height: 40),

                      // 4. Elaborative Ecosystem Section (Hindi/Eng)
                      const Text("Ecosystem Offerings / हमारी सेवाएं", 
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
                      const SizedBox(height: 15),
                      _buildServiceGrid(),
                      const SizedBox(height: 40),

                      // 5. Regional Updates (Hindi/Eng)
                      const Text("Raipur Regional Updates / रायपुर अपडेट", 
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
                      const SizedBox(height: 15),
                      _buildUpdateFeed(),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 100)),
            ],
          ),
        );
      },
    );
  }

  // --- UI COMPONENT BUILDERS ---

  Widget _buildSliverHeader(String name) {
    return SliverAppBar(
      expandedHeight: 160,
      pinned: true,
      elevation: 0,
      backgroundColor: const Color(0xFF0D47A1),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0D47A1), Color(0xFF1E3A8A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 70, 25, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("नमस्ते (Namaste),", style: TextStyle(color: Colors.white70, fontSize: 14)),
                Text(name, 
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w900, letterSpacing: 1.0)),
                const SizedBox(height: 5),
                const Text("Raipur Digital Service Hub / रायपुर डिजिटल सेवा", 
                  style: TextStyle(color: Colors.blueAccent, fontSize: 12, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPointIntroSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Beyond Ordinary Identity", 
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
        const SizedBox(height: 15),
        _buildBulletPoint("Real-time crowd tracking at Raipur centers / केंद्रों पर भीड़ की लाइव जानकारी"),
        _buildBulletPoint("Bilingual AI support for all queries / सभी प्रश्नों के लिए द्विभाषी एआई सहायता"),
        _buildBulletPoint("Predictive biometric failure alerts / बायोमेट्रिक विफलता की अग्रिम सूचना"),
        _buildBulletPoint("Mandatory 10-year update notifications / 10-वर्षीय अनिवार्य अपडेट अलर्ट"),
      ],
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF0D47A1), size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: const TextStyle(color: Colors.blueGrey, fontSize: 13, height: 1.4, fontWeight: FontWeight.w500)),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceGrid() {
    final coreServices = [
      {"title": "Biometrics", "hin": "बायोमेट्रिक्स", "icon": Icons.fingerprint_rounded},
      {"title": "No-Stress Entry", "hin": "आसान प्रवेश", "icon": Icons.spa_rounded},
      {"title": "Smart Alerts", "hin": "स्मार्ट अलर्ट", "icon": Icons.notifications_active_rounded},
      {"title": "Digital Vault", "hin": "डिजिटल वॉल्ट", "icon": Icons.security_rounded},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15, childAspectRatio: 1.4),
      itemCount: coreServices.length,
      itemBuilder: (context, i) => Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 20)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(coreServices[i]['icon'] as IconData, color: const Color(0xFF0D47A1), size: 28),
            const SizedBox(height: 8),
            Text(coreServices[i]['title'] as String, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13)),
            Text(coreServices[i]['hin'] as String? ?? "", style: const TextStyle(fontSize: 11, color: Colors.blueGrey)),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdateFeed() {
    final updates = [
      {"label": "New Center", "title": "Naya Raipur ASK", "info": "Now operational for students. / छात्रों के लिए अब चालू।"},
      {"label": "UIDAI News", "title": "Free Extension", "info": "Valid till June 2026. / जून 2026 तक वैध।"},
    ];

    return Column(
      children: updates.map((u) => Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            const Icon(Icons.campaign, color: Colors.orange, size: 24),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(u['title']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Text(u['info']!, style: const TextStyle(fontSize: 12, color: Colors.blueGrey)),
                ],
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }
}
