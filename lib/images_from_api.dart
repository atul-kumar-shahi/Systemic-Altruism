import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:systematic_altruism/image_upload_screen.dart';
import 'package:systematic_altruism/widgets/custom_button.dart';
import 'package:systematic_altruism/widgets/custom_snackbar.dart';
import 'package:systematic_altruism/widgets/show_dialogbox.dart';

class ImageFromApi extends StatefulWidget {
  const ImageFromApi({Key? key}) : super(key: key);

  @override
  State<ImageFromApi> createState() => _ImageFromApiState();
}

class _ImageFromApiState extends State<ImageFromApi> {
  List<String> images = [];
  int currentIndex = 0;
  late Timer timer;

  @override
  void initState() {
    fetchApi();
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  Future<void> fetchApi() async {
    try {
      final res = await http.get(
        Uri.parse('http://192.168.137.1:8000/api/get-post'),
      );
      if (res.statusCode == 200) {
        final result = await jsonDecode(res.body);
        List<dynamic> msgList = result['msg'];
        List<String> imageURLs = [];
        for (var msg in msgList) {
          String imageURL =
              'http://192.168.137.1:8000/images/${msg['imageurl']}';
          imageURLs.add(imageURL);
        }
        setState(() {
          images = imageURLs;
          print(images);
        });
      } else {
        showSnackbar(context, 'Please wait while we do our work');
      }
    } catch (e) {
      showSnackbar(context, 'Something went wrong, restart again');
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % images.length;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    showDialogBox(context);
                  },
                  icon: const Icon(Icons.help),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ImageUploadScreen()),
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.add_a_photo),
                ),
              ],
            ),
          )
        ],
        backgroundColor: const Color.fromARGB(255, 159, 132, 99),
        title: const Text('Images'),
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to FaceSearch',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'ElsieSwash',
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Browse through images posted by you till now, let the show begin 🙂',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'LibreCaslon',
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              height: 350,
              width: 350,
              child: ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: BorderRadius.circular(10),
                child: (images.isNotEmpty)
                    ? FadeInImage(
                        placeholder:
                            const AssetImage('assets/images/placeholder.jpeg'),
                        image: NetworkImage(images[currentIndex]),
                        fit: BoxFit.cover,
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
            ),
            const SizedBox(height: 40),
            CustomButton(
              onPressed: () {},
              text: 'Explore More',
              icon: Icons.explore_sharp,
            )
          ],
        ),
      ),
    );
  }
}
