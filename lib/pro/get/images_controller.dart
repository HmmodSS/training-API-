import 'package:get/get.dart';
import 'package:training_api/pro/api/controllers/images_api_controller.dart';
import '../api/api_response.dart';
import '../models/studentImage.dart';

class ImagesGetxController extends GetxController {
  RxBool loading = false.obs;
  RxList<StudentImage> images = <StudentImage>[].obs;
  final ImagesApiController _apiController = ImagesApiController();
  static ImagesGetxController get to => Get.find<ImagesGetxController>();
  //To initialize any thing in controller
  @override
  void onInit() {
    // TODO: implement onInit
    readImage();
    super.onInit();
  }

  Future<ApiResponse<StudentImage>> upload({required String path}) async {
    ApiResponse<StudentImage> apiResponse =
        await _apiController.upload(path: path);
    if (apiResponse.success && apiResponse.object != null) {
      images.add(apiResponse.object!);
    }
    return apiResponse;
  }

  void readImage() async {
    print("read Images");
    loading.value = true;
    images.value = await _apiController.readImages();
    loading.value = false;
  }

  Future<ApiResponse> deleteImage({required int index}) async {
    ApiResponse apiResponse =
        await _apiController.deleteImage(id: images[index].id);
    if (apiResponse.success) {
      images.removeAt(index);
    }
    return apiResponse;
  }
}
