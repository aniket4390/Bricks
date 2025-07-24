import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jiogate_2/app/core/presentation/widgets/widgets.dart';
import '../../{{component_name.snakeCase()}}.dart';
import 'package:jiogate_2/app/theme/app_colors.dart';
import 'package:jiogate_2/app/utils/utils.dart';

class {{component_name.pascalCase()}}View extends StatelessWidget {
  final {{component_name.pascalCase()}}Controller controller = Get.find<{{component_name.pascalCase()}}Controller>(
    tag: {{component_name.pascalCase()}}Tags.{{component_name.camelCase()}}ControllerTag,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: Utils.displayAppBar('{{component_name.titleCase()}}', true, () {
        Get.back();
      }),
      body: GetBuilder(
        init: controller,
        builder: (context) {
          return controller.{{component_name.camelCase()}}Data.fold(
            () => LoadingWidget(),
            (failureOrData) => failureOrData.fold(
              (failure) => FailureWidget(failure),
              (data) {
                return Container(
                  child: Text('{{component_name.titleCase()}} View'),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
