import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class MyWallet extends StatefulWidget {
  const MyWallet({Key? key}) : super(key: key);

  @override
  State<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  double amount = 400.25;
  File? selectedPhoto;

  Future<void> _selectPhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        selectedPhoto = File(pickedFile.path);
      });
      await uploadPhoto(selectedPhoto!);
    }
  }

  Future<void> uploadPhoto(File photo) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('https://bipixapi.cyclic.app/upload'));
    request.files.add(await http.MultipartFile.fromPath('photo', photo.path));

    try {
      var response = await request.send();
      if (response.statusCode == 201) {
        // A foto foi enviada com sucesso
        if (kDebugMode) {
          print('Foto enviada com sucesso');
        }
      } else {
        // Houve um erro ao enviar a foto
        if (kDebugMode) {
          print('Erro ao enviar a foto');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao enviar a foto: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          Container(
            constraints: const BoxConstraints(minWidth: 100, maxWidth: 240),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Meu saldo",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF373737),
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "\$ $amount",
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF373737),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Recarrega grátis",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.amber.shade300,
                          blurRadius: 9,
                          spreadRadius: 10),
                    ],
                    color: Colors.amber.shade500,
                  ),
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset('assets/images/recarregar.png'),
                  ),
                )
                    .animate(onPlay: (controller) => controller.repeat())
                    .scaleXY(
                        begin: 0.9,
                        end: 1,
                        duration: 1000.ms,
                        curve: Curves.easeInOut)
                    .then()
                    .scaleXY(
                        begin: 1,
                        end: 0.9,
                        duration: 1500.ms,
                        curve: Curves.easeInOut),
                const SizedBox(height: 10),
                const Text("Toque para assistir")
                    .animate(onPlay: (controller) => controller.repeat())
                    .fadeIn(begin: 0.5, duration: 1000.ms, curve: Curves.easeIn)
                    .then()
                    .fadeOut(duration: 700.ms, curve: Curves.easeOut),
                const SizedBox(height: 10),
                const Text(
                  "Ganhe + \$ 1.00",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                const SizedBox(height: 10),
                const Text(
                    "Quando você assiste um anúncio, você ajuda a Bipix continuar Grátis."),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
