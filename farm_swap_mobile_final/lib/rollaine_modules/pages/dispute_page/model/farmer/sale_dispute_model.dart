class SaleDisputeModel {
  SaleDisputeModel({
    required this.addedAmnt,
    required this.cBarangay,
    required this.cLname,
    required this.cMunicipality,
    required this.cName,
    required this.cUrl,
    required this.cUname,
    required this.deductFarm,
    required this.fBarangay,
    required this.fLname,
    required this.fMunicipality,
    required this.fName,
    required this.fUrl,
    required this.fUname,
    required this.fId,
    required this.lName,
    required this.lId,
    required this.lPrice,
    required this.lQuan,
    required this.lStatus,
    required this.lUrl,
    required this.pPrice,
    required this.pQuan,
    required this.disputeDateFile,
    required this.isResolved,
    required this.consumerDisputeStatus,
    required this.consumerDisputeText,
    required this.consumerDisputeUrl,
  });

  double addedAmnt;
  String cBarangay;
  String cLname;
  String cMunicipality;
  String cName;
  String cUrl;
  String cUname;
  String deductFarm;
  String fBarangay;
  String fLname;
  String fMunicipality;
  String fName;
  String fUrl;
  String fUname;
  String fId;
  String lName;
  String lId;
  String lPrice;
  String lQuan;
  String lStatus;
  String lUrl;
  double pPrice;
  double pQuan;

  DateTime disputeDateFile;
  bool isResolved;
  String consumerDisputeStatus;
  String consumerDisputeText;
  String consumerDisputeUrl;

  Map<String, dynamic> toMap() {
    return {
      'addedAmnt': addedAmnt,
      'cBarangay': cBarangay,
      'cLname': cLname,
      'cMunicipality': cMunicipality,
      'cName': cName,
      'cUrl': cUrl,
      'cUname': cUname,
      'deductFarm': deductFarm,
      'fBarangay': fBarangay,
      'fLname': fLname,
      'fMunicipality': fMunicipality,
      'fName': fName,
      'fUrl': fUrl,
      'fUname': fUname,
      'fId': fId,
      'lName': lName,
      'lId': lId,
      'lPrice': lPrice,
      'lQuan': lQuan,
      'lStatus': lStatus,
      'lUrl': lUrl,
      'pPrice': pPrice,
      'pQuan': pQuan,
      'disputeDateFile': disputeDateFile,
      'isResolved': isResolved,
      'consumerDisputeStatus': consumerDisputeStatus,
      'consumerDisputeText': consumerDisputeText,
      'consumerDisputeUrl': consumerDisputeUrl,
    };
  }
}
