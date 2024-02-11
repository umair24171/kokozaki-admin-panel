import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:kokzaki_admin_panel/helper/colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class UserSalesGraph extends StatelessWidget {
  const UserSalesGraph({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('orders').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          List<ChartData> salesDataReferalFalse = [];
          List<ChartData> salesDataReferalTrue = [];

          for (var document in snapshot.data!.docs) {
            Map<String, dynamic> docData =
                document.data() as Map<String, dynamic>;
            String month =
                DateFormat('MMM').format(docData['orderDate'].toDate());

            if (docData['referalLink'] == true) {
              salesDataReferalTrue
                  .add(ChartData(month, docData['totalPrice'] as double));
            } else {
              salesDataReferalFalse
                  .add(ChartData(month, docData['totalPrice'] as double));
            }
          }

          return SfCartesianChart(
            // Chart title text
            // title: ChartTitle(text: 'Half yearly sales analysis'),
            // Initialize category axis
            primaryXAxis: CategoryAxis(),
            series: <CartesianSeries>[
              // Line series for orders where referalLink is false
              LineSeries<ChartData, String>(
                dataSource: salesDataReferalFalse,
                name: 'No Referal',
                xValueMapper: (ChartData salesData, _) => salesData.month,
                yValueMapper: (ChartData salesData, _) => salesData.sales,
              ),
              // Line series for orders where referalLink is true
              LineSeries<ChartData, String>(
                color: primaryColor,
                dataSource: salesDataReferalTrue,
                name: 'Referal',
                xValueMapper: (ChartData salesData, _) => salesData.month,
                yValueMapper: (ChartData salesData, _) => salesData.sales,
              )
            ],
          );
        },
      ),
    );
  }
}

class ChartData {
  ChartData(this.month, this.sales);
  final String month;
  final double sales;
}
