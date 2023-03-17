import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:training_api/pro/api/api_response.dart';
import 'package:training_api/pro/get/images_controller.dart';

import '../../../models/studentImage.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({Key? key}) : super(key: key);

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  XFile? _puckedImage;
  double? _progressValue = 0;
  late ImagePicker _imagePicker;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text("Upload Image"),
        actions: [
          IconButton(
            onPressed: () async => await _pikedImage(),
            icon: Icon(Icons.camera_alt),
          ),
        ],
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            minHeight: 10,
            backgroundColor: Colors.green.shade200,
            color: Colors.green.shade700,
            value: _progressValue,
          ),
          Expanded(
              child: _puckedImage != null
                  ? Image.file(File(_puckedImage!.path))
                  : IconButton(
                      onPressed: () async {
                        await _pikedImage();
                      },
                      icon: Icon(Icons.camera_alt),
                      iconSize: 70,
                      color: Colors.grey,
                    )),
          ElevatedButton.icon(
            label: Text("UPLOAD"),
            onPressed: () async => await _performUpload(),
            icon: Icon(Icons.cloud_upload),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                minimumSize: Size(double.infinity, 50)),
          ),
        ],
      ),
    );
  }

  Future<void> _pikedImage() async {
    XFile? imageFile = await _imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 80);
    if (imageFile != null) {
      setState(() {
        _puckedImage = imageFile;
      });
    }
  }

  Future<void> _performUpload() async {
    if (_checkData()) {
      await _uploadImage();
    }
  }

  bool _checkData() {
    if (_puckedImage != null) {
      return true;
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Pick image to upload ")));
    return false;
  }

  Future<void> _uploadImage() async {
    setProgress();
    ApiResponse<StudentImage> apiResponse =
        await ImagesGetxController.to.upload(path: _puckedImage!.path);
    setProgress(value: apiResponse.success ? 1 : 0);
  }

  setProgress({double? value}) {
    setState(() {
      _progressValue = value;
    });
  }
}
