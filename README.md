# E-Commerce Product Listing App

This is a simple e-commerce product listing app built using Flutter. The app allows users to browse products, view product details, add products to their cart, and manage their cart. User authentication is handled using Firebase Authentication, and cart data is stored in Firestore to ensure persistence across sessions.

## Features

- User Authentication (Sign Up, Login, Logout)
- Fetch products from Fake Store API
- Product Listing with Search functionality
- Product Detail Page with Add to Cart functionality
- Persistent Cart data using Firestore
- Responsive Design for Mobile, Tablet, and Desktop

## Screenshots

## Getting Started

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install) installed on your machine
- A Firebase project set up (Firestore and Authentication enabled)
Set up Firebase
Follow the instructions to add Firebase to your Flutter app: Firebase Setup
Replace the google-services.json file in the android/app directory with your Firebase configuration file.
Update Firestore Rules
- Fake Store API for product data

### Installation

1. Clone the repository

```bash
git clone https://github.com/priyankanit/E-commerce-assignment.git
cd E-commerce-assignment

## Install Dependencies
flutter pub get

### Running the app
flutter run