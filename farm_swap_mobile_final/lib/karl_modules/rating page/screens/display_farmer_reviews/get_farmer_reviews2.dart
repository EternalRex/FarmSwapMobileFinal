import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farm_swap_mobile_final/common/colors.dart';
import 'package:farm_swap_mobile_final/common/consumer_individual_details.dart';
import 'package:farm_swap_mobile_final/common/poppins_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class GetFarmerReview2 extends StatefulWidget {
  const GetFarmerReview2({super.key, required this.farmerId});
  final String farmerId;
  @override
  State<GetFarmerReview2> createState() => _GetFarmerReview2State();
}

class _GetFarmerReview2State extends State<GetFarmerReview2> {
  ListinGetConsumerDetails consumerDetails = ListinGetConsumerDetails();
  final _firebase = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firebase
          .collectionGroup('reviewrating')
          .where('farmerid', isEqualTo: widget.farmerId)
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

    String consumerUserName = data["consumerUname"];
    String review = data["review"];
    int finalRating = (data["rate"] as num).toInt();
    Timestamp reviewDate = data["reviewDate"];
    DateTime finalReviewDate = reviewDate.toDate();
    String photo = data['profilePhoto'];
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
              Row(
                children: [
                  Container(
                    height: 100.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(photo),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Container(
                    height: 100.h,
                    width: 209.w,
                    child: Column(
                      children: [
                        Text(
                          consumerUserName,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 20.sp,
                          ),
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
                ],
              ),
              /* 
              Text(
                consumerUserName,
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
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
