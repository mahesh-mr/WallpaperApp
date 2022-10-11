import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpepper_app/view/styele/style.dart';

class FullSize extends StatelessWidget {
  FullSize({
    Key? key,
    required this.index,
    required this.imagepath,
    required this.category,
  }) : super(key: key);
  int index;
  String imagepath;
  List category;

  Future<void> setWallpapper(int location) async {
    var file = await DefaultCacheManager().getSingleFile(imagepath);
    await WallpaperManager.setWallpaperFromFile(file.path, location);
  }

  downloadImagae() async {
    var file = await DefaultCacheManager().getSingleFile(imagepath);
    GallerySaver.saveImage(file.path, albumName: "WallHub");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
        image:
            DecorationImage(image: NetworkImage(imagepath), fit: BoxFit.cover),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: 250,
                        color: black,
                        child: Column(
                          children: [
                            ListTile(
                              leading: Icon(
                                Icons.screen_lock_portrait,
                                color: white,
                              ),
                              title: Text(
                                'Home Screen',
                                style: GoogleFonts.montserrat(
                                    color: white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                Get.back();
                                setWallpapper(WallpaperManager.HOME_SCREEN);
                              },
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.add_to_home_screen,
                                color: white,
                              ),
                              title: Text(
                                'Lock Screen',
                                style: GoogleFonts.montserrat(
                                    color: white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                setWallpapper(WallpaperManager.LOCK_SCREEN);
                                Get.back();
                              },
                            ),
                            ListTile(
                              leading: Icon(
                                Icons.phone_android_sharp,
                                color: white,
                              ),
                              title: Text(
                                'Home screen and lock Screen',
                                style: GoogleFonts.montserrat(
                                    color: white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                setWallpapper(WallpaperManager.BOTH_SCREEN);
                                Get.back();
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.download),
                              iconColor: white,
                              title: Text(
                                'Download',
                                style: GoogleFonts.montserrat(
                                    color: white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                downloadImagae();
                                Get.back();
                              },
                            ),
                          ],
                        ),
                      );
                    });
              },
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color.fromARGB(255, 0, 8, 0).withOpacity(0.5),
                      border: Border.all(color: white)),
                  child: Center(
                    child: Text(
                      "Set Wallpapper",
                      style: GoogleFonts.montserrat(
                          color: white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
