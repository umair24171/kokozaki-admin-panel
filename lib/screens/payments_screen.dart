import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kokzaki_admin_panel/helper/colors.dart';
import 'package:kokzaki_admin_panel/models/payment_refund.dart';

class RefundRequests extends StatelessWidget {
  const RefundRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('bankTransferRequest')
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
                            border: Border.all(color: Colors.white, width: 2)),
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
                            'Full Name',
                            style: TextStyle(
                                fontFamily: 'Hind', color: Colors.white),
                          )),
                          DataColumn(
                              label: Text(
                            'Total Amount',
                            style: TextStyle(
                                fontFamily: 'Hind', color: Colors.white),
                          )),
                          DataColumn(
                              label: Text(
                            'Bank Account no.',
                            style: TextStyle(
                                fontFamily: 'Hind', color: Colors.white),
                          )),
                          DataColumn(
                              label: Text(
                            'Bank',
                            style: TextStyle(
                                fontFamily: 'Hind', color: Colors.white),
                          )),
                          DataColumn(
                              label: Text(
                            'Request Date',
                            style: TextStyle(
                                fontFamily: 'Hind', color: Colors.white),
                          )),
                          DataColumn(
                              label: Text(
                            'Transfered Status',
                            style: TextStyle(
                                fontFamily: 'Hind', color: Colors.white),
                          )),
                        ],
                        rows:
                            List.generate(snapshot.data!.docs.length, (index) {
                          PaymentRefund paymentRefund = PaymentRefund.fromMap(
                              snapshot.data!.docs[index].data());
                          return DataRow(key: UniqueKey(), cells: [
                            DataCell(Text('${index + 1}')),
                            DataCell(
                              Text(paymentRefund.fullName),
                            ),
                            DataCell(Text('${paymentRefund.transferAmount}')),
                            DataCell(Text(paymentRefund.bankAccountNumber)),
                            DataCell(Text(paymentRefund.bankName)),
                            DataCell(Text('${paymentRefund.reqDate}')),
                            DataCell(PaymentApprovalDropdown(
                              status: paymentRefund.isTransferd,
                              reqId: paymentRefund.reqId,
                            )),
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
    );
  }
}

class PaymentApprovalDropdown extends StatefulWidget {
  PaymentApprovalDropdown(
      {super.key, required this.status, required this.reqId});
  bool status;
  String reqId;
  @override
  _PaymentApprovalDropdownState createState() =>
      _PaymentApprovalDropdownState();
}

class _PaymentApprovalDropdownState extends State<PaymentApprovalDropdown> {
  // The list of items for the dropdown
  List<String> items = ['Pending', 'Processed'];

  // The currently selected item
  String selectedItem = 'Select Permission';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.status == true ? 'Processed' : 'Pending',
      onChanged: (String? newValue) {
        // selectedItem = newValue!;
        // Move the code for updating Firestore inside the setState callback
        if (newValue == 'Processed') {
          FirebaseFirestore.instance
              .collection('bankTransferRequest')
              .doc(widget.reqId)
              .update({
            'isTransferd': true,
          });
        } else {
          FirebaseFirestore.instance
              .collection('bankTransferRequest')
              .doc(widget.reqId)
              .update({
            'isTransferd': false,
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
                color: widget.status ? Colors.green : Colors.red),
          ),
        );
      }).toList(),
    );
  }
}
