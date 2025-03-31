# News App

A Flutter news app that fetches and displays the latest articles with instant search functionality. Built with clean architecture and BLoC state management, it offers smooth browsing, keyword searches, and offline reading. The responsive design works perfectly on mobile.

## Features

- splash and onboarding with animation 
- Login and Register with Firebase 
- show all updated news 
- Searching for a specific article 

## Demo

[![Demo Video](https://drive.google.com/file/d/1PiRiSb_0mcWoJs3zBewhT9C-8YOUNwCe/view?usp=drivesdk )]([https://www.youtube.com/watch?v=YOUR_VIDEO_ID](https://drive.google.com/file/d/1PiRiSb_0mcWoJs3zBewhT9C-8YOUNwCe/view?usp=drivesdk )

## Installation

### Prerequisites

- Flutter SDK (version 3.19.5 or higher)
- Dart (version 3.3.0 or higher)
- Android Studio/Xcode (for mobile builds)
- VS Code/Android Studio (with Flutter plugin)

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/flutter-app.git
   cd flutter-app
   
2. Install dependencies:
   ```bash
   Flutter pub get
  

3. Run App:
   ```bash
   Flutter run


## Implementation Approach
- Architecture
  - Clean Architecture with separation of concerns
  - State Management: Bloc
  - API: https://newsapi.org/docs/get-started
  - Authentication: Firebase

## Packages Used
  - flutter_screenutil: for responsive screens
  - smooth_page_indicator: for loading indicators
  - dio: for fetching data from api
  - flutter_bloc: for handleing state managmnet 
  - Lottie: for animated splash screen
  - animated_splash_screen: for animated splash screen
  - flutter_launcher_icons: handleing logo
  - firebase_core: connect my app with Firebase
  - firebase_auth: implementing Authentication by Firebase
  - url_launcher: launching the article URL

- Key Features Implementation
  Feature 1: How you implemented it
  Feature 2: Challenges faced and solutions
  Responsive Design: How you handled different screen sizes
