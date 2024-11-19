import 'package:cheating_app/view/screen/auth/controller/auth_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class DependencyInjection extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }

}