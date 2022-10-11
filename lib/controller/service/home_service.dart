
import 'package:dio/dio.dart';
import 'package:wallpepper_app/model/home_model.dart';

class HomeService {

  //home screen================================================
  static Future<List<Photo>?> getHome() async {
    try {
      var response = await Dio().get(
        'https://api.pexels.com/v1/curated?per_page=20',
        options: Options(
          headers: {
            "Authorization":
                "563492ad6f91700001000001499aff3b326c4f53b3994122e3706067"
          },
        ),
      );
      HomeModel homeModel = HomeModel.fromJson(response.data);
      return homeModel.photos!;
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

//search===============================================================
   static Future<List<Photo>?> getSearch(String query) async {
    try {
      var response = await Dio().get(
        'https://api.pexels.com/v1/search?query=$query&per_page=100',
        options: Options(
          headers: {

        

            "Authorization":
                "563492ad6f91700001000001499aff3b326c4f53b3994122e3706067"
          },
        ),
      );
      HomeModel homeModel = HomeModel.fromJson(response.data);
       print("${query}---------------------------------/////////");
       print(response.data);
      return homeModel.photos!;
    } on DioError catch (e) {
      print(e.message);
      print(e.response?.data);
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }
}
