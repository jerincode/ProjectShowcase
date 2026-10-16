import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_info/project_info.dart';

class FirestoreService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static const String _collection = 'projects';

  /// Stream of all projects from Firestore (live updates)
  static Stream<List<ProjectInfo>> projectsStream() {
    return _db
        .collection(_collection)
        .orderBy('year', descending: true)
        .snapshots()
        .map((snap) => snap.docs.map((doc) => _fromDoc(doc)).toList());
  }

  /// Seed Firestore with hardcoded projects if collection is empty
  static Future<void> seedIfEmpty() async {
    final snap = await _db.collection(_collection).limit(1).get();
    if (snap.docs.isEmpty) {
      final batch = _db.batch();
      for (final p in projects) {
        final ref = _db.collection(_collection).doc();
        batch.set(ref, _toMap(p));
      }
      await batch.commit();
      // ignore: avoid_print
      print('✅ Seeded ${projects.length} projects to Firestore');
    }
  }

  /// Add a new project to Firestore
  static Future<void> addProject(ProjectInfo project) async {
    await _db.collection(_collection).add(_toMap(project));
  }

  /// Delete a project from Firestore
  static Future<void> deleteProject(String docId) async {
    await _db.collection(_collection).doc(docId).delete();
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  static Map<String, dynamic> _toMap(ProjectInfo p) => {
        'name': p.name,
        'technology': p.technology,
        'batch': p.batch,
        'description': p.description,
        'learning': p.learning,
        'category': p.category,
        'members': p.members,
        'year': p.year,
        'difficulty': p.difficulty,
        'githubUrl': p.githubUrl,
        'demoUrl': p.demoUrl,
        'tags': p.tags,
        'createdAt': FieldValue.serverTimestamp(),
      };

  static ProjectInfo _fromDoc(QueryDocumentSnapshot doc) {
    final d = doc.data() as Map<String, dynamic>;
    return ProjectInfo(
      name: d['name'] ?? '',
      technology: d['technology'] ?? '',
      batch: d['batch'] ?? '',
      description: d['description'] ?? '',
      learning: d['learning'] ?? '',
      category: d['category'] ?? '',
      members: List<String>.from(d['members'] ?? []),
      year: d['year'] ?? 0,
      difficulty: d['difficulty'] ?? 'Beginner',
      githubUrl: d['githubUrl'],
      demoUrl: d['demoUrl'],
      tags: List<String>.from(d['tags'] ?? []),
    );
  }
}
