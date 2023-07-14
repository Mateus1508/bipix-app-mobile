import 'dart:convert';
import 'dart:io';
import 'package:bipixapp/services/webservice.dart';
import 'package:bipixapp/widgets/profileWidget/profile_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../services/ad_helper.dart';
import '../services/api.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  double amount = 400.25;
  File? selectedPhoto;

  Stream<Map<String, dynamic>> getStream() async* {
    await for (DocumentSnapshot<Map<String, dynamic>> doc in FirebaseFirestore
        .instance
        .collection("users")
        .doc((await Webservice.getUserId()))
        .snapshots()) {
      yield doc.data()!;
    }
  }

  Future<String> getUserName(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/idusers/$userId'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['username'];
    } else {
      throw Exception('Erro ao recuperar o usuário');
    }
  }

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




void _shareProfile() async {
  final String username = await getUserId();
  final String profileUrl = '$baseUrl/profile?username=$username&phrase=$phrase';

  Share.share(profileUrl);
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

  Future<void> fetchUsername(String userId) async {
    if (kDebugMode) {
      print('Fetching username for user: $userId');
    }

    final response = await http.get(Uri.parse('$baseUrl/idusers/$userId'));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      setState(() {
        username = jsonData['username'];
        phrase = jsonData['favorite_phrase'];
      });
      if (kDebugMode) {
        print('Username fetched successfully: $username');
      }
    } else {
      // Se a chamada à API falhar, definimos o username como '@bipix.user'
      if (kDebugMode) {
        print('API call failed. Status code: ${response.statusCode}');
      }
      setState(() {
        username = '@bipix.user';
        phrase = "a vida e feita de desafios e eu estou preparada para vencer";
      });
      throw Exception('Falha ao carregar o nome do usuário');
    }
  }

  Future<String> getUserId() async {
    return Webservice.getUserId();
  }

  String username = 'Carregando...';
  String phrase = 'Carregando...';

  @override
  void initState() {
    _createBottomBannerAd();
    super.initState();
    getUserId().then((userId) {
      fetchUsername(userId);
    }).catchError((error) {
      if (kDebugMode) {
        print('Error in initState: $error');
      }
    });
  }

  bool _isBottomBannerAdLoaded = false;

  late BannerAd _bottomBannerAd;

  void _createBottomBannerAd() {
    RequestConfiguration configuration = RequestConfiguration(
      testDeviceIds: ["B344A2E6F1812DD05F37ADBEB20D4D89"],
    );
    MobileAds mobileAds = MobileAds.instance;
    mobileAds.updateRequestConfiguration(configuration);
    _bottomBannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isBottomBannerAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          print(ad);
          print(error);
          ad.dispose();
        },
      ),
    );
    _bottomBannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ProfileBar(),
      bottomNavigationBar: _isBottomBannerAdLoaded
          ? SizedBox(
              height: _bottomBannerAd.size.height.toDouble(),
              width: _bottomBannerAd.size.width.toDouble(),
              child: AdWidget(
                ad: _bottomBannerAd,
              ),
            )
          : null,
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
                              child: StreamBuilder<Map<String, dynamic>>(
                                stream: getStream(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return Image.asset(
                                      'assets/images/bipixLogo.png',
                                    );
                                  }
                                  if (snapshot.data!["photo"] == null) {
                                    return Image.asset(
                                      'assets/images/bipixLogo.png',
                                    );
                                  }
                                  Uint8List photo =
                                      base64Decode(snapshot.data!["photo"]);

                                  return Image.memory(
                                    photo,
                                    fit: BoxFit.fill,
                                  );
                                },
                              ),
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
                      children: [
                        const Text(
                          "Bipix",
                          style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF373737),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "@$username",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF373737)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                         '"$phrase"',
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
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/editprofile');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          color: const Color(0XFF0472E8),
                          borderRadius: BorderRadius.circular(5)),
                      child: const Text(
                        'Editar perfil',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed:  _shareProfile,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                          color: const Color(0XFF0472E8),
                          borderRadius: BorderRadius.circular(5)),
                      child: const Text(
                        'Compartilhar perfil',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
