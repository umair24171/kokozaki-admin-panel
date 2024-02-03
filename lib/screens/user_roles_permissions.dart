import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kokzaki_admin_panel/helper/colors.dart';
import 'package:kokzaki_admin_panel/models/market_model.dart';

class UserRolesPermissions extends StatelessWidget {
  const UserRolesPermissions({super.key});
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
                            dataRowColor: const MaterialStatePropertyAll(
                                Color(0xffD4F2FF)),
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
                                'Access Level',
                                style: TextStyle(
                                    fontFamily: 'Hind', color: Colors.white),
                              )),
                              DataColumn(
                                  label: Text(
                                'Payment Status',
                                style: TextStyle(
                                    fontFamily: 'Hind', color: Colors.white),
                              )),
                              DataColumn(
                                  label: Text(
                                'Subscription Status',
                                style: TextStyle(
                                    fontFamily: 'Hind', color: Colors.white),
                              )),

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
                              // DataColumn(
                              //     label: Text(
                              //   'Status',
                              //   style: TextStyle(
                              //       fontFamily: 'Hind', color: Colors.white),
                              // )),
                              DataColumn(
                                label: Text(
                                  'User Access Level Permissions',
                                  style: TextStyle(
                                      fontFamily: 'Hind', color: Colors.white),
                                ),
                              ),
                            ],
                            rows: List.generate(snapshot.data!.docs.length,
                                (index) {
                              MarketModel marketModel = MarketModel.fromMap(
                                  snapshot.data!.docs[index].data());
                              return DataRow(
                                  key: UniqueKey(),
                                  selected: true,
                                  cells: [
                                    DataCell(Text('${index + 1}')),
                                    DataCell(Text(marketModel.marketName)),
                                    marketModel.subscription == null ||
                                            marketModel.subscription!.status ==
                                                false
                                        ? const DataCell(
                                            Text('No Subscription Purchased'))
                                        : DataCell(Text(
                                            marketModel.subscription!.title)),
                                    marketModel.subscription == null ||
                                            marketModel.subscription!.status ==
                                                false
                                        ? const DataCell(
                                            Text('No Subscription Purchased'),
                                          )
                                        : DataCell(Text(
                                            '\$${marketModel.subscription!.price}')),
                                    // const DataCell(Text('Registered')),
                                    marketModel.subscription!.status
                                        ? const DataCell(Text('Active'))
                                        : const DataCell(Text('Expired')),
                                    // const DataCell(Text('Chase Value')),
                                    DataCell(
                                        MyDropdown(marketModel: marketModel)),
                                  ]);
                            })),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
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

class MyDropdown extends StatefulWidget {
  const MyDropdown({super.key, required this.marketModel});
  final MarketModel? marketModel;
  @override
  _MyDropdownState createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  // The list of items for the dropdown
  List<String> items = [
    'Allow Permission',
    'Not Allow',
    'Select Permission',
  ];

  // The currently selected item
  String selectedItem = 'Select Permission';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.marketModel!.status ? 'Allow Permission' : 'Not Allow',
      onChanged: (String? newValue) {
        selectedItem = newValue!;
        // Move the code for updating Firestore inside the setState callback
        if (newValue == 'Allow Permission') {
          FirebaseFirestore.instance
              .collection('sellers')
              .doc(widget.marketModel!.uid)
              .update({
            'uid': widget.marketModel!.uid,
            'email': widget.marketModel!.email,
            'marketName': widget.marketModel!.marketName,
            'password': widget.marketModel!.password,
            'isAdmin': widget.marketModel!.isAdmin,
            'imageUrl': widget.marketModel!.imageUrl,
            'status': true,
            'subscription': {
              'id': widget.marketModel!.subscription!.id,
              'description': widget.marketModel!.subscription!.description,
              'status': widget.marketModel!.subscription!.status,
              'duration': widget.marketModel!.subscription!.duration,
              'price': widget.marketModel!.subscription!.price,
              'title': widget.marketModel!.subscription!.title,
            }
          });
        } else {
          FirebaseFirestore.instance
              .collection('sellers')
              .doc(widget.marketModel!.uid)
              .update({
            'uid': widget.marketModel!.uid,
            'email': widget.marketModel!.email,
            'marketName': widget.marketModel!.marketName,
            'password': widget.marketModel!.password,
            'isAdmin': widget.marketModel!.isAdmin,
            'imageUrl': widget.marketModel!.imageUrl,
            'status': false,
            'subscription': {
              'id': widget.marketModel!.subscription!.id,
              'description': widget.marketModel!.subscription!.description,
              'status': widget.marketModel!.subscription!.status,
              'duration': widget.marketModel!.subscription!.duration,
              'price': widget.marketModel!.subscription!.price,
              'title': widget.marketModel!.subscription!.title,
            }
          });
        }
        setState(() {});
      },
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(
            item,
            style: TextStyle(
                fontFamily: 'Hind',
                color: widget.marketModel!.status ? Colors.green : Colors.red),
          ),
        );
      }).toList(),
    );
  }
}
