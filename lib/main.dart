import 'package:flutter/material.dart';

void main() {
  runApp(RecceApp());
}

class RecceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recce App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: RecceHome(),
    );
  }
}

class RecceHome extends StatefulWidget {
  @override
  _RecceHomeState createState() => _RecceHomeState();
}

class _RecceHomeState extends State<RecceHome> {
  final _retailerNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Retailer Recce')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _retailerNameController,
              decoration: InputDecoration(labelText: "Retailer's Name"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Photo Captured & Saved')),
                );
              },
              child: Text('Capture Photo'),
            ),
          ],
        ),
      ),
    );
  }
}
