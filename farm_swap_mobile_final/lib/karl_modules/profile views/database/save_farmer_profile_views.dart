import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/karl_modules/profile%20views/models/profile_view_model.dart';

class CountFarmerProfileVisitsQuerry {
  Future<void> counstFarmerProfileVisit(
    String farmerId,
    String viewerId,
    DateTime viewTime,
    String viewerUserName,
    String viewerUrl,
  ) async {
    String finalId = 'profileView$farmerId';

    final profileViewSave = FarmerProfileViewModel(
      fprofileViewCount: 1,
      farmerId: farmerId,
      veiwerId: viewerId,
      viewDate: viewTime,
      consumerUname: viewerUserName,
      consumerUrl: viewerUrl,
    );

    await FirebaseFirestore.instance
        .collection('sample_FarmerProfileVisits')
        .doc(finalId)
        .collection('fProfileVisits')
        .add(
          profileViewSave.toMap(),
        );
  }
}
