class FarmerProfileViewModel {
  FarmerProfileViewModel({
    required this.fprofileViewCount,
    required this.farmerId,
    required this.veiwerId,
    required this.viewDate,
    required this.consumerUname,
    required this.consumerUrl,
  });
  double fprofileViewCount;
  String farmerId;
  String veiwerId;
  DateTime viewDate;
  String consumerUname;
  String consumerUrl;

  Map<String, dynamic> toMap() {
    return {
      'fprofileVisitCount': fprofileViewCount,
      'farmerid': farmerId,
      'viewer': veiwerId,
      'viewDate': viewDate,
      'consumerUname': consumerUname,
      'consumerUrl': consumerUrl,
    };
  }
}
