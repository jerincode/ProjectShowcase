import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_info/project_info.dart';
import 'firestore_service.dart';
import 'main.dart' show AppTheme;

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({super.key});

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  // Controllers
  final _nameCtrl = TextEditingController();
  final _techCtrl = TextEditingController();
  final _batchCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _learningCtrl = TextEditingController();
  final _membersCtrl = TextEditingController();
  final _tagsCtrl = TextEditingController();
  final _githubCtrl = TextEditingController();
  final _demoCtrl = TextEditingController();

  String _category = 'Mobile App';
  String _difficulty = 'Beginner';
  int _year = DateTime.now().year;

  static const _categories = [
    'Mobile App', 'AR/VR', 'Management', 'E-Commerce',
    'Navigation', 'Health & Wellness', 'AI/ML', 'Education', 'Security',
  ];
  static const _difficulties = ['Beginner', 'Intermediate', 'Advanced'];

  @override
  void dispose() {
    _nameCtrl.dispose(); _techCtrl.dispose(); _batchCtrl.dispose();
    _descCtrl.dispose(); _learningCtrl.dispose(); _membersCtrl.dispose();
    _tagsCtrl.dispose(); _githubCtrl.dispose(); _demoCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final members = _membersCtrl.text
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();
      final tags = _tagsCtrl.text
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();

      final project = ProjectInfo(
        name: _nameCtrl.text.trim(),
        technology: _techCtrl.text.trim(),
        batch: _batchCtrl.text.trim(),
        description: _descCtrl.text.trim(),
        learning: _learningCtrl.text.trim(),
        category: _category,
        members: members,
        year: _year,
        difficulty: _difficulty,
        githubUrl: _githubCtrl.text.trim().isEmpty ? null : _githubCtrl.text.trim(),
        demoUrl: _demoCtrl.text.trim().isEmpty ? null : _demoCtrl.text.trim(),
        tags: tags,
      );

      await FirestoreService.addProject(project);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(children: [
              const Icon(Icons.check_circle_rounded, color: Colors.white),
              const SizedBox(width: 10),
              Text('Project "${project.name}" added to Firebase! 🎉',
                  style: const TextStyle(color: Colors.white)),
            ]),
            backgroundColor: const Color(0xFF00D4AA),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e', style: const TextStyle(color: Colors.white)),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: Text('Add New Project', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        backgroundColor: AppTheme.bg,
        actions: [
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Center(child: SizedBox(width: 20, height: 20,
                  child: CircularProgressIndicator(color: AppTheme.primary, strokeWidth: 2))),
            )
          else
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: TextButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.cloud_upload_rounded, color: AppTheme.accent),
                label: Text('Save', style: GoogleFonts.poppins(
                    color: AppTheme.accent, fontWeight: FontWeight.w600)),
              ),
            ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.primary, AppTheme.accent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(children: [
                const Icon(Icons.add_box_rounded, color: Colors.white, size: 28),
                const SizedBox(width: 12),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('New Project', style: GoogleFonts.poppins(
                      color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('Saves instantly to Firebase', style: GoogleFonts.poppins(
                      color: Colors.white70, fontSize: 12)),
                ]),
              ]),
            ),
            const SizedBox(height: 24),

            _sectionLabel('Basic Info'),
            _field(_nameCtrl, 'Project Name *', Icons.title_rounded,
                validator: (v) => v!.isEmpty ? 'Required' : null),
            _field(_techCtrl, 'Technology Stack *', Icons.code_rounded,
                hint: 'e.g. Flutter + Firebase',
                validator: (v) => v!.isEmpty ? 'Required' : null),
            _field(_batchCtrl, 'Batch *', Icons.group_rounded,
                hint: 'e.g. 2025 Batch',
                validator: (v) => v!.isEmpty ? 'Required' : null),

            // Year picker
            _sectionLabel('Year'),
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: AppTheme.card,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: AppTheme.border),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  const Icon(Icons.calendar_today_rounded, color: AppTheme.textSecondary, size: 20),
                  const SizedBox(width: 12),
                  Text('Year:', style: GoogleFonts.poppins(color: AppTheme.textSecondary)),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.remove, color: AppTheme.textSecondary),
                    onPressed: () => setState(() => _year = (_year - 1).clamp(2000, 2099)),
                  ),
                  Text('$_year', style: GoogleFonts.poppins(
                      color: AppTheme.textPrimary, fontWeight: FontWeight.bold, fontSize: 16)),
                  IconButton(
                    icon: const Icon(Icons.add, color: AppTheme.textSecondary),
                    onPressed: () => setState(() => _year = (_year + 1).clamp(2000, 2099)),
                  ),
                ],
              ),
            ),

            _sectionLabel('Category & Difficulty'),
            // Category dropdown
            _dropdownField(
              value: _category,
              icon: Icons.category_rounded,
              label: 'Category',
              items: _categories,
              onChanged: (v) => setState(() => _category = v!),
            ),
            // Difficulty dropdown
            _dropdownField(
              value: _difficulty,
              icon: Icons.bar_chart_rounded,
              label: 'Difficulty',
              items: _difficulties,
              onChanged: (v) => setState(() => _difficulty = v!),
            ),

            _sectionLabel('Details'),
            _field(_descCtrl, 'Description *', Icons.article_rounded,
                maxLines: 4,
                validator: (v) => v!.isEmpty ? 'Required' : null),
            _field(_learningCtrl, 'What juniors can learn *', Icons.lightbulb_rounded,
                maxLines: 3,
                validator: (v) => v!.isEmpty ? 'Required' : null),

            _sectionLabel('Team & Tags'),
            _field(_membersCtrl, 'Team Members *', Icons.people_rounded,
                hint: 'Comma separated: Alice, Bob, Charlie',
                validator: (v) => v!.isEmpty ? 'Add at least one member' : null),
            _field(_tagsCtrl, 'Tags *', Icons.label_rounded,
                hint: 'Comma separated: Flutter, Firebase, Auth',
                validator: (v) => v!.isEmpty ? 'Add at least one tag' : null),

            _sectionLabel('Links (Optional)'),
            _field(_githubCtrl, 'GitHub URL', Icons.code_rounded,
                hint: 'https://github.com/...'),
            _field(_demoCtrl, 'Demo URL', Icons.open_in_browser_rounded,
                hint: 'https://...'),

            const SizedBox(height: 20),

            // Submit button
            SizedBox(
              height: 56,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                icon: _isLoading
                    ? const SizedBox(width: 20, height: 20,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Icon(Icons.cloud_upload_rounded),
                label: Text(_isLoading ? 'Saving to Firebase...' : 'Save to Firebase',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 16)),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 4),
        child: Text(text,
            style: GoogleFonts.poppins(
                color: AppTheme.primary, fontWeight: FontWeight.w600, fontSize: 13,
                letterSpacing: 0.5)),
      );

  Widget _field(TextEditingController ctrl, String label, IconData icon,
      {String? hint, int maxLines = 1, String? Function(String?)? validator}) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: TextFormField(
          controller: ctrl,
          maxLines: maxLines,
          validator: validator,
          style: GoogleFonts.poppins(color: AppTheme.textPrimary, fontSize: 14),
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            hintStyle: const TextStyle(color: AppTheme.textSecondary, fontSize: 13),
            labelStyle: const TextStyle(color: AppTheme.textSecondary),
            prefixIcon: Icon(icon, color: AppTheme.textSecondary, size: 20),
            filled: true,
            fillColor: AppTheme.card,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppTheme.border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppTheme.primary, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Colors.redAccent),
            ),
          ),
        ),
      );

  Widget _dropdownField({
    required String value,
    required IconData icon,
    required String label,
    required List<String> items,
    required void Function(String?) onChanged,
  }) =>
      Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: DropdownButtonFormField<String>(
          value: value,
          dropdownColor: AppTheme.card,
          style: GoogleFonts.poppins(color: AppTheme.textPrimary, fontSize: 14),
          decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(color: AppTheme.textSecondary),
            prefixIcon: Icon(icon, color: AppTheme.textSecondary, size: 20),
            filled: true,
            fillColor: AppTheme.card,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: AppTheme.border),
            ),
          ),
          items: items
              .map((i) => DropdownMenuItem(
                    value: i,
                    child: Text(i, style: GoogleFonts.poppins(color: AppTheme.textPrimary)),
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      );
}
