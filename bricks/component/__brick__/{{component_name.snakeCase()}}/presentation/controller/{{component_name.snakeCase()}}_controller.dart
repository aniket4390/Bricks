import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:jiogate_2/app/core/errors/failures.dart';
//import

class {{component_name.pascalCase()}}Controller extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  Option<Either<Failure, dynamic>> {{component_name.camelCase()}}Data = none();
  //controllerCode
}
