// ignore_for_file: prefer_const_constructors

import 'package:flutter_test/flutter_test.dart';
import 'package:model_api/src/medicine/service/supabase_medicine_api_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  group('MedicineApi', () {
    //Creat a supabase instance
    final supabase = Supabase.instance.client;
  });
}
