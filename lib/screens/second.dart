import 'package:flutter/material.dart';
import 'package:hello_flutter2/components/skeleton-scaffold.dart';

import 'package:camera/camera.dart';
import 'package:hello_flutter2/screens/setting.dart';
import 'package:hello_flutter2/services/camera-settings.dart';
import 'package:hello_flutter2/services/camera.dart';
import 'package:provider/provider.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // I'm using a MultiProvider in order to prepare the code to have differents providers.
    // Right now I'm using only CameraSettings
    return Consumer<CameraSettings>(builder: (context, cameraSett, _) {
      return SkeletonScaffold(
          title: 'Second Page',
          body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Center(
              child: Column(
                children: [
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.green),
                      minimumSize: MaterialStateProperty.all(Size(45, 45)),
                    ),
                    onPressed:  () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Setting(),
                        ),
                      );
                    },
                    child: Text(
                      'SETTING',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  /* Container(
                      height: 100,
                      width: 200,
                      decoration: ShapeDecoration(
                        color: Colors.green,
                        shape: StadiumBorder(
                          side: BorderSide(color: Colors.black, width: 2),
                        ),
                      ),
                      child: Setting()), */
                  Expanded(
                      child: Container(
                    child: FutureBuilder(
                      future: cameraDetails(cameraSett),
                      builder:
                          (BuildContext context, AsyncSnapshot<Widget> widget) {
                        // But 'widget' here is NOT a widget, it is an AsyncSnapshot object,
                        // return widget; // **is wrong**
                        // instead:

                        // and better to make it like this:
                        if (!widget.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        // I'm forced to use ?? that means is case of null, do the right part
                        return widget.data ?? Container();
                      },
                    ),
                  ))
                ],
              ),
            ),
          ));
    });
  }

  Future<Widget> cameraDetails(CameraSettings cameraS) async {
    // Ensure that plugin services are initialized so that `availableCameras()`
    // can be called before `runApp()`
    WidgetsFlutterBinding.ensureInitialized();

    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

    cameraS.setListOfCameras(cameras);
    // Get a specific camera from the list of available cameras.

    return TakePictureScreen(
      // Pass the appropriate camera to the TakePictureScreen widget.
      camera: cameraS.cameraSelected,
    );
  }
}
