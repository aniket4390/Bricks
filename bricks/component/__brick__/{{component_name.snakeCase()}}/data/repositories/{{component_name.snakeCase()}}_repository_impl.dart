import '../../data/datasources/{{component_name.snakeCase()}}_remote_datasource.dart';
import 'package:dartz/dartz.dart';
import '../../domain/repositories/{{component_name.snakeCase()}}_repository.dart';
import 'package:jiogate_2/app/core/errors/exceptions.dart';
import 'package:jiogate_2/app/core/errors/failures.dart';
import 'package:jiogate_2/app/core/network/network_info.dart';
//import

class {{component_name.pascalCase()}}RepositoryImpl extends {{component_name.pascalCase()}}Repository {
  final {{component_name.pascalCase()}}RemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  {{component_name.pascalCase()}}RepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  //implementation
}
