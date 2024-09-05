# Albumify

## Table of Contents
1. [Introduction](#introduction)
2. [Features](#features)
3. [Tech Stack](#tech-stack)
4. [Architecture Overview](#architecture-overview)
5. [Project Folder Structure](#project-folder-structure)
6. [Dependencies](#dependencies)


---

## Introduction

**Albumify** is a SwiftUI-based iOS app using **The Composable Architecture (TCA)** for state management. It features an album management system that allows you to search albums from the Imgur API, select which albums and image are your favorite, and easily view them in an organized fashion. With a clean and easy user interface you can keep track of all your favorite photo collections.

---

## Features

- Search for albums based on any word or phrase you input
- View all photos within that album
- Select which albums and images are your favorites
- View your favorite albums and images in an organized, easy to use interface

---

## Tech Stack

- **Language**: Swift
- **UI Framework**: SwiftUI
- **State Management**: The Composable Architecture (TCA)
- **Async Handling**: async/await
- **Dependency Management**: Dependencies library within TCA
- **iOS Version**: iOS 16+
- **Package Manager**: Swift Package Manager (SPM)

---

## Architecture Overview

The application leverages **TCA** for a modular and testable architecture, utilizes **async/await** for asynchronous operations and the **Dependencies** library (within TCA) for dependency management. It features a delegated file structure which favors a multi-module mono repo approach. This separates concerns allowing for effective testing, resposible dependency injection, and support for poly repo migration.

### Key Components:

- **State Management**: Centralized state using `Store` and `Reducer`.
- **Async Operations**: Managed using `async/await` for cleaner asynchronous code.
- **Dependency Injection**: Handled using the **Dependencies** library within TCA.
- **Multi-Module Structure**: Isolated directories designed as stand alone independent packages.

---

## Project Folder Structure

Below is an overview of the project folder and file structure

```plaintext
📁 **App**
  ├── 📁 **Utilities**
  ├── 📁 **Domains**
  │   ├── 📁 **API**
  │   │   ├── 📄 `ImgurAPI.swift`
  │   ├── 📄 `Service.swift`
  ├── 📁 **Models**
  │   ├── 📄 `Album.swift`
  │   ├── 📄 `AlbumImage.swift`
  ├── 📁 **Features**
  │   ├── 📁 **Albums**
  │   │   ├── 📄 `AlbumsFeature.swift`
  │   │   ├── 📄 `AlbumsView.swift`
  │   ├── 📁 **Favorites**
  ├── 📁 **Root**
  │   ├── 📄 `RootFeature.swift`
  │   └── 📄 `RootView.swift`
  └── 📄 `App.swift`
  ├── 📁 **ComponentsPackage**
  ├── 📁 **NetworkingPackage**
```

### Important Files:

All primary views have a corresponding reducer named `...Feature.swift` which houses the `State` and business logic for that view.

- **App.swift**: The main entry point of the app where the parent `Store` (`RootFeature`) is initialized.
- **RootView.swift**: Intial view of the application in SwiftUI.
- **RootFeature.swift**: Corresponding `Reducer` for `RootView.swift` handling `Actions` for that view.

---

## Dependencies

This project utilizes a single core library to facilitate state management and dependency injection. Below is a detailed overview:

### Core Dependency

1. **The Composable Architecture (TCA)**
   - **URL**: [Swift Composable Architecture](https://github.com/pointfreeco/swift-composable-architecture)
   - **Description**: TCA provides a robust framework for managing state, actions, and side effects in a predictable manner. It supports modular design, scalable state management, and isolated testing.
   - **Version**: `1.14.0`
   - **Integration**:
     ```swift
     dependencies: [
         .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "0.30.0")
     ]
     ```
### Note:
  **TCA** has an internal dependency on [Swift Dependencies](https://github.com/pointfreeco/swift-dependencies) which is used for dependency management in this project

### Integration

Dependencies are managed via **Swift Package Manager (SPM)**. 
