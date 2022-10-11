import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:wallpepper_app/controller/service/home_service.dart';
import 'package:wallpepper_app/model/home_model.dart';

class HomeController extends GetxController{
List <Photo>home=[] ;
RxBool loding =true.obs;
  Future<List<Photo>?>gethomes()async{
    
    try {
      var data =await HomeService.getHome();
      print("${data}===data");
      loding.value=false;
    
      return data;
    }on DioError catch (e) {
        loding.value=false;
      print(e.error);
      print(e.message);
      print(e);
    }  catch (e) {
       loding.value=false;
      print(e);
    }
  }


  
  @override
  void onInit() {
    gethomes().then((value) =>home  =value!);
    super.onInit();
  }

}