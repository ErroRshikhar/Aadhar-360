import 'package:flutter/material.dart';
import '../services/google_ai_service.dart';
import '../models/message_model.dart';
import '../widgets/chat_bubble.dart';

class MitraAiScreen extends StatefulWidget {
  const MitraAiScreen({super.key});
  @override
  State<MitraAiScreen> createState() => _MitraAiScreenState();
}

class _ChatSuggestion {
  final String label;
  final String query;
  _ChatSuggestion(this.label, this.query);
}

class _MitraAiScreenState extends State<MitraAiScreen> {
  // 1. DUAL-LANGUAGE STARTING MESSAGE
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "नमस्ते! मैं मित्रा एआई हूँ। मैं आपकी कैसे मदद कर सकता हूँ?\n\nNamaste! I am Mitra AI. How can I help you today?", 
      isUser: false
    ),
  ]; 

  final _service = GeminiService();
  final _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  // Quick Action Chips for Raipur Citizens
  final List<_ChatSuggestion> _suggestions = [
    _ChatSuggestion("Update Address", "How can I update my address in Raipur?"),
    _ChatSuggestion("आधार केंद्र", "रायपुर में नजदीकी आधार केंद्र कहाँ है?"),
    _ChatSuggestion("Child Aadhaar", "What is the process for Baal Aadhaar?"),
  ];

  void _send({String? text}) async {
    final userText = text ?? _controller.text;
    if (userText.trim().isEmpty) return;

    setState(() {
      _messages.insert(0, ChatMessage(text: userText, isUser: true));
      _isLoading = true;
    });
    _controller.clear();

    try {
      final aiResponse = await _service.getResponse(userText);
      setState(() {
        _messages.insert(0, ChatMessage(text: aiResponse, isUser: false));
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _messages.insert(0, ChatMessage(
          text: "Technical Server Sync / तकनीकी सर्वर त्रुटि: Please check your connection to UIDAI data nodes.", 
          isUser: false));
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        elevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Mitra AI Assistant", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text("मित्रा एआई सहायक", style: TextStyle(fontSize: 10, color: Colors.white70)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, size: 20),
            onPressed: () => setState(() => _messages.clear()),
          ),
        ],
        backgroundColor: const Color(0xFF0D47A1),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // 2. SCROLLABLE MESSAGE LIST
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              itemCount: _messages.length,
              itemBuilder: (context, index) => ChatBubble(
                message: _messages[index].text,
                isUser: _messages[index].isUser,
              ),
            ),
          ),

          if (_isLoading)
            const LinearProgressIndicator(backgroundColor: Colors.transparent, color: Color(0xFF0D47A1), minHeight: 2),

          // 3. QUICK SUGGESTION CHIPS
          _buildSuggestions(),

          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildSuggestions() {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemCount: _suggestions.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: ActionChip(
            label: Text(_suggestions[index].label, style: const TextStyle(fontSize: 12, color: Color(0xFF0D47A1))),
            backgroundColor: Colors.white,
            side: const BorderSide(color: Color(0xFF0D47A1), width: 0.5),
            onPressed: () => _send(text: _suggestions[index].query),
          ),
        ),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 10, 15, 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, -5))],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              onSubmitted: (_) => _send(),
              decoration: InputDecoration(
                hintText: "Type in हिंदी or English...",
                hintStyle: const TextStyle(fontSize: 14),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
          ),
          const SizedBox(width: 10),
          CircleAvatar(
            radius: 24,
            backgroundColor: const Color(0xFF0D47A1),
            child: IconButton(
              icon: const Icon(Icons.mic_none_outlined, color: Colors.white, size: 22),
              onPressed: () {
                // Future integration for voice support
              },
            ),
          ),
        ],
      ),
    );
  }
}
