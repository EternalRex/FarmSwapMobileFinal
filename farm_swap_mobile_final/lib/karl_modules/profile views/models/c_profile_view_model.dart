class ConsumerProfileViewModel {
  ConsumerProfileViewModel({
    required this.cprofileViewCount,
    required this.carmerId,
    required this.veiwerId,
    required this.viewDate,
    required this.farmerUname,
    required this.farmerUrl,
  });
  double cprofileViewCount;
  String carmerId;
  String veiwerId;
  DateTime viewDate;
  String farmerUname;
  String farmerUrl;

  Map<String, dynamic> toMap() {
    return {
      'fprofileVisitCount': cprofileViewCount,
      'farmerid': carmerId,
      'viewer': veiwerId,
      'viewDate': viewDate,
      'viewerUname': farmerUname,
      'viewerUrl': farmerUrl,
    };
  }
}
