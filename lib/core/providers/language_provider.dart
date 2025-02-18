import 'dart:convert';

import 'package:flag/flag.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LanguageModel {
  FlagsCode? flag;
  String? selectedLanguage;
  String? code;
  LanguageModel({
    this.flag,
    this.selectedLanguage,
    this.code,
  });

  Map<String, dynamic> toMap() {
    return {
      // 'flag': flag?.,
      'language': selectedLanguage,
      'code': code
    };
  }

  factory LanguageModel.fromMap(Map<String, dynamic> json) {
    return LanguageModel(
      code: json['code'],
      flag: json['flag'],
      selectedLanguage: json['language'],
    );
  }
  static LanguageModel initial = LanguageModel(
    code: 'en',
  );
}

class LanguageProvider extends StateNotifier<LanguageModel> {
  final String _languageCodeKey = 'language_code';

  // Private constructor
  LanguageProvider._privateConstructor() : super(LanguageModel());

  // Singleton instance
  static final LanguageProvider _instance =
      LanguageProvider._privateConstructor();

  // Factory constructor to return the singleton instance
  factory LanguageProvider() {
    return _instance;
  }

  
  void init() async {
    // super.init();
    getLanguage();
  }

  Future<LanguageModel?> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_languageCodeKey);
    if (jsonString != null) {
      final data = LanguageModel.fromMap(json.decode(jsonString));
      state = data;
      return data;
    } else {
      return null;
    }
  }

  set setLanguage(LanguageModel data) {
    // updateValue(data);
    state = data;
    _cache();
  }

  Future<void> _cache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_languageCodeKey, json.encode(state.toMap()));
  }
}
