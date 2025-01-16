![Simulator Screen Recording - iPhone 16 Pro - 2025-01-16 at 12 37 27](https://github.com/user-attachments/assets/4c372eab-08b3-47e3-9f35-27e7bcb1ab0f)

# **Quiz App**

## **Overview**

The **Quiz App** is a feature-rich iOS application built using **Swift**. It allows users to attempt MCQ questions related to Subjects and analyze thier result. The app provides simple and easy to uderstand and attend MCQ question and see the wrong answer as well as progress.

---

## **Features**

### **1. Quiz App**
- **Language Based Topics**: Provides the topics related to specific languages.  
- **Topic Based Question**: Provides questions based on topic selected.  
- **Progress Bar**: Track your progress and overall result.  
- **Track all Answers**: Track all the right and wrong answers at the end of quiz.    

---

## **Technologies Used**

- **Swift**: Core programming language for the app.  
- **UIKit**: For building the user interface.  
- **UserDefaults**: For local data persistence of progress.  
- **MVVM Design Pattern**: Ensures clean code separation between the View, ViewModel, and Model.  

---

## **Architecture**

The app is structured using the **MVVM** (Model-View-ViewModel) design pattern:

1. **Model**:  
   Represents the data structure (e.g., `QuizModel` model with `questions`, `answers` and `options` properties).  

2. **View**:  
   Handles UI components like `UITableView`, `UICollectionView`, and other visual elements.  

3. **ViewModel**:  
   Contains the app logic, such as managing todos, filtering data, and saving/loading to UserDefaults.  

---

## **How to Run the App**

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/yourusername/Quizze.git
   ```

2. **Open in Xcode**:  
   - Open the project in **Xcode**.  

3. **Run on Simulator or Device**:  
   - Select a target device/simulator and press **Run** (`Cmd + R`).   

---

## **Future Enhancements**

- **Dark Mode**: Add support for dark mode.
- **Search Functionality**: Search Functionality to search Topics or Languages
- **Timer**: Add Timer on Quiz question to attend
- **Notifications**: Add reminders for tasks.  
- **Dashboard**: Organize app and topics into dashboard.  

---

### **Enjoy managing your notes and tasks efficiently! 🚀**

---
