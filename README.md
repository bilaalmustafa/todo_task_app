# To-Do Task App

## Overview

The To-Do Task App is a simple and efficient task management application built using Flutter and GetX for state management. This app allows users to add, daily or only for today task and save complete, and delete tasks with smooth animations and a clean user interface. 

## Features

- 📌 Task Management: Add, complete, and delete tasks easily.
- 🎨 Modern UI: Clean and intuitive design with categorized sections.
- 🚀 State Management: Uses GetX for efficient state handling.
- 🏗 Animations: Smooth transitions for task visibility and navigation.
- 📂 Local Storage: Tasks persist using local storage Hive.

## Tech Stack

- Framework: Flutter
- State Management: GetX
- UI Components: Material Design
- Local Storage: Hive

## Folder Structure
lib/                                                                                                                                        
│── controller/                                                                                                                                            
│ ├── controller.dart # GetX controller for managing tasks                                                                                                                                                              
│── model/                                                                                                                      
│ ├── task_model.dart # Task model class                                                                                                                        
│── res/                                                                                                    
│ ├── colors.dart # App theme colors                                                                                                                    
│ ├── components/ # Reusable UI components                                                                                                                  
│── view/                                                                                                      
│ ├── home_screen.dart # Main screen with task list                                                                                            
│ ├── add_task_screen.dart # Screen to add new tasks                                                                                            
│ ├── splash_screen.dart # Splash Screen to Home Screen                                                                                                                                                      
│── main.dart # App entry point                                                                                                                                      

## Usage

- Add a Task: Click the + button to add a new task.
- Complete a Task: Tap on a task to mark it as completed.
- Delete a Task: Use the delete button to remove a task.
- Animations: Task options appear with smooth opacity animations.

## Setup Instructions

1. **Clone the repository:**
    ```sh
    git clone https://github.com/bilaalmustafa/todo_task_app.git
    ```

2. **Navigate to the project directory:**
    ```sh
    cd todo_task_app
    ```

3. **Install the dependencies:**
    ```sh
    flutter pub get
    ```

4. **Run the app:**
    ```sh
    flutter run
    ```

For more details, visit the [repository](https://github.com/bilaalmustafa/todo_task_app).
