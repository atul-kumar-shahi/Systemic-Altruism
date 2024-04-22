import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:systematic_altruism/widgets/custom_button.dart';
import 'package:systematic_altruism/widgets/custom_snackbar.dart';
import 'package:systematic_altruism/images_from_api.dart';
import 'package:systematic_altruism/widgets/show_dialogbox.dart';

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({Key? key}) : super(key: key);

  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await _imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> uploadImage() async {
    if (_selectedImage == null) {
      showSnackbar(context, 'Please select an image');
      return;
    }

    var stream = http.ByteStream(_selectedImage!.openRead());
    var length = await _selectedImage!.length();

    var uri = Uri.parse('http://192.168.137.1:8000/api/create-post');
    var request = http.MultipartRequest('POST', uri);

    var multipartFile = http.MultipartFile(
      'image',
      stream,
      length,
      filename: _selectedImage!.path.split('/').last,
    );

    request.files.add(multipartFile);

    try {
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();
      print(responseBody);

      if (response.statusCode == 200) {
        showSnackbar(context, 'Image uploaded');
      } else {
        showSnackbar(context,
            'Failed to upload image. Status code: ${response.statusCode}');
      }
    } catch (e) {
      showSnackbar(context, 'Error uploading image');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 159, 132, 99),
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const ImageFromApi()),
            (route) => false,
          );
        },
        child: const Icon(
          Icons.arrow_forward_ios_outlined,
        ),
      ),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      showDialogBox(context);
                    },
                    icon: const Icon(Icons.help)),
                IconButton(
                    onPressed: () {
                      uploadImage();
                    },
                    icon: const Icon(Icons.upload)),
              ],
            ),
          )
        ],
        backgroundColor: const Color.fromARGB(255, 159, 132, 99),
        title: const Text('Upload Image'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _selectedImage != null
                ? Container(
                    padding: const EdgeInsets.all(10),
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: FileImage(File(_selectedImage!.path)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(
                    padding: const EdgeInsets.all(10),
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 227, 227, 227),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          size: 100,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            'Select Image from Gallery or Click some Images',
                            style: TextStyle(
                                fontFamily: 'LibreCaslon', fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    )),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  icon: Icons.camera_alt_rounded,
                  onPressed: () => _getImage(ImageSource.camera),
                  text: 'Camera',
                ),
                const SizedBox(width: 20),
                CustomButton(
                  icon: Icons.image,
                  onPressed: () => _getImage(ImageSource.gallery),
                  text: 'Gallery',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
