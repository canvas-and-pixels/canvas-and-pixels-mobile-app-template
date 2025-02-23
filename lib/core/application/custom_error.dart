import 'package:canvas_and_pixels_mobile_app_template/core/application/application.dart';

class CustomError extends AppError {
  CustomError({
    super.message = 'an error occurred',
  });
}
