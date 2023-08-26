import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/model_movie.dart';

class HomeController extends GetxController {
  var movieList = <mymovie>[].obs;
  var isLoading = true.obs;
  var isPageLoading = false.obs;
  var currentPage = 0.obs;
  var totalPage = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    isLoading.value = true;
    fetchdata();
  }

  Future<void> fetchdata() async {
    isPageLoading.value = true;
    final response = await http.get(Uri.parse(
        "https://application.cubeeplex.club/api/getAllData?type=movies&sub_type=latest&page=${currentPage.value}&genre=12"));
    final responsed = jsonDecode(response.body);

    if (response.statusCode == 200) {
      print(responsed['data']['data']);
      movieList.addAll(List.from(responsed['data']['data'])
          .map<mymovie>((e) => mymovie.fromJson(e))
          .toList());

      totalPage.value = responsed["data"]['total'];
      print(responsed);
      isPageLoading.value = false;
      isLoading.value = false;
      update();
    } else {
      Get.snackbar('Error Loading data!',
          'Server responsed:${response.statusCode}:${response.reasonPhrase.toString()}');
    }
  }
}
