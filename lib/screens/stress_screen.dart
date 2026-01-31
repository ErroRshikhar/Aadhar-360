import 'package:flutter/material.dart';

// Local model with Null-Safety Fallbacks
class CenterDetail {
  final String id, name, nameHin, issues, prediction, bestTime;
  final int stressScore;
  CenterDetail({
    required this.id, 
    required this.name, 
    required this.nameHin, 
    required this.stressScore,
    required this.issues, 
    required this.prediction, 
    required this.bestTime,
  });
}

class StressScreen extends StatefulWidget {
  const StressScreen({super.key});
  @override
  State<StressScreen> createState() => _StressScreenState();
}

class _StressScreenState extends State<StressScreen> {
  // Using a getter to ensure data is never null and handles bilingual labels
  final List<CenterDetail> raipurLocations = [
    CenterDetail(
      id: "1", name: "ASK Pandri", nameHin: "एएसके पंडरी", stressScore: 88,
      issues: "High Server Latency: Biometric packet loss detected.\nसर्वर में देरी: बायोमेट्रिक डेटा लॉस की समस्या।",
      prediction: "Failure Risk: 22% (Network Congestion)\nविफलता का जोखिम: 22% (नेटवर्क भीड़)",
      bestTime: "Visit after 4:30 PM.\nशाम 4:30 बजे के बाद आएं।",
    ),
    CenterDetail(
      id: "2", name: "GPO Raipur", nameHin: "जीपीओ रायपुर", stressScore: 35,
      issues: "All systems operational. No technical lag.\nसभी सिस्टम चालू हैं। कोई तकनीकी समस्या नहीं।",
      prediction: "Failure Risk: 2% (Optimal)\nविफलता का जोखिम: 2% (न्यूनतम)",
      bestTime: "Visit now. Wait < 10 mins.\nअभी आएं। प्रतीक्षा समय 10 मिनट से कम।",
    ),
    CenterDetail(
      id: "3", name: "Naya Raipur", nameHin: "नया रायपुर", stressScore: 62,
      issues: "Scanner Maintenance: 2/4 units active.\nस्कैनर रखरखाव: केवल 2 इकाइयां चालू हैं।",
      prediction: "Failure Risk: 12% (Hardware)\nविफलता का जोखिम: 12% (हार्डवेयर)",
      bestTime: "Early morning recommended.\nसुबह जल्दी आना बेहतर होगा।",
    ),
  ];

  // Using a nullable and a safe getter to prevent the 'Null' error
  CenterDetail? _selectedCenter;

  CenterDetail get selected {
    return _selectedCenter ?? raipurLocations[0];
  }

  @override
  void initState() {
    super.initState();
    _selectedCenter = raipurLocations[0];
  }

  @override
  Widget build(BuildContext context) {
    // Local Safety check for the specific Error you faced
    final current = selected;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text("Raipur Stress Monitor / रायपुर लाइव स्टेटस", 
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        backgroundColor: const Color(0xFF0D47A1),
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false, // Prevents vanishing nav bar issues
      ),
      body: Column(
        children: [
          // 1. Center Selector (Horizontal)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              height: 55,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: raipurLocations.length,
                itemBuilder: (context, i) {
                  bool isSelected = current.id == raipurLocations[i].id;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedCenter = raipurLocations[i]),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF0D47A1) : Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: isSelected ? [BoxShadow(color: Colors.blue.withOpacity(0.3), blurRadius: 10)] : [],
                        border: Border.all(color: isSelected ? Colors.transparent : Colors.grey.shade300),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(raipurLocations[i].name, style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: FontWeight.bold, fontSize: 13)),
                            Text(raipurLocations[i].nameHin, style: TextStyle(color: isSelected ? Colors.white70 : Colors.grey, fontSize: 10)),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          
          // 2. Dashboard Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildStressGauge(current),
                  const SizedBox(height: 25),
                  _buildDetailCard("Technical Status / तकनीकी स्थिति", current.issues, Icons.settings_input_component, _getStressColor(current)),
                  const SizedBox(height: 12),
                  _buildDetailCard("Failure Prediction / विफलता अनुमान", current.prediction, Icons.analytics, Colors.purple),
                  const SizedBox(height: 12),
                  _buildDetailCard("Optimal Visit Time / आने का सही समय", current.bestTime, Icons.history_toggle_off, const Color(0xFF0D47A1)),
                  const SizedBox(height: 30),
                  _buildMandatoryAlert(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStressColor(CenterDetail current) {
    if (current.stressScore > 75) return Colors.red;
    if (current.stressScore > 45) return Colors.orange;
    return Colors.green;
  }

  Widget _buildStressGauge(CenterDetail current) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20)]),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(height: 150, width: 150, child: CircularProgressIndicator(value: current.stressScore / 100, strokeWidth: 15, color: _getStressColor(current), backgroundColor: Colors.grey.shade100)),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("${current.stressScore}%", style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900, color: _getStressColor(current))),
                  Text(current.stressScore > 70 ? "HIGH / उच्च" : "LOW / कम", style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text("REAL-TIME LIVE LOAD / लाइव लोड", style: TextStyle(letterSpacing: 1.5, fontWeight: FontWeight.bold, color: Colors.blueGrey, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildDetailCard(String title, String content, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade100)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(width: 15),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              // Safety: Ensure content is never null
              Text(content.isNotEmpty ? content : "No Data", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF1E293B), height: 1.4)),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildMandatoryAlert() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.orange.shade800, Colors.red.shade900]), borderRadius: BorderRadius.circular(25)),
      child: const Row(
        children: [
          Icon(Icons.warning_rounded, color: Colors.white, size: 35),
          SizedBox(width: 15),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("MANDATORY UPDATE / अनिवार्य अपडेट", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
              SizedBox(height: 5),
              Text("Is your Aadhaar 10 years old? Per UIDAI, updates are mandatory. / क्या आपका आधार 10 साल पुराना है? यूआईडीएआई के अनुसार अपडेट अनिवार्य है।", 
                style: TextStyle(color: Colors.white70, fontSize: 11, height: 1.4)),
            ]),
          ),
        ],
      ),
    );
  }
}
