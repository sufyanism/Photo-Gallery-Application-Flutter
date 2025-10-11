import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:landmark_gallary/controllers/gallery_controller.dart';

class SlideshowMode extends StatefulWidget {
  const SlideshowMode({super.key});

  @override
  State<SlideshowMode> createState() => _SlideshowModeState();
}

class _SlideshowModeState extends State<SlideshowMode> {
  final GalleryController controller = Get.find();
  late PageController _pageController;
  Timer? _timer;
  int _index = 0;

  @override
  void initState(){
    _pageController = PageController();

    _timer = Timer.periodic(const Duration(seconds: 3), (timer){
      if(_index <controller.filteredLandmarks.length-1) {
        _index ++;
        _pageController.animateToPage(
          _index,
          duration: const Duration(seconds: 3),
          curve: Curves.easeInOut,
        );
      }else{
        timer.cancel();
      }
    });
  }

  @override
  void dispose(){
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Slide Show',
          style: TextStyle(
            color: Colors.white
          ),
        ),
      leading: IconButton(onPressed: (){
        Get.back();
      }, icon: Icon(Icons.arrow_back_ios_new,
        color: Colors.white,
      )),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: controller.filteredLandmarks.length,
          itemBuilder: (context,index){
          final landmark = controller.filteredLandmarks[index];

          return Stack(
            fit: StackFit.expand,
            children: [
              Image.network(landmark.imageUrl,fit: BoxFit.cover,),
              Positioned(
                bottom: 20,
                left: 30,
                right: 30,
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        landmark.name,
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        landmark.location,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
      }),
    );
  }
}
