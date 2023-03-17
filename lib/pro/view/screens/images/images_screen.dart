import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:training_api/pro/get/images_controller.dart';

class ImagesScreen extends StatefulWidget {
  const ImagesScreen({Key? key}) : super(key: key);

  @override
  State<ImagesScreen> createState() => _ImagesScreenState();
}

class _ImagesScreenState extends State<ImagesScreen> {
  ImagesGetxController controller =
      Get.put<ImagesGetxController>(ImagesGetxController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          actions: [
            IconButton(
                onPressed: () {
                  Get.toNamed('/upload_image_screen');
                },
                icon: const Icon(Icons.camera))
          ],
          title: const Text("Images"),
        ),
        body: GetX<ImagesGetxController>(
            builder: (ImagesGetxController controller) {
          if (controller.loading.isTrue) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (controller.images.isNotEmpty) {
            return ListView.builder(
                itemCount: controller.images.length,
                itemBuilder: (context, index) {
                  return Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: Image.network(controller.images[index].imageUrl));
                });
          }
          return CarouselSlider(
            options: CarouselOptions(height: 800),
            items: [
              'images/api.png',
              'images/api.png',
            ].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(color: Colors.grey),
                      child: Image.asset(
                        "$i",
                      ));
                },
              );
            }).toList(),
          );
        }));
  }
}



// Card(
//               clipBehavior: Clip.antiAlias,
//               elevation: 5,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10)),
//               child: Image.asset('images/api.png'))