import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/karl_modules/profile%20views/models/c_profile_view_model.dart';

class CountConsumerProfileVisitsQuerry {
  Future<void> counstFarmerProfileVisit(
    String consumerId,
    String viewerId,
    DateTime viewTime,
    String farmerUname,
    String farmerUrl,
  ) async {
    String finalId = 'profileView$consumerId';

    final profileViewSave = ConsumerProfileViewModel(
      cprofileViewCount: 1,
      carmerId: consumerId,
      veiwerId: viewerId,
      viewDate: viewTime,
      farmerUname: farmerUname,
      farmerUrl: farmerUrl,
    );
    await FirebaseFirestore.instance
        .collection('sample_ConsumerProfileVisits')
        .doc(finalId)
        .collection('cProfileVisits')
        .add(
          profileViewSave.toMap(),
        );
  }
}
