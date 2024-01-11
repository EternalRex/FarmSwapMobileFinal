import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/farmer_individual_details.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CheckBarterBid {
  ListinGetFarmerDetails farmerDetails = ListinGetFarmerDetails();
  Future<List<String>> checkBidPresence() async {
    String farmerUname = await farmerDetails.getUname();
    String transactioinType = "BARTER";
    String farmerId = FirebaseAuth.instance.currentUser!.uid;
    String farmerBarterId = "$farmerUname$transactioinType$farmerId";

    try {
      print("In Here");
      /*Declare an List of String variable */
      List<String> barterbidsid = [];

      /*Querry into the bartercollection */
      QuerySnapshot query = await FirebaseFirestore.instance
          .collection('sample_BarterListings')
          .doc(farmerBarterId)
          .collection('barter')
          .get();

      /*Loop the collection and look for documents that has barterbids collection*/
      if (query.docs.isNotEmpty) {
        for (QueryDocumentSnapshot document in query.docs) {
          /*Get the subcollection of that document if it has*/
          QuerySnapshot subquery = await document.reference.collection('barterbids').get();
          if (subquery.docs.isNotEmpty) {
            barterbidsid.add(document.id);
          }
        }
      } else {
        throw Exception("Empty collection");
      }
      return barterbidsid;
    } catch (e) {
      throw Exception("Failed checking barterbids operation");
    }
  }
}
