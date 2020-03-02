import 'dart:async';

class MainBloc {
  StreamController controller = new StreamController.broadcast();

  Stream get getStream => controller.stream;

  dispose() {
    controller?.close();
  }
}
