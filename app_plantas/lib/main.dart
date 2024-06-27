import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';

void main() => runApp(const WhatIsThePlantApp());

class WhatIsThePlantApp extends StatelessWidget {
  const WhatIsThePlantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'What is the plant?',
      theme: ThemeData(
        primaryColor: const Color(0xFF34C759), // Cor verde claro
        scaffoldBackgroundColor: const Color(0xFFF7F7F7), // Cor de fundo claro
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF34C759), // Cor verde claro
          secondary: const Color(0xFF8BC34A), // Cor verde escuro
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('What is the plant?'),
        elevation: 0, // Remover sombra da barra de navegação
        backgroundColor: Theme.of(context).colorScheme.primary, // Cor verde claro
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bem-vindo ao What is the plant?',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary, // Cor verde escuro
                    fontWeight: FontWeight.bold,
                  ) ??
                  const TextStyle(), // Valor padrão caso seja nulo
            ),
            const SizedBox(height: 20), // Espaçamento entre os elementos
            Text(
              'Descubra a espécie de qualquer planta utilizando sua câmera!',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[700], // Cor de texto cinza
                  ) ??
                  const TextStyle(), // Valor padrão caso seja nulo
            ),
            const SizedBox(height: 40), // Espaçamento entre os elementos
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CameraScreen()),
                );
              },
              child: const Text('Ir para a câmera'),
            ),
          ],
        ),
      ),
    );
  }
}

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Câmera'),
        backgroundColor: Theme.of(context).colorScheme.primary, // Cor verde claro
      ),
      body: Center(
        child: Text(
          'Aqui você pode usar a câmera para tirar uma foto da planta!',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}

class _CameraScreenController extends State<CameraScreen> {
  File? _image;

  Future<void> _takePicture() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (image != null) {
        _image = File(image.path);
      } else {
        _image = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Câmera'),
        backgroundColor: Theme.of(context).colorScheme.primary, // Cor verde claro
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null
                ? Image.file(_image!)
                : const Text('Nenhuma imagem selecionada'),
            ElevatedButton(
              onPressed: _takePicture,
              child: const Text('Tirar uma foto'),
            ),
          ],
        ),
      ),
    );
  }
}
