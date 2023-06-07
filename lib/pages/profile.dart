import 'dart:io';
import 'package:bipixapp/services/webservice.dart';
import 'package:bipixapp/widgets/profileWidget/profile_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../services/api.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/upload'));
    request.files.add(await http.MultipartFile.fromPath('photo', photo.path));
    request.fields["userId"] = await Webservice.getUserId();

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
    return Scaffold(
      appBar: const ProfileBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _selectPhoto,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0XFF0472E8),
                                  blurRadius: 2,
                                  spreadRadius: 5),
                            ],
                            color: Color(0xFF454545),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: SizedBox(
                              width: 250,
                              height: 250,
                              child: selectedPhoto != null
                                  ? Image.file(
                                      selectedPhoto!,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.asset('assets/images/bipixLogo.png'),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: const Color(0xFF454545),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Text(
                            "Editar foto",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    constraints:
                        const BoxConstraints(minWidth: 100, maxWidth: 200),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "Bipix",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF373737),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "@bipix.user",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF373737)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '“A vida é feita de desafios, eu estou preparada."',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF373737),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {}, child: const Text('Editar perfil')),
                  const SizedBox(width: 10),
                  ElevatedButton(
                      onPressed: () {},
                      child: const Text('Compartilhar perfil')),
                  const SizedBox(width: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
