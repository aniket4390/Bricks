import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../domain/repositories/{{component_name.snakeCase()}}_repository.dart';
import 'package:jiogate_2/app/core/domain/usecases/usecase.dart';
import 'package:jiogate_2/app/core/errors/failures.dart';

class {{usecase_name.pascalCase()}} implements UseCase {
  final {{component_name.pascalCase()}}Repository repository;

  {{usecase_name.pascalCase()}}(this.repository);

  @override
  Future<Either<Failure, dynamic>> call(
    {{usecase_name.pascalCase()}}Params params,
  ) async {
    return await repository.{{usecase_name.camelCase()}}();
  }
}

class {{usecase_name.pascalCase()}}Params extends Equatable {
  const {{usecase_name.pascalCase()}}Params();

  @override
  List<Object?> get props => [];
}
