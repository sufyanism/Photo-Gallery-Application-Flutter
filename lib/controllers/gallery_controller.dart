import 'package:get/get.dart';
import 'package:landmark_gallary/models/landmark_model.dart';

class GalleryController extends GetxController {
  var landmarks = <Landmark>[].obs;
  var filteredLandmarks = <Landmark>[].obs;
  var searchQuery = "".obs;
  var selectedCategory = 'All'.obs;
  var favourites = <Landmark>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadLandmarks();
    filteredLandmarks.value = landmarks;
  }

  void loadLandmarks() {
    landmarks.addAll([
      Landmark(
        name: 'Eiffel Tower',
        location: 'Paris France',
        description: 'An iconic iron lattice tower built in 1889',
        imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/a/a8/Tour_Eiffel_Wikimedia_Commons.jpg',
        category: 'Historical',
        latitude: 48.8584,
        longitude: 2.2945,
      ),
      Landmark(
        name: 'Taj Mahal',
        location: 'Agra India',
        description: 'A mausoleum built by Mughal emperor Shah Jahan',
        imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/d/da/Taj-Mahal.jpg',
        category: 'Historical',
        latitude: 27.1751,
        longitude: 78.0421,
      ),
      Landmark(
        name: 'Great Wall of China',
        location: 'China',
        description: 'A series of fortifications built along ancient Chinese territories',
        imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/1/10/20090529_Great_Wall_8185.jpg',
        category: 'Historical',
        latitude: 40.4319,
        longitude: 116.5704,
      ),
      Landmark(
        name: 'Statue of Liberty',
        location: 'New York City, USA',
        description: 'A colossal neoclassical sculpture gifted by France',
        imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/a/a1/Statue_of_Liberty_7.jpg',
        category: 'Monument',
        latitude: 40.6892,
        longitude: -74.0445
      ),
      Landmark(
        name: 'Machu Picchu',
        location: 'Cusco Region, Peru',
        description: 'An Incan citadel set high in the Andes Mountains',
        imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/e/eb/Machu_Picchu%2C_Peru.jpg',
        category: 'Historical',
        latitude: -13.1631,
        longitude: -72.5450,
      ),
    ]);
  }

  void applyFilters(){
    filteredLandmarks.value = landmarks.where((landmark){
      final matchesCategory = selectedCategory.value == 'All' || landmark.category ==
       selectedCategory.value;

      final matchesSearch =
          landmark.name.toLowerCase().contains(searchQuery.value.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  void toggleFavourite(Landmark landmark ){
    if(favourites.contains(landmark)){
      favourites.remove(landmark);
    }else{
      favourites.add(landmark);
    }
  }

}
