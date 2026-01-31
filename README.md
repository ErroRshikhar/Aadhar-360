# Aadhar-360
A 360-degree ecosystem that predicts service reliability and optimizes the user journey.
Aadhaar 360 is a luxury-grade, bilingual mobile ecosystem designed specifically for the residents of Raipur. Built for a 2026 landscape, the app bridges the gap between citizens and UIDAI services through real-time data, predictive analytics, and generative AI.

🌟 Core Features
Bilingual Smart Dashboard: A premium, collapsible interface offering seamless toggling between Hindi and English to ensure inclusivity for all Raipur demographics.

Raipur Stress Monitor: A live "Stress Gauge" that tracks crowd density and server latency across Raipur Aadhaar Seva Kendras (ASK), allowing citizens to choose centers with the lowest wait times.

Intelligent Route Navigation: Unlike standard maps, Aadhaar 360 provides road-path directions (not just straight lines) and dynamic distance calculations from a citizen's searched location (like Amity University or Telibandha) to the target center.

Mitra AI (Bilingual Assistant): A high-performance chatbot powered by Google Gemini, capable of explaining complex Aadhaar processes (like Baal Aadhaar or 10-year updates) in natural Hindi and English.

Predictive Maintenance Alerts: Proactive notifications for citizens regarding hardware status (e.g., "Scanner Maintenance at Tatibandh") and mandatory biometric update cycles.

Secure Admin Portal: A restricted area for UIDAI officials to monitor regional resource deficits and technical outages across the Raipur cluster.


Component                  Technology
Frontend Framework ----> Flutter (Dart)
Intelligence ----> Google Gemini AI (Generative AI SDK) ,
Mapping & GIS ----> Google Maps SDK for Flutter ,
Location Services ----> Geolocator API & Google Directions Logic ,
Backend (Simulated) ----> Firebase Core & Cloud Firestore ,
State Management ----> ValueNotifier & Reactive UI Patterns ,

📂 Repository Structure & Requirements
To maintain security and clean versioning, this repository provides the core logic and configuration templates. Follow the guide below to set up the local environment.

1. Essential File Placement
Ensure you place the following files in their respective directories:

   File                       Destination Path
lib/ (All folders/files) --------> /lib ,
pubspec.yaml   ---------------> Project Root / ,
google-services.json ------------> /android/app/ ,
AndroidManifest.xml ---------> /android/app/src/main/ ,

2. API Key Configuration
This project requires active API keys for Google Maps and Gemini AI.

Google Maps: In AndroidManifest.xml, replace YOUR_MAPS_API_KEY with your actual key.
Gemini AI: In lib/services/google_ai_service.dart, ensure your API key is correctly initialized in the GeminiService class.

🚀 How to Run
1. Environment Setup: Ensure you have Flutter (>= 3.1.0) installed and a physical device or emulator running.

2. Dependencies: Run the following command in your terminal to fetch the required packages: flutter pub get

3. Permissions:
Location: The app requires GPS permissions to calculate distance and show your position on the map.
Internet: Required for real-time ASK stress scores and Mitra AI responses.

4. Launch: flutter run


🧩 Software Architecture
The project follows a modular, layered architecture to ensure scalability:

Presentation Layer: Dynamic UI components with bilingual support.

Logic Layer: State management using ValueNotifier for real-time map and UI updates.

Data Layer: Mock repositories simulating live UIDAI backend nodes for the Raipur region.



Note: This project was developed as a submission for TechSprint 2026 Amity University Chhattisgarh.
