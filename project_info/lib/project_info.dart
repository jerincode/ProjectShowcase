class ProjectInfo {
  final String name;
  final String technology;
  final String batch;
  final String description;
  final String learning;
  final String category;
  final List<String> members;
  final int year;
  final String difficulty; // 'Beginner', 'Intermediate', 'Advanced'
  final String? githubUrl;
  final String? demoUrl;
  final List<String> tags;

  ProjectInfo({
    required this.name,
    required this.technology,
    required this.batch,
    required this.description,
    required this.learning,
    required this.category,
    required this.members,
    required this.year,
    required this.difficulty,
    this.githubUrl,
    this.demoUrl,
    required this.tags,
  });
}

final List<ProjectInfo> projects = [
  ProjectInfo(
    name: 'Smart Attendance System',
    technology: 'Flutter + Firebase',
    batch: '2025 Batch',
    category: 'Mobile App',
    year: 2025,
    difficulty: 'Intermediate',
    members: ['Arjun Kumar', 'Priya Nair', 'Rahul Menon'],
    description:
        'A mobile application designed to manage student attendance digitally using QR codes and real-time Firebase sync. Teachers can mark attendance, students can view their records, and admins get full reports.',
    learning:
        'Juniors can learn about Flutter UI design, Firebase Firestore integration, QR code scanning, real-time database operations, and user authentication with Firebase Auth.',
    githubUrl: 'https://github.com/example/smart-attendance',
    tags: ['Flutter', 'Firebase', 'QR Code', 'Auth', 'Firestore'],
  ),
  ProjectInfo(
    name: 'AR Area Measurement',
    technology: 'Flutter + ARCore',
    batch: '2025 Batch',
    category: 'AR/VR',
    year: 2025,
    difficulty: 'Advanced',
    members: ['Sneha Pillai', 'Arun Das'],
    description:
        'An application that uses augmented reality to measure the area of real-world surfaces and objects. Point your camera at a room floor and get accurate area measurements instantly.',
    learning:
        'Juniors can learn about ARCore integration, camera-based applications, 3D spatial reasoning, plane detection, and augmented reality concepts in mobile development.',
    tags: ['Flutter', 'ARCore', 'AR', 'Camera', 'Geometry'],
  ),
  ProjectInfo(
    name: 'Hostel Management System',
    technology: 'Flutter + Dart',
    batch: '2024 Batch',
    category: 'Management',
    year: 2024,
    difficulty: 'Intermediate',
    members: ['Ananya Krishnan', 'Vishnu Raj', 'Mohammed Azhar'],
    description:
        'A mobile application for managing hostel rooms, student allotments, fee tracking, and complaint management. Includes both student and warden portals with role-based access.',
    learning:
        'Juniors can learn about application navigation patterns, forms, role-based UI, local data storage, and structured UI development in Flutter.',
    githubUrl: 'https://github.com/example/hostel-mgmt',
    tags: ['Flutter', 'SQLite', 'Forms', 'Navigation', 'CRUD'],
  ),
  ProjectInfo(
    name: 'Online Book Store',
    technology: 'Flutter + REST API',
    batch: '2024 Batch',
    category: 'E-Commerce',
    year: 2024,
    difficulty: 'Beginner',
    members: ['Keerthi Suresh', 'Divya Menon'],
    description:
        'A mobile application that allows users to browse, search, and manage books from an online catalog. Features a cart system, wishlist, and order history using REST API integration.',
    learning:
        'Juniors can learn about REST API integration, JSON parsing, Flutter list views, state management with setState, and building e-commerce-like UI patterns.',
    githubUrl: 'https://github.com/example/book-store',
    demoUrl: 'https://bookstore-demo.web.app',
    tags: ['Flutter', 'REST API', 'JSON', 'Cart', 'Search'],
  ),
  ProjectInfo(
    name: 'Campus Navigator',
    technology: 'Flutter + Google Maps',
    batch: '2025 Batch',
    category: 'Navigation',
    year: 2025,
    difficulty: 'Intermediate',
    members: ['Rohan Thomas', 'Aparna Nair', 'Siddharth Pillai'],
    description:
        'An indoor and outdoor navigation app for the college campus. Helps students find classrooms, labs, canteen, and other facilities using Google Maps and custom indoor maps.',
    learning:
        'Juniors can learn about Google Maps SDK, custom markers, geolocation, indoor mapping, and building navigation-focused applications in Flutter.',
    tags: ['Flutter', 'Google Maps', 'Geolocation', 'Navigation'],
  ),
  ProjectInfo(
    name: 'Mental Health Tracker',
    technology: 'Flutter + Hive',
    batch: '2024 Batch',
    category: 'Health & Wellness',
    year: 2024,
    difficulty: 'Beginner',
    members: ['Riya Sharma', 'Aditya Verma'],
    description:
        'A daily mood and mental wellness tracking app for students. Users log their mood, journal thoughts, view weekly trends, and get mindfulness tips. All data is stored locally for privacy.',
    learning:
        'Juniors can learn about local database storage with Hive, chart/graph widgets, daily reminder notifications, and building health-focused UI in Flutter.',
    tags: ['Flutter', 'Hive', 'Charts', 'Notifications', 'Privacy'],
  ),
  ProjectInfo(
    name: 'Smart Canteen App',
    technology: 'Flutter + Firebase + Razorpay',
    batch: '2025 Batch',
    category: 'E-Commerce',
    year: 2025,
    difficulty: 'Advanced',
    members: ['Gokul Nair', 'Parvathy Das', 'Ashwin Kumar', 'Lakshmi R'],
    description:
        'A digital canteen ordering system where students pre-order food and pay online. Includes real-time order tracking, menu management for admin, and payment gateway integration.',
    learning:
        'Juniors can learn about payment gateway integration, real-time order management, Firebase Cloud Functions, push notifications, and building complex multi-role apps.',
    githubUrl: 'https://github.com/example/smart-canteen',
    tags: ['Flutter', 'Firebase', 'Razorpay', 'Real-time', 'Payments'],
  ),
  ProjectInfo(
    name: 'Placement Portal',
    technology: 'Flutter + Node.js + MongoDB',
    batch: '2024 Batch',
    category: 'Education',
    year: 2024,
    difficulty: 'Advanced',
    members: ['Nikhil Menon', 'Anjali Pillai', 'Rahul George'],
    description:
        'A comprehensive placement management app for students and HR teams. Students can apply for jobs, upload resumes, and track application status. Admins manage company visits and results.',
    learning:
        'Juniors can learn about REST API with Node.js backend, MongoDB integration, file upload handling, multi-screen complex apps, and connecting Flutter to custom backends.',
    tags: ['Flutter', 'Node.js', 'MongoDB', 'REST', 'File Upload'],
  ),
  ProjectInfo(
    name: 'AI Study Assistant',
    technology: 'Flutter + OpenAI API',
    batch: '2025 Batch',
    category: 'AI/ML',
    year: 2025,
    difficulty: 'Advanced',
    members: ['Athira Krishnan', 'Vishakh Suresh'],
    description:
        'An AI-powered study companion that answers academic questions, generates quiz questions from uploaded notes, summarizes textbook chapters, and provides personalized study plans.',
    learning:
        'Juniors can learn about OpenAI API integration, prompt engineering, chat UI design, PDF text extraction, and building AI-powered mobile applications in Flutter.',
    demoUrl: 'https://ai-study-demo.web.app',
    tags: ['Flutter', 'OpenAI', 'AI', 'NLP', 'PDF'],
  ),
  ProjectInfo(
    name: 'E-Voting System',
    technology: 'Flutter + Blockchain',
    batch: '2024 Batch',
    category: 'Security',
    year: 2024,
    difficulty: 'Advanced',
    members: ['Arun Pillai', 'Meera Thomas', 'Kiran Kumar'],
    description:
        'A secure digital voting application for college elections using blockchain technology. Each vote is recorded as an immutable transaction, ensuring transparency and preventing tampering.',
    learning:
        'Juniors can learn about blockchain concepts, Ethereum smart contracts, cryptography basics, secure app design, and the intersection of mobile apps and Web3.',
    tags: ['Flutter', 'Blockchain', 'Ethereum', 'Security', 'Web3'],
  ),
  ProjectInfo(
    name: 'Sign Language Translator',
    technology: 'Flutter + TensorFlow Lite',
    batch: '2025 Batch',
    category: 'AI/ML',
    year: 2025,
    difficulty: 'Advanced',
    members: ['Devika Nair', 'Sanjay Kumar'],
    description:
        'A real-time sign language translation app using the phone camera and a custom-trained TensorFlow Lite model. Converts hand gestures to text and speech to help the hearing impaired.',
    learning:
        'Juniors can learn about TensorFlow Lite model integration, camera feed processing, custom ML model training, accessibility app design, and on-device AI inference.',
    tags: ['Flutter', 'TFLite', 'ML', 'Camera', 'Accessibility'],
  ),
  ProjectInfo(
    name: 'Library Management App',
    technology: 'Flutter + SQLite',
    batch: '2024 Batch',
    category: 'Management',
    year: 2024,
    difficulty: 'Beginner',
    members: ['Arathi Pillai', 'Jishnu Raj'],
    description:
        'A simple library management app for tracking book issues and returns. Librarians can add books, issue them to students, set due dates, and view overdue records — all stored locally.',
    learning:
        'Juniors can learn about SQLite database with the sqflite package, CRUD operations, list management, date handling in Dart, and building offline-first Flutter apps.',
    githubUrl: 'https://github.com/example/library-mgmt',
    tags: ['Flutter', 'SQLite', 'sqflite', 'CRUD', 'Offline'],
  ),
];