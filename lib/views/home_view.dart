import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:landmark_gallary/controllers/gallery_controller.dart';
import 'package:landmark_gallary/views/widget/slideshow_mode.dart';

import 'detail.view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    
    final GalleryController controller = Get.put(GalleryController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Landmark Gallery',style:
          TextStyle(
            color: Colors.white
          ),),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
              onPressed: ()
          {
            Get.to(() =>  SlideshowMode());
          },
              icon: Icon(Icons.slideshow,
                color: Colors.black,
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search landmarks....',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value){
                controller.searchQuery.value = value;
                controller.applyFilters();
              },
            ),
            DropdownButton<String>(
            items: ['All','Historical','Modern','Natural'].map((category){
              return DropdownMenuItem(
                value: category,
                  child: Text(category),
              );
            }).toList(),
            onChanged: (value){
              controller.selectedCategory.value = value!;
              controller.applyFilters();
            }),
            Expanded(
              child: Obx(()
                 {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: controller.filteredLandmarks.length,
                        itemBuilder: (context , index){
                          final landmark = controller.filteredLandmarks[index];
                          return GestureDetector(
                            onTap: (){
                              Get.to(() => DetailView(landmark: landmark));
                            },
                            child: Hero(
                                tag: landmark.name,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(landmark.imageUrl,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        gradient: LinearGradient(
                                            colors: [
                                              Colors.black,
                                              Colors.transparent
                                            ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 10,
                                        left: 10,
                                        child: Text(
                                            landmark.name,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ))
                                  ],
                                )),
                          );
                        }),
                  );
                }
              ),
            ),
          ],
        ),
      )
    );
  }
}
