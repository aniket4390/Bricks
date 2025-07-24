import 'package:get/get.dart';
import '../../{{component_name.snakeCase()}}.dart';
import 'package:project_name/app/constant/controller_tags.dart';
import 'package:project_name/app/core/network/network_info.dart';
import '../../data/datasources/{{component_name.snakeCase()}}_remote_datasource.dart';
import '../../data/repositories/{{component_name.snakeCase()}}_repository_impl.dart';
import '../../domain/repositories/{{component_name.snakeCase()}}_repository.dart';
//import

class {{component_name.pascalCase()}}Binding extends Bindings {
  NetworkInfo networkInfo = Get.find(tag: CoreTags.networkTag);

  @override
  void dependencies() {
    Get.lazyPut(
      () => {{component_name.pascalCase()}}Controller(),
      tag: {{component_name.pascalCase()}}Tags.{{component_name.camelCase()}}ControllerTag,
    );
    //dependencies
  }
}
