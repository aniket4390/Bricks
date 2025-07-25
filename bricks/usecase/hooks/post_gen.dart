import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final componentName = context.vars['component_name'] as String;
  final usecaseName = context.vars['usecase_name'] as String;
  
  // Convert to different case formats
  final componentNameCamelCase = componentName.camelCase;
  final componentNamePascalCase = componentName.pascalCase;
  final usecaseNameCamelCase = usecaseName.camelCase;
  final usecaseNamePascalCase = usecaseName.pascalCase;
  
  final progress = context.logger.progress('Updating existing files...');
  
  try {
    // Update repository abstract class
    await _updateRepository(componentName, usecaseNameCamelCase);
    
    // Update repository implementation
    await _updateRepositoryImpl(componentName, usecaseNameCamelCase, usecaseNamePascalCase);
    
    // Update remote data source
    await _updateRemoteDataSource(componentName, usecaseNameCamelCase, usecaseNamePascalCase);
    
    // Update binding
    await _updateBinding(componentName, usecaseName, componentNamePascalCase, usecaseNamePascalCase, usecaseNameCamelCase);
    
    // Update tags
    await _updateTags(componentName, usecaseNameCamelCase);
    
    progress.complete('✓ All files updated successfully');
  } catch (e) {
    progress.fail('✗ Error updating files: $e');
  }
}

Future<void> _updateRepository(String componentName, String usecaseNameCamelCase) async {
  final file = File('$componentName/domain/repositories/${componentName}_repository.dart');
  if (!await file.exists()) return;
  
  final content = await file.readAsString();
  final lines = content.split('\n');
  
  // Find the //abstract comment and insert the new method before it
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].trim() == '//abstract') {
      lines.insert(i, '  Future<Either<Failure, dynamic>> $usecaseNameCamelCase();');
      break;
    }
  }
  
  await file.writeAsString(lines.join('\n'));
}

Future<void> _updateRepositoryImpl(String componentName, String usecaseNameCamelCase, String usecaseNamePascalCase) async {
  final file = File('$componentName/data/repositories/${componentName}_repository_impl.dart');
  if (!await file.exists()) return;
  
  final content = await file.readAsString();
  final lines = content.split('\n');
  
  // Find the //implementation comment and insert the new method implementation
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].trim() == '//implementation') {
      final implementation = '''
  @override
  Future<Either<Failure, dynamic>> $usecaseNameCamelCase() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteDataList = await remoteDataSource.$usecaseNameCamelCase();
        return Right(remoteDataList);
      } on ServerException catch (exception) {
        return Left(ServerFailure(
          message: (exception.error.response?.data["message"] ?? "").toString().trim().isNotEmpty 
            ? (exception.error.response?.data["message"] ?? "").toString()
            : CustomException.ERROR_CRASH_MSG,
          statusCode: exception.error.response?.statusCode ?? 0,
        ));
      } on OtherException catch (exception) {
        return Left(OtherFailure(exception: exception.exception));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
''';
      lines.insert(i, implementation);
      break;
    }
  }
  
  await file.writeAsString(lines.join('\n'));
}

Future<void> _updateRemoteDataSource(String componentName, String usecaseNameCamelCase, String usecaseNamePascalCase) async {
  final file = File('$componentName/data/datasources/${componentName}_remote_datasource.dart');
  if (!await file.exists()) return;
  
  final content = await file.readAsString();
  final lines = content.split('\n');
  
  // Add abstract method
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].trim() == '//abstract') {
      lines.insert(i, '  Future<dynamic> $usecaseNameCamelCase();');
      break;
    }
  }
  
  // Add implementation
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].trim() == '//implementation') {
      final implementation = '''
  @override
  Future<dynamic> $usecaseNameCamelCase() async {
    try {
      var response = await your_call_method;
      return addYourResponseHere.fromJson(response);
    } on DioException catch (e) {
      throw ServerException(e);
    } on Exception catch (e) {
      throw OtherException(e);
    }
  }
''';
      lines.insert(i, implementation);
      break;
    }
  }
  
  await file.writeAsString(lines.join('\n'));
}

Future<void> _updateBinding(String componentName, String usecaseName, String componentNamePascalCase, String usecaseNamePascalCase, String usecaseNameCamelCase) async {
  final file = File('$componentName/domain/usecases/usecases.dart');
  if (!await file.exists()) return;
  
  final content = await file.readAsString();
  final lines = content.split('\n');
  
  // Add import
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].trim() == '//import') {
      lines.insert(i, "export '${usecaseName}_usecase.dart';");
      break;
    }
  }
  
  // Add dependency
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].trim() == '//dependencies') {
      final dependency = '''
    _registerUseCase<${componentNamePascalCase}>(
      () => ${componentNamePascalCase}(repository),
      ${componentNamePascalCase}Tags.${usecaseNameCamelCase}UseCaseTag,
    );
''';
      lines.insert(i, dependency);
      break;
    }
  }
  
  await file.writeAsString(lines.join('\n'));
}

Future<void> _updateTags(String componentName, String usecaseNameCamelCase) async {
  final file = File('$componentName/$componentName.dart');
  if (!await file.exists()) return;
  
  final content = await file.readAsString();
  final lines = content.split('\n');
  
  // Add tag
  for (int i = 0; i < lines.length; i++) {
    if (lines[i].trim() == '//tags') {
      lines.insert(i, "  static const String ${usecaseNameCamelCase}UseCaseTag = '${usecaseNameCamelCase}UseCaseTag';");
      break;
    }
  }
  
  await file.writeAsString(lines.join('\n'));
}
