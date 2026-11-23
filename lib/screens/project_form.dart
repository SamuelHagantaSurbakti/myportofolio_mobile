import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _technologiesController = TextEditingController();
  final _linkController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  String _category = 'Web Development';
  DateTime? _startDate;
  DateTime? _endDate;

  final List<String> _categories = [
    'Web Development',
    'Mobile Development',
    'Machine Learning',
    'Data Science',
    'Other',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _technologiesController.dispose();
    _linkController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
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
    _technologiesController.clear();
    _linkController.clear();
    _startDateController.clear();
    _endDateController.clear();
    setState(() {
      _category = 'Web Development';
      _startDate = null;
      _endDate = null;
    });
  }

  void _showSummary() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Proyek berhasil ditambahkan!'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nama Proyek: ${_nameController.text.trim()}'),
                Text('Deskripsi: ${_descriptionController.text.trim()}'),
                Text('Kategori: $_category'),
                Text('Teknologi: ${_technologiesController.text.trim()}'),
                Text('Tanggal Mulai: ${_startDateController.text}'),
                Text(
                  'Tanggal Selesai: '
                  '${_endDateController.text.isEmpty ? "-" : _endDateController.text}',
                ),
                Text(
                  'Tautan: '
                  '${_linkController.text.trim().isEmpty ? "-" : _linkController.text.trim()}',
                ),
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
          'Add Project',
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
              // === Nama Proyek ===
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _nameController,
                  decoration: _decoration('Nama Proyek'),
                  validator: (value) {
                    final v = value?.trim() ?? '';
                    if (v.isEmpty) {
                      return 'Nama proyek tidak boleh kosong!';
                    }
                    if (v.length < 3) {
                      return 'Nama proyek minimal 3 karakter!';
                    }
                    if (v.length > 100) {
                      return 'Nama proyek maksimal 100 karakter!';
                    }
                    return null;
                  },
                ),
              ),

              // === Deskripsi ===
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _descriptionController,
                  maxLines: 5,
                  decoration: _decoration('Deskripsi Proyek'),
                  validator: (value) {
                    final v = value?.trim() ?? '';
                    if (v.isEmpty) {
                      return 'Deskripsi proyek tidak boleh kosong!';
                    }
                    if (v.length < 10) {
                      return 'Deskripsi minimal 10 karakter!';
                    }
                    if (v.length > 500) {
                      return 'Deskripsi maksimal 500 karakter!';
                    }
                    return null;
                  },
                ),
              ),

              // === Kategori ===
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DropdownButtonFormField<String>(
                  decoration: _decoration('Kategori Proyek'),
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

              // === Teknologi ===
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _technologiesController,
                  decoration: _decoration(
                    'Teknologi yang Digunakan',
                    hint: 'Contoh: Flutter, Django, Figma',
                  ),
                  validator: (value) {
                    final v = value?.trim() ?? '';
                    if (v.isEmpty) {
                      return 'Teknologi tidak boleh kosong!';
                    }
                    if (v.length > 100) {
                      return 'Teknologi maksimal 100 karakter!';
                    }
                    return null;
                  },
                ),
              ),

              // === Tanggal Mulai ===
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _startDateController,
                  readOnly: true,
                  decoration: _decoration('Tanggal Mulai')
                      .copyWith(suffixIcon: const Icon(Icons.calendar_today)),
                  onTap: () => _pickDate(isStart: true),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tanggal mulai harus dipilih!';
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
                      return 'Tanggal selesai tidak boleh sebelum tanggal mulai!';
                    }
                    return null;
                  },
                ),
              ),

              // === Tautan (opsional) ===
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _linkController,
                  keyboardType: TextInputType.url,
                  decoration: _decoration(
                    'Tautan Proyek',
                    hint: 'https://github.com/... (opsional)',
                  ),
                  validator: (value) {
                    final v = value?.trim() ?? '';
                    if (v.isEmpty) {
                      return null;
                    }
                    if (!_isValidUrl(v)) {
                      return 'Format URL tidak valid (harus diawali http:// atau https://)!';
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
