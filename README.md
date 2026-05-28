# FonoKit 🪶

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![SQLite](https://img.shields.io/badge/sqlite-%2307405e.svg?style=for-the-badge&logo=sqlite&logoColor=white)

FonoKit is a gamified, clinical-grade speech therapy application. Inspired by the serene, watercolor aesthetics of the game *Gris*, it provides a calming, distraction-free environment for phonetic rehabilitation. The app utilizes local Machine Learning for real-time audio processing and is built with an offline-first architecture to ensure seamless clinical and home use.

## ✨ Key Features

* **Miki Design System:**  glassmorphism, soft parallax effects, and fluid animations to prevent cognitive overload.A custom UI library built on a Japanese pastel palette (`#F6F6F6`, `#373D4A`, `#C9CBF4`, `#D0EEF4`, `#F6C9C9`). Features
* **On-Device AI Audio Processing:** Real-time speech recognition and phoneme validation running entirely locally (via TFLite/Vosk) to ensure zero latency and complete patient data privacy.
* **Isolate-Driven Performance:** Heavy ML inferences and 16kHz audio stream decoding are offloaded to background Dart Isolates, ensuring the UI remains at a buttery-smooth 60/120fps.
* **Offline-First Sync:** Powered by `drift` (SQLite), allowing continuous progress tracking even without an internet connection, with background batch synchronization to the backend.
* **Modular Learning Path:** A node-based progression system guiding users through specific articulation points (e.g., Bilabials, Alveolars).

## 🏗 Architecture

This project strictly adheres to **Clean Architecture** principles to separate concerns, ensuring maximum testability and scalability. State management is handled via the **BLoC** pattern (Business Logic Component).

* **Domain Layer:** Pure Dart code. Contains Entities, Use Cases, and Repository Interfaces.
* **Data Layer:** Handles API calls, local SQLite (`drift`) caching, and Repository Implementations.
* **Presentation Layer:** Flutter UI and State Management (`Cubit` for simple states, `BLoC` for complex event-driven streams like audio processing).

```text
lib/
├── core/                   # App-wide configs, Miki Design System, error handling
├── features/               # Feature modules (e.g., learning_path, exercises, profile)
│   └── feature_name/
│       ├── domain/         # Entities, UseCases, Repository Interfaces
│       ├── data/           # Models, Data Sources (Drift), Repository Impls
│       └── presentation/   # Pages, Widgets, BLoCs / Cubits
└── main.dart               # Entry point and Dependency Injection setup