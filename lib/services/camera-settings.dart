import 'package:flutter/cupertino.dart';
import 'package:camera/camera.dart';

class CameraSettings with ChangeNotifier {

  List<CameraDescription> listOfCameras = [];
  late CameraDescription cameraSelected;

  ResolutionPreset quality = ResolutionPreset.medium;

  void setListOfCameras(list) {
    listOfCameras = list;
    notifyListeners();
  }

  void setSelectedCamera(CameraDescription camera) {
    cameraSelected = camera;
    notifyListeners();
  }

  void setQuality(ResolutionPreset qlt) {
    quality = qlt;
    notifyListeners();
  }



}