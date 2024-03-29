// ignore_for_file: public_member_api_docs

import 'package:models/models.dart';
import 'package:services/src/specialization/specialization_api_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseSpecializationApiService
    implements SpecializationApiService<Specialization> {
  const SupabaseSpecializationApiService({
    required this.supabase,
  });

  final SupabaseClient supabase;

  @override
  Future<List<String>> getAllSpecialization() => supabase
      .from('specialization')
      .select<PostgrestList>()
      .then(
        (value) => value.isEmpty
            ? throw Exception('No specialization found')
            : value.map((item) => item['name'] as String).toList(),
      )
      .onError((error, stackTrace) => throw Exception(error));

  @override
  Future<void> createSpecialization(Specialization specialization) => supabase
      .from('specialization')
      .insert(
        specialization.toJson(),
      )
      .onError(
        (error, stackTrace) => throw Exception(error),
      );

  @override
  Future<int> getTotalDoctorsBySpecialization(String specialization) => supabase
      .from('specialization')
      .select<PostgrestList>()
      .eq('name', specialization)
      .then(
        (value) => value.isEmpty
            ? throw Exception(
                'Error from getTotalDoctorsBySpecialization: No specialization found with specialization $specialization',
              )
            : value.first['numMembers'] as int,
      )
      .onError(
        (error, stackTrace) => throw Exception(error),
      );

  @override
  Future<void> updateDescription(String specialization, String description) =>
      supabase
          .from('specialization')
          .update({'description': description})
          .eq('name', specialization)
          .onError(
            (error, stackTrace) => throw Exception(error),
          );
}
