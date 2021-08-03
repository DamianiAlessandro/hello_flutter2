import 'package:flutter/material.dart';
import 'package:hello_flutter2/services/camera-settings.dart';
import 'package:camera/camera.dart';
import 'package:provider/provider.dart';

class Setting extends StatelessWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Consumer<CameraSettings>(
      builder: (context, cameraSett, _) {
        return Scaffold(
            body: Column(
              children: [
                SizedBox(height: 10),
                Container(
                    child: listCameraPopup(cameraSett)
                )
              ],
            )
        );
      }
    );

  }


  Widget listCameraPopup(CameraSettings cart) {

    return  PopupMenuButton<CameraDescription>(
      onSelected: (CameraDescription result) {
        cart.cameraSelected = result;
        },
      itemBuilder: (context) {
        List<PopupMenuEntry<CameraDescription>> children = [];
        cart.listOfCameras.forEach((CameraDescription camera) => {
        children.add(PopupMenuItem(
            value: camera,
            child: Text(
              camera.toString(),
              style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w700),
            )
          ))
        });
        return children;
  },
      child: Container(
        height: 50,
        width: 200,
        decoration: ShapeDecoration(
          color: Colors.green,
          shape: StadiumBorder(
            side: BorderSide(color: Colors.black, width: 2),
          ),
        ),
        child: Text('Select camera'),
      ),
    );
  }
}
