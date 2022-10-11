import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpepper_app/controller/controller/categorycontroll.dart';
import 'package:wallpepper_app/controller/controller/home_controller.dart';
import 'package:wallpepper_app/controller/controller/sarch_controller.dart';
import 'package:wallpepper_app/view/category_list.dart';
import 'package:wallpepper_app/view/fullsize.dart';
import 'package:wallpepper_app/view/styele/style.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  TextEditingController seachcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    Searchcontroller searchcontroller = Get.put(Searchcontroller());

    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        centerTitle: true,
        title: Text(
          "Wall Hub",
          style: GoogleFonts.montserrat(
              color: white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CupertinoSearchTextField(
            controller: seachcontroller,
            onChanged: (value) {
              searchcontroller.getSearchs(value);
            },
            backgroundColor: Colors.grey.withOpacity(.3),
            style: const TextStyle(color: grey),
            prefixIcon: const Icon(CupertinoIcons.search, color: grey),
            suffixIcon: const Icon(
              CupertinoIcons.xmark_circle_fill,
              color: grey,
            ),
          ),
        ),
        SizedBox(
          height: width * .01,
        ),
        LimitedBox(
          maxHeight: width * .3,
          child: ListView.builder(
            shrinkWrap: true,
            //  physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: name.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(width * .01),
                child: GestureDetector(
                  onTap: () {
                    Get.to(SingleCategotis(
                      imgidex: index,
                    ));
                  },
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(pic[index]),
                        radius: width * .1,
                      ),
                      SizedBox(
                        height: width * .01,
                      ),
                      Text(
                        name[index],
                        style: GoogleFonts.montserrat(
                            color: white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: seachcontroller.text.isNotEmpty
              ? Search(
                  searchcontroller: searchcontroller,
                  width: width,
                  height: height,
                  homeController: homeController)
              : Obx(() {
                  if (homeController.loding.value) {
                    return const Center(
                child: CupertinoActivityIndicator(
                  animating: true,
                  color: Colors.grey,
                  radius: 25,
                ),
              );
                  }
                  return GridviewScreen(
                      homeController: homeController,
                      width: width,
                      height: height);
                }),
        ),
      ]),
    );
  }
}

class Search extends StatelessWidget {
  const Search({
    Key? key,
    required this.searchcontroller,
    required this.width,
    required this.height,
    required this.homeController,
  }) : super(key: key);

  final Searchcontroller searchcontroller;
  final double width;
  final double height;
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (searchcontroller.loading.value) {
        return const Center(
                child: CupertinoActivityIndicator(
                  animating: true,
                  color: Colors.grey,
                  radius: 25,
                ),
              );
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: .03),
        child: GridView.builder(
            itemCount: searchcontroller.data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: width * .012,
                mainAxisSpacing: height * .005),
            itemBuilder: (context, index) {
              final data = searchcontroller.data.value[index];
              print(homeController.home.length);
              return GestureDetector(
                onTap: () {
                  Get.to(
                    FullSize(
                      index: index,
                      imagepath: data.src!.portrait!,
                      category: [],
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        data.src!.portrait!,
                      ),
                    ),
                  ),
                ),
              );
            }),
      );
    });
  }
}

class GridviewScreen extends StatelessWidget {
  const GridviewScreen({
    Key? key,
    required this.homeController,
    required this.width,
    required this.height,
  }) : super(key: key);

  final HomeController homeController;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: .03),
      child: GridView.builder(
          itemCount: homeController.home.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2 / 3,
              crossAxisSpacing: width * .012,
              mainAxisSpacing: height * .005),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(FullSize(
                    index: index,
                    imagepath: homeController.home[index].src!.portrait!,
                    category: []));
              },
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      homeController.home[index].src!.large!,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
