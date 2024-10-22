import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Asegúrate de tener el paquete para SharedPreferences

class ProfileScreen extends StatefulWidget {
  final Function(int) changeTheme; // Función para cambiar el tema
  final Function(String) changeFont; // Función para cambiar la fuente
  //const ProfileScreen({Key? key}) : super(key: key);
  ProfileScreen({required this.changeTheme, required this.changeFont});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  // Controladores
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _githubController = TextEditingController();
  final TextEditingController _taskController = TextEditingController();

  String _selectedStatus = 'Disponible';
  final List<String> _statusOptions = ['Disponible', 'Ocupado', 'No Molestar', 'Ausente'];

  final List<String> _tasks = [];
  // Lista de opciones de fuentes disponibles
  List<String> fonts = ['Roboto', 'Lato', 'Montserrat', 'Pacifico'];
  String selectedFont = 'Roboto'; // Fuente seleccionada por defecto
  int themeIndex = 0; // Índice del tema por defecto

  @override
  void initState() {
    super.initState();
    //_loadPreferences();
  }

  /*Future<void> _loadPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      themeIndex = prefs.getInt('themeIndex') ?? 0; // Cargar el índice del tema
      selectedFont = prefs.getString('selectedFont') ?? 'Roboto'; // Cargar la fuente
    });
  }

  Future<void> _savePreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeIndex', themeIndex);
    await prefs.setString('selectedFont', selectedFont);
  }*/

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

//metodo para el tema y letra
  void _showThemeAndFontDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Configuración"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Text("Selecciona el tema:"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FloatingActionButton(
                     onPressed: () => widget.changeTheme(0), // Tema claro
                      backgroundColor: Colors.blue,
                      child: const Icon(Icons.light_mode, color: Colors.white),
                    ),
                    FloatingActionButton(
                      onPressed: () => widget.changeTheme(1), // Tema oscuro
                      backgroundColor: Colors.black87,
                      child: const Icon(Icons.dark_mode, color: Colors.white),
                    ),
                    FloatingActionButton(
                      onPressed: () => widget.changeTheme(2), // Tema personalizado
                      backgroundColor: Colors.orange,
                      child: const Icon(Icons.local_fire_department, color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text("Selecciona la fuente:"),
                DropdownButton<String>(
                  value: selectedFont,
                  icon: const Icon(Icons.arrow_downward),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedFont = newValue!;
                     // _savePreferences(); // Guardar preferencia
                    });
                  },
                  items: ['Roboto', 'Lato', 'Montserrat', 'Pacifico'].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Cerrar"),
            ),
          ],
        );
      },
    );
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
            const SizedBox(height: 20),
            /*ElevatedButton(
              onPressed: () => _showThemeAndFontDialog(context), // Abre el modal
              child: Text("Configuración de Tema y Fuente"),
            ),*/
            // Botones para seleccionar temas (claro, oscuro, personalizado)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      onPressed: () => widget.changeTheme(0), // Tema claro
                      backgroundColor: Colors.blue,
                      child: const Icon(Icons.light_mode, color: Colors.white),
                    ),
                    SizedBox(width: 20),
                    FloatingActionButton(
                      onPressed: () => widget.changeTheme(1), // Tema oscuro
                      backgroundColor: Colors.black87,
                      child: const Icon(Icons.dark_mode, color: Colors.white),
                    ),
                    SizedBox(width: 20),
                    FloatingActionButton(
                      onPressed: () => widget.changeTheme(2), // Tema personalizado
                      backgroundColor: Colors.orange,
                      child: const Icon(Icons.local_fire_department, color: Colors.white),
                    ),
                  ],
                ),
                Text(
                  "Selecciona la fuente", // Título de la sección de fuentes
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),

                // Dropdown para seleccionar una fuente
                DropdownButton<String>(
                  value: selectedFont, // Fuente seleccionada por defecto
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.grey),
                  underline: Container(
                    height: 2,
                    color: Colors.blue,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedFont = newValue!; // Actualiza la fuente seleccionada
                      widget.changeFont(selectedFont); // Cambia la fuente global
                    });
                  },
                  items: fonts.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value), // Texto de la fuente en el dropdown
                    );
                  }).toList(),
                ),
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
              icon: Icon(Icons.arrow_forward),
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
            const Icon(Icons.stairs, color: Colors.deepPurple),
            const SizedBox(width: 10),
            Expanded(
              child: DropdownButton<String>(
                value: _selectedStatus,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedStatus = newValue!;
                  });
                },
                items: _statusOptions
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskSection() {
    return Column(
      children: [
        TextField(
          controller: _taskController,
          decoration: InputDecoration(
            labelText: "Agregar tarea",
            suffixIcon: IconButton(
              icon: const Icon(Icons.add),
              onPressed: _addTask,
            ),
          ),
        ),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _tasks.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_tasks[index]),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    _tasks.removeAt(index);
                  });
                },
              ),
            );
          },
        ),
      ],
    );
  }

  void _showImageSourceActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Selecciona una fuente de imagen",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text("Cámara"),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text("Galería"),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
