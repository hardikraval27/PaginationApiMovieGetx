import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../controller/controllers.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetX<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Scaffold(
            body: Stack(
              children: [
                NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo is UserScrollNotification) {
                      if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent) {
                        if ((controller.currentPage.value + 1) <
                            controller.totalPage.value) {
                          controller.currentPage.value =
                              controller.currentPage.value + 1;
                          controller.fetchdata();
                        }
                      }
                    }
                    return true;
                  },
                  child: controller.isLoading.value
                      ? SpinKitWave(
                          itemBuilder: (BuildContext context, int index) {
                            return DecoratedBox(
                              decoration: BoxDecoration(
                                color: index.isEven ? Colors.red : Colors.green,
                              ),
                            );
                          },
                        )
                      : ListView.builder(
                          itemCount: controller.movieList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: const EdgeInsets.only(top: 1),
                              color: Colors.deepPurple,
                              child: Row(
                                children: [
                                  Container(
                                    // decoration: BoxDecoration(
                                    //     borderRadius:
                                    //         BorderRadius.circular(50)),
                                    height: Get.height * 0.2,
                                    width: Get.width * 0.3,
                                    child: Image.network(
                                      "${controller.movieList[index].poster}",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  const SizedBox(width: 1),
                                  Expanded(
                                    child: Container(
                                      height: Get.height * 0.2,
                                      width: Get.width * 0.3,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${controller.movieList[index].movieTitle}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            "${controller.movieList[index].releaseDate}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white54),
                                          ),
                                          Text(
                                            "${controller.movieList[index].movieDuration}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
                Center(
                  child: controller.isPageLoading.value
                      ? SpinKitPianoWave(
                          itemBuilder: (BuildContext context, int index) {
                            return DecoratedBox(
                              decoration: BoxDecoration(
                                color: index.isEven ? Colors.red : Colors.green,
                              ),
                            );
                          },
                        )
                      : const SizedBox(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
