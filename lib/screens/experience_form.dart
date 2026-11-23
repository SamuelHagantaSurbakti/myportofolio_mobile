import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _thumbnailController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _passwordController = TextEditingController();

  String _category = 'Full-Time';
  DateTime? _startDate;
  DateTime? _endDate;

  // Sesuaikan dengan pilihan kategori di model Django-mu
  final List<String> _categories = [
    'Full-Time',
    'Part-Time',
    'Internship',
    'Freelance',
    'Volunteer',
    'Research',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _thumbnailController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime d) =>
      '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';

  Future<void> _pickDate({required bool isStart}) async {
    final initial = (isStart ? _startDate : _endDate) ?? DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked == null || !mounted) return;
    setState(() {
      if (isStart) {
        _startDate = picked;
        _startDateController.text = _formatDate(picked);
      } else {
        _endDate = picked;
        _endDateController.text = _formatDate(picked);
      }
    });
  }

  bool _isValidUrl(String value) {
    final uri = Uri.tryParse(value);
    return uri != null &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty;
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    _nameController.clear();
    _descriptionController.clear();
    _thumbnailController.clear();
    _startDateController.clear();
    _endDateController.clear();
    _passwordController.clear();
    setState(() {
      _category = 'Full-Time';
      _startDate = null;
      _endDate = null;
    });
  }

  void _showSummary() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Experience berhasil ditambahkan!'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nama Experience: ${_nameController.text.trim()}'),
                Text('Deskripsi: ${_descriptionController.text.trim()}'),
                Text('Kategori: $_category'),
                Text('URL Thumbnail: ${_thumbnailController.text.trim()}'),
                Text('Tanggal Dimulai: ${_startDateController.text}'),
                Text(
                  'Tanggal Selesai: '
                  '${_endDateController.text.isEmpty ? "-" : _endDateController.text}',
                ),
                // Password sengaja disamarkan di ringkasan
                Text('Password: ${'•' * _passwordController.text.length}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
                _resetForm();
              },
            ),
          ],
        );
      },
    );
  }

  InputDecoration _decoration(String label, {String? hint}) {
    return InputDecoration(
      labelText: label,
      hintText: hint ?? label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Experience',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // === Nama Experience ===
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _nameController,
                  decoration: _decoration(
                    'Nama Experience',
                    hint: 'Contoh: Software Engineer Intern',
                  ),
                  validator: (value) {
                    final v = value?.trim() ?? '';
                    if (v.isEmpty) return 'Nama experience tidak boleh kosong!';
                    if (v.length < 3) {
                      return 'Nama experience minimal 3 karakter!';
                    }
                    if (v.length > 100) {
                      return 'Nama experience maksimal 100 karakter!';
                    }
                    return null;
                  },
                ),
              ),

              // === Deskripsi Experience ===
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _descriptionController,
                  maxLines: 5,
                  decoration: _decoration(
                    'Deskripsi Experience',
                    hint: 'Ceritakan peran dan kontribusimu...',
                  ),
                  validator: (value) {
                    final v = value?.trim() ?? '';
                    if (v.isEmpty) {
                      return 'Deskripsi experience tidak boleh kosong!';
                    }
                    if (v.length < 10) return 'Deskripsi minimal 10 karakter!';
                    if (v.length > 500) {
                      return 'Deskripsi maksimal 500 karakter!';
                    }
                    return null;
                  },
                ),
              ),

              // === Kategori Experience ===
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DropdownButtonFormField<String>(
                  decoration: _decoration('Kategori Experience'),
                  initialValue: _category,
                  items: _categories
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _category = newValue!;
                    });
                  },
                ),
              ),

              // === URL Thumbnail ===
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _thumbnailController,
                  keyboardType: TextInputType.url,
                  decoration: _decoration(
                    'URL Thumbnail Experience (16 : 9)',
                    hint: 'https://drive.google.com/thumbnail?id=...&sz=w1000',
                  ),
                  validator: (value) {
                    final v = value?.trim() ?? '';
                    if (v.isEmpty) return 'URL thumbnail tidak boleh kosong!';
                    if (!_isValidUrl(v)) {
                      return 'Format URL tidak valid (harus diawali http:// atau https://)!';
                    }
                    return null;
                  },
                ),
              ),

              // === Tanggal Dimulai ===
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _startDateController,
                  readOnly: true,
                  decoration: _decoration('Tanggal Dimulai')
                      .copyWith(suffixIcon: const Icon(Icons.calendar_today)),
                  onTap: () => _pickDate(isStart: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tanggal dimulai harus dipilih!';
                    }
                    return null;
                  },
                ),
              ),

              // === Tanggal Selesai (opsional) ===
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _endDateController,
                  readOnly: true,
                  decoration: _decoration('Tanggal Selesai (opsional)')
                      .copyWith(suffixIcon: const Icon(Icons.calendar_today)),
                  onTap: () => _pickDate(isStart: false),
                  validator: (value) {
                    if (value == null || value.isEmpty) return null;
                    if (_startDate != null &&
                        _endDate != null &&
                        _endDate!.isBefore(_startDate!)) {
                      return 'Tanggal selesai tidak boleh sebelum tanggal dimulai!';
                    }
                    return null;
                  },
                ),
              ),

              // === Tombol Simpan ===
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _showSummary();
                    }
                  },
                  child: const Text(
                    'Simpan',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
