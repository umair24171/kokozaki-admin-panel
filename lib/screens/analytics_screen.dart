// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
// import 'package:intl/intl.dart';
import 'package:kokzaki_admin_panel/controllers/super_markets_controller.dart';
import 'package:kokzaki_admin_panel/helper/colors.dart';
import 'package:kokzaki_admin_panel/models/market_model.dart';
import 'package:kokzaki_admin_panel/widgets/categories_revenue_graph.dart';
import 'package:kokzaki_admin_panel/widgets/user_sales_graph.dart';

class AnalyticsScreen extends StatelessWidget {
  AnalyticsScreen({super.key});

  List<CategoryData> dataSources = [];

  @override
  Widget build(BuildContext context) {
    var marketsController = Get.put(SuperMarketsController());
    marketsController.getSuperMarkets();
    double initialRevenue = 0;
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('orders').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                  child: Text(
                'No Data Found',
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ));
            }
            snapshot.data!.docs
                .map((e) => initialRevenue += e['totalPrice'])
                .toList();

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RevenueContainers(
                          text: 'Total Revenue',
                          subText: '\$$initialRevenue',
                          percentText: '',
                          icon: Icons.arrow_circle_up,
                          color: const Color(0xff263C81),
                          iconsColor: Colors.green,
                        ),
                        RevenueContainers(
                          text: 'Total Sales Registered',
                          subText:
                              '${snapshot.data!.docs.where((element) => element['quantity'] != null).toList().length}',
                          percentText: '',
                          icon: Icons.arrow_circle_down,
                          color: primaryColor,
                          iconsColor: Colors.red,
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(right: 22, bottom: 20, top: 40),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [BoxShadow(color: Colors.white)]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              'Users Sales and Visit Data ',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 19,
                                                  fontFamily: 'Hind'),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 10,
                                                      width: 10,
                                                      decoration: BoxDecoration(
                                                          color: secondaryColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3)),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    const Text(
                                                      'Direct Visit',
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          fontFamily: 'Hind',
                                                          color: Color(
                                                              0xffA3A3A3)),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 10,
                                                      width: 10,
                                                      decoration: BoxDecoration(
                                                          color: primaryColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3)),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    const Text(
                                                      'Referral Link',
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          fontFamily: 'Hind',
                                                          color: Color(
                                                              0xffA3A3A3)),
                                                    )
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      const UserSalesGraph(),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                            blurRadius: 1,
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  'Registered New Stores',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontFamily: 'Hind'),
                                                ),
                                                Icon(Icons.more_vert)
                                              ],
                                            ),
                                            FutureBuilder(
                                                future: marketsController
                                                    .getSuperMarkets(),
                                                builder: (context, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return SpinKitThreeBounce(
                                                      color: primaryColor,
                                                      size: 35,
                                                    );
                                                  }
                                                  return ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: marketsController
                                                                  .superMarkets
                                                                  .length >=
                                                              4
                                                          ? 4
                                                          : marketsController
                                                              .superMarkets
                                                              .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        // final data = snapshot
                                                        //     .data!.docs[index]
                                                        //     .data();
                                                        MarketModel
                                                            marketModel =
                                                            marketsController
                                                                    .superMarkets[
                                                                index];

                                                        return RecentOrderProduct(
                                                            marketModel:
                                                                marketModel);
                                                      });
                                                })
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Card(
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                decoration: BoxDecoration(
                                    color: whiteColor,
                                    boxShadow: [
                                      BoxShadow(
                                          color: whiteColor,
                                          blurRadius: 2,
                                          offset: Offset(0, 10)),
                                    ],
                                    borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Stores Analytics',
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: primaryColor,
                                            fontFamily: 'Hind',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      FutureBuilder(
                                          future: marketsController
                                              .getSuperMarkets(),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return SpinKitThreeBounce(
                                                color: primaryColor,
                                                size: 35,
                                              );
                                            }
                                            return ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: marketsController
                                                  .superMarkets.length,
                                              itemBuilder: (context, index) {
                                                MarketModel marketModel =
                                                    marketsController
                                                        .superMarkets[index];
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          CircleAvatar(
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    marketModel
                                                                        .imageUrl),
                                                          ),
                                                          Text(marketModel
                                                              .marketName),
                                                        ],
                                                      ),
                                                      StreamBuilder(
                                                          stream: FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'orders')
                                                              .where('marketId',
                                                                  arrayContains:
                                                                      marketModel
                                                                          .uid)
                                                              .snapshots(),
                                                          builder: (context,
                                                              snapshot1) {
                                                            double
                                                                totalRevenue =
                                                                0;
                                                            if (snapshot1
                                                                .hasData) {
                                                              for (int i = 0;
                                                                  i <
                                                                      snapshot1
                                                                          .data!
                                                                          .docs
                                                                          .length;
                                                                  i++) {
                                                                final data =
                                                                    snapshot1
                                                                        .data!
                                                                        .docs[i];
                                                                totalRevenue +=
                                                                    data[
                                                                        'totalPrice'];
                                                              }
                                                              return Text(
                                                                  '\$$totalRevenue');
                                                            } else {
                                                              return SpinKitThreeBounce(
                                                                color:
                                                                    primaryColor,
                                                                size: 35,
                                                              );
                                                            }
                                                          }),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          })
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                            // width: MediaQuery.of(context).size.width * 0.4,
                            child: const CategoryRevenueGraph())
                      ],
                    )
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: SpinKitThreeBounce(
                color: primaryColor,
                size: 35,
              ),
            );
          }
        });
  }
}

class RecentOrderProduct extends StatelessWidget {
  RecentOrderProduct({super.key, required this.marketModel});
  MarketModel marketModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 2,
            child: Column(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  marketModel.imageUrl,
                  height: 50,
                  width: 50,
                ),
              ),
            ]),
          ),
          Expanded(
            flex: 3,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    marketModel.marketName,
                    maxLines: 1,

                    // overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        overflow: TextOverflow.fade,
                        fontFamily: 'Hind',
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    marketModel.category,
                    style: const TextStyle(
                        fontFamily: 'Hind',
                        fontSize: 13,
                        fontWeight: FontWeight.w400),
                  )
                ]),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                const SizedBox(
                  height: 5,
                ),
                Container(
                    decoration: BoxDecoration(
                      color: marketModel.status == true
                          ? primaryColor
                          : Colors.red,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: marketModel.status == true
                            ? Text(
                                'Active',
                                style: TextStyle(
                                    fontFamily: 'Hind',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: whiteColor),
                              )
                            : const Text(
                                'Pending',
                                style: TextStyle(
                                    fontFamily: 'Hind',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class RevenueContainers extends StatelessWidget {
  const RevenueContainers(
      {super.key,
      required this.text,
      required this.subText,
      required this.percentText,
      required this.icon,
      required this.iconsColor,
      required this.color});
  final String text;
  final String subText;
  final String percentText;
  final IconData icon;
  final Color color;
  final Color iconsColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 150,
      padding: const EdgeInsets.all(15),
      // width: 250,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                  fontFamily: 'Hind', fontSize: 14, color: whiteColor),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                subText,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: whiteColor,
                  fontFamily: 'Hind',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      percentText,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Hind'),
                    ),
                    const Text(
                      'Total Revenue of all time',
                      style: TextStyle(color: Colors.white60, fontSize: 12),
                    )
                  ],
                ),
                Icon(
                  icon,
                  color: iconsColor,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
