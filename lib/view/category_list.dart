import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpepper_app/controller/controller/categorycontroll.dart';
import 'package:wallpepper_app/controller/controller/home_controller.dart';
import 'package:wallpepper_app/controller/controller/sarch_controller.dart';
import 'package:wallpepper_app/controller/service/apikey.dart';
import 'package:wallpepper_app/view/fullsize.dart';
import 'package:wallpepper_app/view/styele/style.dart';
import 'package:http/http.dart' as http;

class SingleCategotis extends StatelessWidget {
  SingleCategotis({Key? key, required this.imgidex}) : super(key: key);
  int imgidex;

  List category = [];

  getCategorypic() async {
    final url = Uri.parse(
        'https://api.pexels.com/v1/search?per_page=100&query=${name[imgidex]}');
    var response = await http.get(url, headers: {"Authorization": apiKey});

    Map jsonData = jsonDecode(response.body);
    category = jsonData['photos'];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;
    return Scaffold(
      backgroundColor: black,
      appBar: AppBar(
        backgroundColor: black,
        centerTitle: true,
        title: Text(
          name[imgidex],
          style: GoogleFonts.montserrat(
              color: white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: FutureBuilder(
          future: getCategorypic(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: .03),
                child: GridView.builder(
                  itemCount: category.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 2 / 3,
                      crossAxisSpacing: width * .012,
                      mainAxisSpacing: height * .005),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * .02),
                          //  color: gold,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                category[index]['src']['portrait']),
                          ),
                        ),
                      ),
                      onTap: () {
                        Get.to(FullSize(
                            index: index,
                            imagepath: category[index]['src']['portrait'],
                            category: category));
                      },
                    );
                  },
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CupertinoActivityIndicator(
                  animating: true,
                  color: Colors.grey,
                  radius: 25,
                ),
              );
            }
            return Container(
              height: 70,
              color: Colors.red,
            );
          }),
    );
  }
}
