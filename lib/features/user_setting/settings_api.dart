import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../services/dio_provider.dart';
import '../../services/service_locator.dart';
import 'models/user_model.dart';
import 'models/user_profile.dart';

class SettingsApi {
  SettingsApi(this.ref);
  final Ref ref;

  DioProvider dio = locator<DioProvider>();

//You can start creating account settings functions now

  // fetches a single user with a give id.
  // this doesn't really work well for now because the ResponseModel
  // being returned from "dioProvider.get" is wrong.

  Future<UserModel> getCurrentUser() async {
    try {
      final response = await dio.get('/auth/@me');
      return UserModel.fromMap(response?.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserModel> getUser(String id) async {
    try {
      final response = await dio.get('/users/$id');
      return UserModel.fromMap(response?.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserProfile> updateProfile({
    required String email,
    required UserProfile profile,
  }) async {
    try {
      final response = await dio.putUpdate(
        '/profile/$email',
        data: profile.toMap(),
      );
      return UserProfile.fromMap(response?.data['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> updateProfileAvatar({
    required File file,
    required String email,
  }) async {
    try {
      final multipart = await MultipartFile.fromFile(
        file.path,
        filename: file.path.split('/').last,
        contentType: MediaType('image', 'png'),
      );
      final response = await dio.multipartPut(
        '/profile/$email/picture',
        data: {'DisplayPhoto': multipart},
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );
      return response?.data['data']['avatar_url'] ?? '';
    } catch (e) {
      rethrow;
    }
  }
}

final settingsApiProvider = Provider<SettingsApi>((ref) => SettingsApi(ref));
