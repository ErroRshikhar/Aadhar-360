import 'package:google_generative_ai/google_generative_ai.dart';
import '../core/constants.dart';

class GeminiService {
  final _model = GenerativeModel(
    model: 'gemini-2.5-flash', // Use Flash for faster, free-tier responses
    apiKey: AppConstants.geminiApiKey,
  );

  Future<String> getResponse(String input) async {
    try {
      // System prompt to keep the AI focused on Aadhaar & Raipur
      final prompt = [
        Content.text("You are Mitra AI, an official Aadhaar assistant for Raipur. "
            "Help citizens with biometric updates, center locations, and stress-free navigation. "
            "Keep answers bilingual (Hindi/English). User query: $input")
      ];
      
      final response = await _model.generateContent(prompt);
      
      if (response.text != null) {
        return response.text!;
      } else {
        return "I'm sorry, I received an empty response. Please try rephrasing.";
      }
    } catch (e) {
      // Catch specific API errors
      if (e.toString().contains('403')) {
        return "Error 403: API Key is restricted or invalid. Check Google AI Studio.";
      } else if (e.toString().contains('429')) {
        return "Error 429: Too many requests. Please wait a moment.";
      } else if (e.toString().contains('SocketException')) {
        return "Network Error: Please check your internet connection.";
      }
      return "Mitra AI is currently facing a technical glitch: ${e.toString()}";
    }
  }
}
