# 📝 Stunning Todo: Modern Productivity Suite

[![Flutter](https://img.shields.io/badge/Flutter-v3.11+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Material 3](https://img.shields.io/badge/UI-Material_3-7B1FA2)](https://m3.material.io/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A premium, high-performance Todo application designed with **Material 3** principles. This app doesn't just manage tasks; it provides actionable insights through a stunning analytics dashboard, powered by a lightning-fast Hive local database.

---

## ✨ Key Features

### 📊 Advanced Analytics Dashboard
- **Visual Insights**: Interactive Pie and Bar charts powered by `fl_chart`.
- **Completion Tracking**: Real-time visualization of task completion rates.
- **Categorical Breakdown**: Statistics grouped by custom categories (Work, Personal, Health, etc.).

### 🛠️ Robust Task Management (CRUD)
- **Seamless Creation**: Modern bottom sheets for a non-intrusive "Add Task" experience.
- **Real-time Search**: Instant filtering of tasks with optimized search logic.
- **Categorization**: Organize your life with specific categories and dates.

### 🎨 Premium User Experience
- **Adaptive Themes**: Gorgeous Light and Dark modes with automatic system preference detection.
- **Typography**: Refined aesthetics using **Google Fonts (Poppins)**.
- **Smart Notifications**: Real-time local notifications for every major action (Add, Update, Delete).

---

## 🚀 Tech Stack

- **Core**: [Flutter](https://flutter.dev) (SDK ^3.11.5)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **Local Database**: [Hive](https://pub.dev/packages/hive) (Ultra-fast NoSQL)
- **Visualizations**: [FL Chart](https://pub.dev/packages/fl_chart)
- **Notifications**: [Flutter Local Notifications](https://pub.dev/packages/flutter_local_notifications)
- **Design**: Material 3 & Google Fonts

---

## 📦 Installation & Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/todo_app.git
   cd todo_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run Build Runner** (Required for Hive adapters)
   ```bash
   flutter pub run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

---

## 📜 License

Distributed under the MIT License. See `LICENSE` for more information.

---

## 🤝 Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

Developed with ❤️ by Muhammad Ehsan
