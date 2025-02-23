import 'package:canvas_and_pixels_mobile_app_template/core/application/application.dart';
import 'package:canvas_and_pixels_mobile_app_template/shared/utils/utils.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseHelper {
  static Future<Either<CustomError, T>> handleSupabaseRequest<T>(
      Future<T> Function() request) async {
    try {
      final result = await request();
      return Right(result);
    } on AuthException catch (e) {
      AppLogger.error('Supabase Auth Error: ${e.message}');
      return Left(CustomError(message: 'Authentication error: ${e.message}'));
    } on PostgrestException catch (e) {
      AppLogger.error('Supabase Database Error: ${e.message}');
      return Left(CustomError(message: 'Database error: ${e.message}'));
    } catch (e) {
      AppLogger.error('Unexpected Supabase Error: $e');
      return Left(CustomError(message: 'Unexpected error: $e'));
    }
  }
}
