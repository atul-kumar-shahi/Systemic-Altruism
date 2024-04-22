import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:systematic_altruism/widgets/custom_button.dart';
import 'package:systematic_altruism/widgets/custom_snackbar.dart';
import 'package:systematic_altruism/image_upload_screen.dart';
import 'package:systematic_altruism/images_from_api.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CarouselSlider(
              items: [
                Image.asset('assets/images/first.png'),
                Image.asset('assets/images/second.png'),
                Image.asset('assets/images/third.png'),
              ],
              options: CarouselOptions(
                autoPlay: true,
                enableInfiniteScroll: true,
                viewportFraction: 1,
                aspectRatio: MediaQuery.of(context).size.width /
                    MediaQuery.of(context).size.height,
              )),
          const Positioned(
            bottom: 160,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'ElsieSwash'
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'FaceSearch',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 40,
                    color: Colors.white,
                      fontFamily: 'ElsieSwash'
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            bottom: 42,
            left: 40,
            right: 40,
            child: Text(
              'It allows you to pick images from your gallery,click Image using camera and upload them online.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'LibreCaslon'
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
              bottom: 90,
              left: 20,
              right: 20,
              child: CustomButton(onPressed: () {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const ImageUploadScreen()), (route) => false);
              },text: 'Get Started',)
          )
        ],
      ),
    );
  }
}
