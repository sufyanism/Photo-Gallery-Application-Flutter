import 'package:flutter/material.dart';
import 'package:landmark_gallary/controllers/gallery_controller.dart';
import '../models/landmark_model.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import 'map_view.dart';

class DetailView extends StatelessWidget {
  final Landmark landmark;
  const DetailView({super.key, required this.landmark});

  @override
  Widget build(BuildContext context) {
    final GalleryController controller = Get.put(GalleryController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: IconButton(onPressed: ()=> Get.back(),
            icon: Icon(Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
        actions: [

          IconButton(onPressed: (){
            controller.toggleFavourite(landmark);
          }, icon: Obx(() => Icon(
            color: Colors.red,
              controller.favourites.contains(landmark)? Icons.favorite: Icons.favorite_border))),
          IconButton(onPressed: (){
            Get.to(() => MapViewScreen(landmark: landmark,));
          },
              icon: Icon(Icons.map,
              color: Colors.white,
              size: 30,
              )),

          IconButton(onPressed: (){
            Share.share('Check out this landmark: ${landmark.name} - ${landmark.imageUrl}');
          }, icon: Icon(Icons.share,
            color: Colors.white,
          ))
        ],
      ),
      body: Stack(
        children: [
          Hero(
              tag: landmark.name,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.network(landmark.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
          ),
          Positioned(
            bottom: 30,
              left: 20,
              right: 20,
              child: Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(landmark.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Text(
                      landmark.location,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      landmark.description,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    )
                  ],
                ),
              )
          )

        ],
      ),
    );
  }
}
