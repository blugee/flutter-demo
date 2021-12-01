import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class AccountController extends GetxController {
  File image;
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;
  final picker = ImagePicker();
  String imagePath;
  // final accDetailStorage = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  getImageFromGallery(ImageSource) async {
    final pickedImage = await picker.pickImage(
      source: ImageSource,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedImage != null) {
      if (!GetUtils.isImage(pickedImage.path)) {
        // errorSnackbar('Invalid Image type');
      }
      selectedImagePath.value = pickedImage.path;
      selectedImageSize.value =
          ((File(pickedImage.path)).lengthSync() / 1024 / 1024)
                  .toStringAsFixed(2) +
              'MB';
      print(selectedImageSize.value);
      // uploadFileToServer(); //API CALL FOR UPLOADING PROFILE PICTURE
    } else {
      // errorSnackbar('No Image Selected');
    }
  }

  clearImage() {
    selectedImagePath.value = '';
  }

  // uploadFileToServer() async {
  //   var user_id = accDetailStorage.read('user_id');
  //   String url = "${kApiTexts.BASE_URL}${kApiTexts.POST_PROFILE_PIC}";
  //
  //   var postUri = Uri.parse("$url");
  //   var request = http.MultipartRequest("POST", postUri);
  //   request.fields['user_id'] = user_id.toString();
  //   request.files.add(http.MultipartFile.fromBytes('file',
  //       await File.fromUri(Uri.parse(selectedImagePath.value)).readAsBytes(),
  //       contentType: MediaType('image', 'jpeg')));
  //
  //   request.send().then((response) {
  //     if (response.statusCode == 200)
  //       successSnackbar("Profile Picture Successfully Uploaded!");
  //   });
  // }
}
