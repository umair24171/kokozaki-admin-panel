import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kokzaki_admin_panel/helper/colors.dart';
import 'package:kokzaki_admin_panel/models/market_model.dart';

class SuperMarkets extends StatelessWidget {
  const SuperMarkets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xfff7e5c7),
                borderRadius: BorderRadius.circular(
                  20,
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Number of Register Markets',
                          style: TextStyle(
                              color: Color(0xff007BAF),
                              fontSize: 31,
                              fontFamily: 'Hind'),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: const Color(0xffBC842C), width: 1)),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'This Month',
                              style: TextStyle(
                                  color: Color(0xff007BAF),
                                  fontSize: 20,
                                  fontFamily: 'Hind'),
                            ),
                          ),
                        )
                      ],
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('sellers')
                            .where('isAdmin', isEqualTo: false)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.docs.isEmpty) {
                              return const Center(
                                child: Text('0'),
                              );
                            }
                            return Text(
                              '${snapshot.data!.docs.length}',
                              style: const TextStyle(
                                  color: Color(0xff007BAF),
                                  fontSize: 31,
                                  fontFamily: 'Hind'),
                            );
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                color: primaryColor,
                              ),
                            );
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('sellers')
                      .where('isAdmin', isEqualTo: false)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.isEmpty) {
                        return const Center(
                          child: Text('No Data Found'),
                        );
                      }
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          showBottomBorder: true,
                          columnSpacing: 30,
                          dividerThickness: 2,
                          dataRowHeight: 80,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 2)),
                          dataTextStyle: const TextStyle(
                            fontFamily: 'Hind',
                          ),
                          headingRowColor: MaterialStateProperty.resolveWith(
                              (states) => primaryColor),
                          dataRowColor:
                              const MaterialStatePropertyAll(Color(0xffD4F2FF)),
                          columns: const [
                            DataColumn(
                                label: Text(
                              'No.',
                              style: TextStyle(
                                  fontFamily: 'Hind', color: Colors.white),
                            )),
                            DataColumn(
                                label: Text(
                              'Super Markets',
                              style: TextStyle(
                                  fontFamily: 'Hind', color: Colors.white),
                            )),
                            DataColumn(
                                label: Text(
                              'Category',
                              style: TextStyle(
                                  fontFamily: 'Hind', color: Colors.white),
                            )),
                            DataColumn(
                                label: Text(
                              'Monthly Visitors',
                              style: TextStyle(
                                  fontFamily: 'Hind', color: Colors.white),
                            )),
                            // DataColumn(
                            //     label: Text(
                            //   'Status',
                            //   style: TextStyle(fontFamily: 'Hind', color: Colors.white),
                            // )),

                            // DataColumn(
                            //     label: Text(
                            //   'Refferal Link',
                            //   style: TextStyle(fontFamily: 'Hind', color: Colors.white),
                            // )),
                            // DataColumn(
                            //     label: Text(
                            //   'Super Market',
                            //   style: TextStyle(fontFamily: 'Hind', color: Colors.white),
                            // )),
                            DataColumn(
                                label: Text(
                              'Revenue',
                              style: TextStyle(
                                  fontFamily: 'Hind', color: Colors.white),
                            )),
                            DataColumn(
                                label: Text(
                              'Access Level',
                              style: TextStyle(
                                  fontFamily: 'Hind', color: Colors.white),
                            )),
                            DataColumn(
                                label: Text(
                              'Product Sales',
                              style: TextStyle(
                                  fontFamily: 'Hind', color: Colors.white),
                            )),
                            DataColumn(
                                label: Text(
                              'Ratings',
                              style: TextStyle(
                                  fontFamily: 'Hind', color: Colors.white),
                            )),
                          ],
                          rows: List.generate(snapshot.data!.docs.length,
                              (index) {
                            MarketModel marketModel = MarketModel.fromMap(
                                snapshot.data!.docs[index].data());
                            return DataRow(key: UniqueKey(), cells: [
                              DataCell(Text('${index + 1}')),
                              DataCell(Row(
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage:
                                        NetworkImage(marketModel.imageUrl),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(marketModel.marketName),
                                ],
                              )),
                              DataCell(Text(marketModel.category)),
                              const DataCell(Text('0')),
                              DataCell(StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('orders')
                                      .where('marketId',
                                          arrayContains: marketModel.uid)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    double totalRevenue = 0;
                                    if (snapshot.hasData) {
                                      if (snapshot.data!.docs.isEmpty) {
                                        return const Text('0');
                                      }
                                      for (int i = 0;
                                          i < snapshot.data!.docs.length;
                                          i++) {
                                        final data = snapshot.data!.docs[i];
                                        totalRevenue += data['totalPrice'];
                                      }
                                      return Text('\$$totalRevenue');
                                    } else {
                                      return const Text('0');
                                    }
                                  })),
                              marketModel.subscription!.status == false
                                  ? const DataCell(Text('Subscription Expired'))
                                  : DataCell(
                                      Text(marketModel.subscription!.title)),
                              DataCell(StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('orders')
                                      .where('marketId',
                                          arrayContains: marketModel.uid)
                                      // .doc(data['productIds'][0])
                                      .snapshots(),
                                  builder: (context, snapshot1) {
                                    return snapshot1.hasData
                                        ? SingleChildScrollView(
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: List.generate(
                                                    snapshot1.data!.docs.length,
                                                    (index) {
                                                  final data1 = snapshot1
                                                      .data!.docs[index];
                                                  return StreamBuilder(
                                                      stream: FirebaseFirestore
                                                          .instance
                                                          .collection(
                                                              'products')
                                                          .where('id',
                                                              whereIn: data1[
                                                                  'productIds'])
                                                          .snapshots(),
                                                      builder:
                                                          (context, snapshot2) {
                                                        return snapshot2.hasData
                                                            ? SingleChildScrollView(
                                                                child: Column(
                                                                    children: List.generate(
                                                                        snapshot2
                                                                            .data!
                                                                            .docs
                                                                            .length,
                                                                        (index) {
                                                                  if (snapshot2
                                                                      .data!
                                                                      .docs
                                                                      .isEmpty) {
                                                                    return const Text(
                                                                        'No Products Found');
                                                                  } else {
                                                                    final data =
                                                                        snapshot2
                                                                            .data!
                                                                            .docs[index];
                                                                    return Text(
                                                                        '${data['name']}');
                                                                  }
                                                                })),
                                                              )
                                                            : const Center(
                                                                child:
                                                                    CircularProgressIndicator());
                                                      });
                                                })),
                                          )
                                        : const Center(
                                            child: CircularProgressIndicator());
                                  })),
                              DataCell(
                                marketModel.ratings == 0
                                    ? const Text('0')
                                    : Row(
                                        children: List.generate(
                                          double.parse(marketModel.ratings
                                                  .toString()
                                                  .substring(0, 1))
                                              .toInt(),
                                          (index) => const Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          ),
                                        ),
                                      ),
                              ),
                            ]);
                          }),
                        ),
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      );
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}

// class MyDropdown extends StatefulWidget {
//   @override
//   _MyDropdownState createState() => _MyDropdownState();
// }

// class _MyDropdownState extends State<MyDropdown> {
//   // The list of items for the dropdown
//   List<String> items = [
//     'Allow Permission',
//     'Not Allow',
//     'Select Permission',
//   ];

//   // The currently selected item
//   String selectedItem = 'Allow Permission';

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       value: selectedItem,
//       onChanged: (String? newValue) {
//         setState(() {
//           selectedItem = newValue!;
//         });
//       },
//       items: items.map((String item) {
//         return DropdownMenuItem<String>(
//           value: item,
//           child: Text(item,style: TextStyle(color: ),),
//         );
//       }).toList(),
//     );
//   }
// }
