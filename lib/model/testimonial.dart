// ignore_for_file: public_member_api_docs, sort_constructors_first
class Testimonial {
  int id;
  String fullName;
  String currentStatus;
  String address;
  int currentRank;
  bool isActive;
  String? imageUri;
  String message;
  Testimonial({
    required this.id,
    required this.fullName,
    required this.currentStatus,
    required this.address,
    required this.currentRank,
    required this.isActive,
    this.imageUri,
    required this.message,
  });

 
  factory Testimonial.fromMap(Map<String, dynamic> map) {
    return Testimonial(
      id: map['id'] as int,
      fullName: map['full_name'] as String,
      currentStatus: map['current_status'] as String,
      address: map['address'] as String,
      currentRank: map['current_rank'] == null ? 1 : map['current_rank'] as int,
      isActive: map['is_active']==1?true:false,
      imageUri: map['image_uri'] != null
          ? map['image_uri'] as String
          : map['image_uri'],
      message: map['message'] as String,
    );
  }
}
