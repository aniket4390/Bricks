export 'presentation/controller/{{component_name.snakeCase()}}_controller.dart';
export 'presentation/binding/{{component_name.snakeCase()}}_binding.dart';
export 'presentation/view/{{component_name.snakeCase()}}_view.dart';

class {{component_name.pascalCase()}}Tags {
  {{component_name.pascalCase()}}Tags._();
  
  static const String {{component_name.camelCase()}}ControllerTag = '{{component_name.camelCase()}}ControllerTag';
  //tags
}
