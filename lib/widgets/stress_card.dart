import 'package:flutter/material.dart';
import '../models/center_model.dart';
import '../core/theme.dart';

class StressCard extends StatelessWidget {
  final AadhaarCenter center;
  const StressCard({super.key, required this.center});

  @override
  Widget build(BuildContext context) {
    Color statusColor = center.stressScore > 70 ? AppTheme.stressRed : (center.stressScore > 40 ? AppTheme.stressYellow : AppTheme.stressGreen);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        title: Text(center.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("${center.issues}\nFailure Pred: ${center.prediction}"),
        trailing: CircleAvatar(backgroundColor: statusColor, child: Text("${center.stressScore}")),
      ),
    );
  }
}
