import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kokzaki_admin_panel/helper/colors.dart';

// import 'package:kokzaki_admin_panel/helper/colors.dart';

class UserBuyerData extends StatelessWidget {
  const UserBuyerData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(16),
            child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('orders').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No Orders Found'));
                    }
                    return SingleChildScrollView(
                      child: DataTable(
                          showBottomBorder: true,
                          // border: const TableBorder(
                          //     right: BorderSide(width: 1),
                          //     left: BorderSide(width: 1),
                          //     top: BorderSide(width: 1),
                          //     bottom: BorderSide(width: 1)),
                          columnSpacing: 30,
                          dividerThickness: 2,
                          dataRowHeight: 80,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 2)),
                          // showCheckboxColumn: true,
                          // sortColumnIndex: 1,
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
                              'Account',
                              style: TextStyle(
                                  fontFamily: 'Hind', color: Colors.white),
                            )),
                            DataColumn(
                              label: Text(
                                'Products Name',
                                style: TextStyle(
                                    fontFamily: 'Hind', color: Colors.white),
                              ),
                            ),
                            DataColumn(
                                label: Text(
                              'Items',
                              style: TextStyle(
                                  fontFamily: 'Hind', color: Colors.white),
                            )),
                            DataColumn(
                                label: Text(
                              'Prices',
                              style: TextStyle(
                                  fontFamily: 'Hind', color: Colors.white),
                            )),
                            DataColumn(
                                label: Text(
                              'Refferal Link',
                              style: TextStyle(
                                  fontFamily: 'Hind', color: Colors.white),
                            )),
                            DataColumn(
                                label: Text(
                              'Super Market',
                              style: TextStyle(
                                  fontFamily: 'Hind', color: Colors.white),
                            )),
                            DataColumn(
                                label: Text(
                              'Status',
                              style: TextStyle(
                                  fontFamily: 'Hind', color: Colors.white),
                            )),
                          ],
                          rows: List.generate(snapshot.data!.docs.length,
                              (index) {
                            final data = snapshot.data!.docs[index].data();
                            return DataRow(
                                key: UniqueKey(),
                                selected: true,
                                cells: [
                                  DataCell(Text('${index + 1}')),
                                  DataCell(Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(data['userName']),
                                      Text(data['email'])
                                    ],
                                  )),
                                  DataCell(StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('products')
                                          .where('id',
                                              whereIn: data['productIds'])
                                          // .doc(data['productIds'][0])
                                          .snapshots(),
                                      builder: (context, snapshot1) {
                                        return snapshot1.hasData
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: List.generate(
                                                    snapshot1.data!.docs.length,
                                                    (index) {
                                                  final data1 = snapshot1
                                                      .data!.docs[index];
                                                  return Text(
                                                      '${data1['name']}');
                                                }))
                                            : const Center(
                                                child:
                                                    CircularProgressIndicator());
                                      })),
                                  DataCell(Text('${data['quantity']} items')),
                                  DataCell(Text('\$ ${data['totalPrice']}')),
                                  DataCell(Text('${data['referalLink']}')),
                                  DataCell(StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection('sellers')
                                          .where('uid',
                                              whereIn: data['marketId'])
                                          .snapshots(),

                                      // .doc(data['productIds'][0])

                                      builder: (context, snapshot1) {
                                        if (snapshot1.hasData) {
                                          final data1 =
                                              snapshot1.data!.docs.first.data();
                                          return Text('${data1['marketName']}');
                                        } else {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                      })),
                                  data['status'] == 0
                                      ? const DataCell(Text(
                                          'Pending',
                                          style: TextStyle(color: Colors.green),
                                        ))
                                      : data['status'] == 1
                                          ? const DataCell(Text(
                                              'Completed',
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            ))
                                          : const DataCell(Text(
                                              'Cancelled',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            )),
                                ]);
                          })

                          // Add more DataRow widgets for additional rows
                          ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ))
        ],
      ),
    );
  }
}
