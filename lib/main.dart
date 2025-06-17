
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recce App',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: RecceForm(),
    );
  }
}

class RecceForm extends StatefulWidget {
  @override
  _RecceFormState createState() => _RecceFormState();
}

class _RecceFormState extends State<RecceForm> {
  final picker = ImagePicker();
  int _imageCount = 1;

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final boardTypeController = TextEditingController();
  final widthController = TextEditingController();
  final heightController = TextEditingController();
  final qtyController = TextEditingController();
  final remarksController = TextEditingController();

  Future<void> _takePhoto() async {
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      final dir = await getApplicationDocumentsDirectory();
      final filename = 'IMG\${_imageCount.toString().padLeft(3, '0')}.jpg';
      final newPath = '\${dir.path}/\$filename';
      await File(photo.path).copy(newPath);
      setState(() => _imageCount++);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saved: \$filename')),
      );
    }
  }

  Widget _buildField(String label, TextEditingController controller, {TextInputType? type}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recce Entry')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _buildField("Retailer's Name", nameController),
            _buildField("Address", addressController),
            _buildField("Mobile No", phoneController, type: TextInputType.phone),
            _buildField("Board Type", boardTypeController),
            _buildField("Width (ft)", widthController, type: TextInputType.number),
            _buildField("Height (ft)", heightController, type: TextInputType.number),
            _buildField("Qty", qtyController, type: TextInputType.number),
            _buildField("Remarks", remarksController),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.camera_alt),
              label: Text('Take Photo'),
              onPressed: _takePhoto,
            ),
          ],
        ),
      ),
    );
  }
}
