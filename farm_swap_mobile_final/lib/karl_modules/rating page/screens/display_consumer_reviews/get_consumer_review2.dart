import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class GetConsumerDisplayReview2 extends StatefulWidget {
  const GetConsumerDisplayReview2({super.key, required this.consumerId});
  final String consumerId;

  @override
  State<GetConsumerDisplayReview2> createState() => _GetConsumerDisplayReview2State();
}

class _GetConsumerDisplayReview2State extends State<GetConsumerDisplayReview2> {
  final _firebase = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firebase
          .collectionGroup('consreviewrating')
          .where('consumerId', isEqualTo: widget.consumerId)
          .orderBy('reviewDate', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return ListView(
              scrollDirection: Axis.vertical,
              children: snapshot.data!.docs
                  .map<Widget>((document) => accessDocumentContents(document))
                  .toList(),
            );
          }
          return const Text("No Ratings yet");
        } else {
          return const Text("Loading...");
        }
      },
    );
  }

  Widget accessDocumentContents(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    String farmerUname = data["farmerUname"];
    String review = data["review"];
    int finalRating = (data["rate"] as num).toInt();
    Timestamp reviewDate = data["reviewDate"];
    DateTime finalReviewDate = reviewDate.toDate();
    String stringFinalReviewDate = DateFormat('MM-dd-yyyy').format(finalReviewDate);

    return Padding(
      padding: EdgeInsets.all(8.sp),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          /*PUTTING BOX SHADOW ON THE CONTAINER */
          boxShadow: [
            BoxShadow(
              color: shadow,
              blurRadius: 2,
              offset: const Offset(1, 5),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(5.0.sp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                farmerUname,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.sp),
              ),
              (finalRating == 5)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.star,
                          color: darkGreen,
                          size: 25.sp,
                        ),
                        Icon(
                          Icons.star,
                          color: darkGreen,
                          size: 25.sp,
                        ),
                        Icon(
                          Icons.star,
                          color: darkGreen,
                          size: 25.sp,
                        ),
                        Icon(
                          Icons.star,
                          color: darkGreen,
                          size: 25.sp,
                        ),
                        Icon(
                          Icons.star,
                          color: darkGreen,
                          size: 25.sp,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        poppinsText2(
                          "(5/5)",
                          Colors.black,
                          13.sp,
                          FontWeight.normal,
                        ),
                      ],
                    )
                  /*if rating is 4 display 4 stars */
                  : (finalRating < 5 && finalRating >= 4)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              color: darkGreen,
                              size: 25.sp,
                            ),
                            Icon(
                              Icons.star,
                              color: darkGreen,
                              size: 25.sp,
                            ),
                            Icon(
                              Icons.star,
                              color: darkGreen,
                              size: 25.sp,
                            ),
                            Icon(
                              Icons.star,
                              color: darkGreen,
                              size: 25.sp,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            poppinsText2(
                              "(4/5)",
                              Colors.black,
                              13.sp,
                              FontWeight.normal,
                            ),
                          ],
                        )
                      : (finalRating < 4 && finalRating >= 3)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: darkGreen,
                                  size: 25.sp,
                                ),
                                Icon(
                                  Icons.star,
                                  color: darkGreen,
                                  size: 25.sp,
                                ),
                                Icon(
                                  Icons.star,
                                  color: darkGreen,
                                  size: 25.sp,
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                poppinsText2(
                                  "(3/5)",
                                  Colors.black,
                                  13.sp,
                                  FontWeight.normal,
                                ),
                              ],
                            )
                          : (finalRating < 3 && finalRating >= 2)
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: darkGreen,
                                      size: 25.sp,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: darkGreen,
                                      size: 25.sp,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    poppinsText2(
                                      "(2/5)",
                                      Colors.black,
                                      13.sp,
                                      FontWeight.normal,
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: darkGreen,
                                      size: 25.sp,
                                    ),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    poppinsText2(
                                      "(1/5)",
                                      Colors.black,
                                      13.sp,
                                      FontWeight.normal,
                                    ),
                                  ],
                                ),
              Text(
                stringFinalReviewDate,
                textAlign: TextAlign.center,
              ),
              Text(
                review,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
