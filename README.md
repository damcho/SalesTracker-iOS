# SalesTracker iOS

A modern, beautifully designed iOS application for tracking sales products and managing revenue data with real-time currency conversion capabilities.

## 📱 What the App Does

SalesTracker is a comprehensive sales management application that allows users to:

- **Secure Authentication**: Login with username/password authentication with token-based session management
- **Product Management**: View and manage a list of products with their sales data
- **Sales Tracking**: Monitor individual sales transactions with detailed breakdowns
- **Currency Conversion**: Real-time conversion between different currencies for international sales
- **Revenue Analytics**: Track total sales amounts per product with converted values
- **Offline Support**: Robust error handling and network connectivity management

## 🛠 Technology Stack

### **Frontend**
- **SwiftUI** - Modern declarative UI framework
- **iOS 18.4+** - Latest iOS features and capabilities
- **Swift** - Primary programming language

### **Architecture**
- **Clean Architecture** - Separation of concerns with clear boundaries
- **MVVM Pattern** - Model-View-ViewModel for UI layer
- **Dependency Injection** - Loose coupling and testability
- **Composition Root** - Centralized object composition
- **Repository Pattern** - Data access abstraction

### **Networking**
- **URLSession** - Native HTTP client
- **Custom HTTP Client** - Abstracted networking layer
- **RESTful APIs** - Standard API communication
- **Token Authentication** - Secure API access

### **Data & Storage**
- **Keychain Services** - Secure token storage
- **In-Memory Caching** - Performance optimization
- **JSON Parsing** - Custom mappers for API responses

### **Testing**
- **XCTest** - Native testing framework
- **Unit Tests** - Comprehensive test coverage
- **Integration Tests** - End-to-end testing
- **Test Doubles** - Mocks, stubs, and spies
- **Memory Leak Detection** - Automated leak tracking

## 🏗 Architecture Overview

### **Layer Structure**
```
┌─────────────────────────────────────┐
│              UI Layer               │
│  (SwiftUI Views + ViewModels)       │
├─────────────────────────────────────┤
│           Business Layer            │
│     (Domain Models + Use Cases)     │
├─────────────────────────────────────┤
│             Data Layer              │
│  (Repositories + Data Sources)      │
├─────────────────────────────────────┤
│         Infrastructure Layer        │
│   (Network + Storage + External)    │
└─────────────────────────────────────┘
```

### **Key Components**

#### **Authentication Module**
- `Authenticable` protocol for authentication contracts
- `TokenStoreAuthenticableDecorator` for secure token management
- `RemoteAuthenticatorHandler` for API authentication
- `ActivityIndicatorAuthenticationDecorator` for loading states
- `ErrorDisplayableDecorator` for error handling

#### **Products Module**
- `Product` and `Sale` domain models
- `ProductSalesLoader` for data fetching
- `CurrencyConverter` for real-time conversions
- `RemoteProductsLoader` and `RemoteSalesLoader` for API integration

#### **Networking Infrastructure**
- `SalesTrackerHTTPClient` protocol abstraction
- `URLSessionHTTPClient` concrete implementation
- `HTTPHeaderDecorator` for request enhancement
- `RemoteGetLoader` generic data loading

#### **UI Components**
- **Login Flow**: Modern authentication interface with smooth animations
- **Product List**: Beautiful product cards with sales summaries
- **Product Details**: Detailed sales breakdowns with currency conversion
- **Error Handling**: Elegant error displays with auto-dismiss
- **Loading States**: Activity indicators and skeleton screens

## 🎨 Design System

### **Visual Design**
- **Modern iOS Design Language** - Following Apple's Human Interface Guidelines
- **Dark Mode Support** - Seamless light/dark mode transitions
- **Semantic Colors** - Adaptive colors that work in all environments
- **SF Symbols** - Native iconography for consistency
- **Rounded Design System** - Consistent typography and spacing

### **User Experience**
- **Smooth Animations** - Polished transitions and micro-interactions
- **Pull-to-Refresh** - Standard iOS refresh patterns
- **Empty States** - Helpful messaging when no data is available
- **Error Recovery** - Clear error messages with retry capabilities
- **Accessibility** - VoiceOver support and proper contrast ratios

## 📂 Project Structure

```
SalesTracker/
├── Main/                    # App entry point and navigation
├── Login/                   # Authentication module
│   ├── Domain/             # Authentication contracts
│   ├── Networking/         # Remote authentication
│   ├── ViewModel/          # Login view models
│   └── Views/              # Login UI components
├── ProductsList/           # Products listing module
│   ├── Domain/             # Product and sale models
│   ├── Network/            # API integration
│   ├── ViewModel/          # List view models
│   └── Views/              # Product list UI
├── ProductDetail/          # Product details module
│   ├── Domain/             # Currency conversion logic
│   ├── ViewModel/          # Detail view models
│   └── Views/              # Detail UI components
├── Common/                 # Shared components
│   ├── ViewModel/          # Reusable view models
│   └── Views/              # Common UI elements
├── Networking/             # Core networking infrastructure
└── Store/                  # Data persistence layer
```

## 🧪 Testing Strategy

### **Test Coverage**
- **Unit Tests**: Individual component testing
- **Integration Tests**: Module interaction testing
- **UI Tests**: End-to-end user journey testing
- **Network Tests**: API integration testing
- **Memory Tests**: Leak detection and performance

### **Testing Utilities**
- `TestHelpers` - Common testing utilities
- `HTTPClientStub` - Network request mocking
- `TokenStoreSpy` - Authentication testing
- `MemoryLeakTracker` - Automatic leak detection

## 🚀 Getting Started

### **Requirements**
- Xcode 15.0+
- iOS 18.4+
- Swift 5.9+

### **Installation**
1. Clone the repository
2. Open `SalesTracker.xcodeproj` in Xcode
3. Build and run on simulator or device

### **Configuration**
- No additional setup required
- All dependencies are managed through Swift Package Manager
- API endpoints and configuration are handled internally

## 📋 Features

### **Authentication**
- ✅ Secure login with username/password
- ✅ Token-based session management
- ✅ Automatic token refresh
- ✅ Secure keychain storage

### **Product Management**
- ✅ Product listing with sales summaries
- ✅ Real-time currency conversion
- ✅ Detailed sales breakdowns
- ✅ Pull-to-refresh functionality

### **User Experience**
- ✅ Beautiful, modern UI design
- ✅ Dark mode support
- ✅ Smooth animations and transitions
- ✅ Error handling with auto-dismiss
- ✅ Loading states and empty states

### **Technical Excellence**
- ✅ Clean architecture implementation
- ✅ Comprehensive test coverage
- ✅ Memory leak prevention
- ✅ Performance optimization
- ✅ Accessibility support

## 🤝 Contributing

This project follows clean architecture principles and maintains high code quality standards. When contributing:

1. Follow the established architectural patterns
2. Write comprehensive tests for new features
3. Ensure UI components support both light and dark modes
4. Maintain consistent code style and documentation

## 📄 License

This project is developed as part of the Essential Developer program and follows their architectural guidelines and best practices.
