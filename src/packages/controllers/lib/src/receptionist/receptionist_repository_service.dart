// ignore_for_file: public_member_api_docs

abstract interface class ReceptionistRepositoryService {
  void initializeReceptionistId(String id);

  void clear();

  Future<Map<String, dynamic>> getProfileData();

  Future<void> updateProfileData({
    String? fullname,
    String? email,
    String? phone,
    DateTime? birthday,
  });
}