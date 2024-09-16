//importaciones que se requieren
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';



class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker(); //crea una instancia del selector de imagenes 
  XFile? _imageFile;
  //controlador 
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _githubController = TextEditingController();
  final TextEditingController _taskController = TextEditingController();

  String _selectedStatus = 'Disponible'; // Estado por defecto
  final List<String> _statusOptions = ['Disponible', 'Ocupado', 'No Molestar', 'Ausente'];

  final List<String> _tasks = [];

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {'subject': "Testing subject"},
    );
    await launchUrl(emailUri);
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'No se pudo realizar la llamada';
    }
  }

  Future<void> _launchInBrowserView(String username) async {
    final trimmedUsername = username.trim();
    var httpsUri = Uri(
      scheme: 'https',
      host: 'github.com',
      path: trimmedUsername,
    );

    if (!await launchUrl(
      httpsUri,
      mode: LaunchMode.inAppWebView,
    )) {
      throw Exception('No se pudo abrir $httpsUri');
    }
  }

  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        _tasks.add(_taskController.text);
        _taskController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => _showImageSourceActionSheet(context),
              child: CircleAvatar(
                radius: 60,
                backgroundImage: _imageFile != null
                    ? FileImage(File(_imageFile!.path))
                    : null,
                child: _imageFile == null
                    ? const Icon(Icons.camera_alt, size: 50, color: Colors.white)
                    : null,
                backgroundColor: Colors.deepPurple.shade200,
              ),
            ),
            const SizedBox(height: 20),
            _buildProfileField(
              label: "Nombre Completo",
              controller: _nameController,
              icon: Icons.person,
            ),
            const SizedBox(height: 20),
            _buildProfileFieldWithAction(
              label: "Correo",
              controller: _emailController,
              icon: Icons.email,
              onIconPressed: () => _launchEmail(_emailController.text),
            ),
            const SizedBox(height: 20),
            _buildProfileFieldWithAction(
              label: "Teléfono",
              controller: _phoneController,
              icon: Icons.phone,
              onIconPressed: () => _makePhoneCall(_phoneController.text),
            ),
            const SizedBox(height: 20),
            _buildProfileFieldWithAction(
              label: "GitHub",
              controller: _githubController,
              icon: Icons.link,
              onIconPressed: () => _launchInBrowserView(_githubController.text),
            ),
            const SizedBox(height: 20),
            _buildUserStatusField(),
            const SizedBox(height: 20),
            _buildTaskSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.deepPurple),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: label,
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileFieldWithAction({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required VoidCallback onIconPressed,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        child: Row(
          children: [
            Icon(icon, color: Colors.deepPurple),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: label,
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.open_in_new, color: Colors.deepPurple),
              onPressed: onIconPressed,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserStatusField() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        child: Row(
          children: [
            const Icon(Icons.circle, color: Colors.deepPurple),
            const SizedBox(width: 10),
            const Text("Estado"),
            const SizedBox(width: 10),
            Expanded(
              child: DropdownButton<String>(
                value: _selectedStatus,
                items: _statusOptions.map((String status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (String? newStatus) {
                  setState(() {
                    _selectedStatus = newStatus!;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Tareas/Recordatorios",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ReorderableListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          onReorder: _onReorder,
          children: _tasks.map((task) {
            return ListTile(
              key: ValueKey(task),
              title: Text(task),
              leading: Icon(Icons.drag_handle, color: Colors.deepPurple),
              tileColor: Colors.deepPurple.shade50,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _taskController,
                decoration: InputDecoration(
                  labelText: "Agregar nueva tarea",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add, color: Colors.deepPurple),
              onPressed: _addTask,
            ),
          ],
        ),
      ],
    );
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final task = _tasks.removeAt(oldIndex);
      _tasks.insert(newIndex, task);
    });
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Galería'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Cámara'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
