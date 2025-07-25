import 'package:get/get.dart';
import '../../{{component_name.snakeCase()}}.dart';
import '../../domain/usecases/usecases.dart';
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

    final networkInfo = Get.find<NetworkInfo>(tag: CoreTags.networkTag);

    Get.create<{{component_name.pascalCase()}}Controller>(
      () => {{component_name.pascalCase()}}Controller(),
      tag: {{component_name.pascalCase()}}Tags.{{component_name.snakeCase()}}ControllerTag,
    );

    // Shared singletons
    final remoteDataSource = {{component_name.pascalCase()}}RemoteDataSourceImpl();
    final repository = {{component_name.pascalCase()}}RepositoryImpl(
      networkInfo: networkInfo,
      remoteDataSource: remoteDataSource,
    );


    //dependencies
  }

  void _registerUseCase<T>(T Function() create, String tag) {
    Get.lazyPut<T>(
      create,
      fenix: false,
      tag: tag,
    );
  } 
}
