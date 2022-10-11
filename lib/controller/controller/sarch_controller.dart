import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:wallpepper_app/controller/service/home_service.dart';
import 'package:wallpepper_app/model/home_model.dart';

class Searchcontroller extends GetxController{
  RxBool loading = true.obs;
  RxList<Photo> data =<Photo>[].obs;
  getSearchs(String query)async{
    
    try {
      data.value =(await HomeService.getSearch(query))!;
      loading.value=false;
      print("${data.value}=lllllll==data");
   print("${query}.................................");
    
      return data;
    }on DioError catch (e) {
       print("ksdfsjsfjksfjksf");
      print(e.error);
      print(e.message);
      print(e);
    }  catch (e) {
      loading.value=false;
       print("no q");
      print(e);
    }
  }
}