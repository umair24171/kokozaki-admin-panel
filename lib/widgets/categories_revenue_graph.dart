import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kokzaki_admin_panel/helper/colors.dart';
import 'package:kokzaki_admin_panel/models/market_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CategoryRevenueGraph extends StatefulWidget {
  const CategoryRevenueGraph({Key? key});

  @override
  State<CategoryRevenueGraph> createState() => _CategoryRevenueGraphState();
}

class _CategoryRevenueGraphState extends State<CategoryRevenueGraph> {
  List<String> categoriesList = [
    'Fashion & Cosmetics',
    'Sport',
    'Kids',
    'Electronics',
    'Home'
  ];
  List<String> fashionMarkets = [];
  List<String> sportMarkets = [];
  List<String> kidsMarkets = [];
  List<String> electronicsMarkets = [];
  List<String> homeMarkets = [];

  // Dummy data for demonstration
  List<CategoryData> categoryRevenueData = [];
  checkMarketsBasedOnCategory() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('sellers').get();
    for (var category in categoriesList) {
      for (var doc in snapshot.docs) {
        MarketModel market = MarketModel.fromMap(doc.data());
        if (market.category == category) {
          if (category == 'Fashion & Cosmetics') {
            fashionMarkets.add(market.uid);
          } else if (category == 'Sport') {
            sportMarkets.add(market.uid);
          } else if (category == 'Kids') {
            kidsMarkets.add(market.uid);
          } else if (category == 'Electronics') {
            electronicsMarkets.add(market.uid);
          } else if (category == 'Home') {
            homeMarkets.add(market.uid);
          }
        }
        setState(() {});
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkMarketsBasedOnCategory();
  }

  Future<List<CategoryData>> getRevenueBasedOnCategory() async {
    for (var category in categoriesList) {
      double revenue = 0;
      if (category == 'Fashion & Cosmetics') {
        for (var market in fashionMarkets) {
          QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
              .instance
              .collection('orders')
              .where('marketId', arrayContains: market)
              .get();
          for (var doc in snapshot.docs) {
            Map<String, dynamic> data = doc.data();
            revenue += data['totalPrice'];
          }
        }
        categoryRevenueData.add(CategoryData(category, revenue));
      } else if (category == 'Sport') {
        for (var market in sportMarkets) {
          QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
              .instance
              .collection('orders')
              .where('marketId', arrayContains: market)
              .get();
          for (var doc in snapshot.docs) {
            Map<String, dynamic> data = doc.data();
            revenue += data['totalPrice'];
          }
        }
        categoryRevenueData.add(CategoryData(category, revenue));
      } else if (category == 'Kids') {
        for (var market in kidsMarkets) {
          QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
              .instance
              .collection('orders')
              .where('marketId', arrayContains: market)
              .get();
          for (var doc in snapshot.docs) {
            Map<String, dynamic> data = doc.data();
            revenue += data['totalPrice'];
          }
        }
        categoryRevenueData.add(CategoryData(category, revenue));
      } else if (category == 'Electronics') {
        for (var market in electronicsMarkets) {
          QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
              .instance
              .collection('orders')
              .where('marketId', arrayContains: market)
              .get();
          for (var doc in snapshot.docs) {
            Map<String, dynamic> data = doc.data();
            revenue += data['totalPrice'];
          }
        }
        categoryRevenueData.add(CategoryData(category, revenue));
      } else if (category == 'Home') {
        for (var market in homeMarkets) {
          QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
              .instance
              .collection('orders')
              .where('marketId', arrayContains: market)
              .get();
          for (var doc in snapshot.docs) {
            Map<String, dynamic> data = doc.data();
            revenue += data['totalPrice'];
          }
          categoryRevenueData.add(CategoryData(category, revenue));
        }
      }
    }
    return categoryRevenueData;
  }

  @override
  Widget build(BuildContext context) {
    log('Fashion Markets: $fashionMarkets , Sport Markets: $sportMarkets , Kids Markets: $kidsMarkets , Electronics Markets: $electronicsMarkets , Home Markets: $homeMarkets');
    return FutureBuilder<List<CategoryData>>(
      future: getRevenueBasedOnCategory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SpinKitThreeBounce(
            size: 30,
            color: primaryColor,
          ); // Or any other loading indicator
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Card(
            child: SfCircularChart(
              title: ChartTitle(text: 'Category Revenue'),
              legend: const Legend(
                  isVisible: true,
                  overflowMode: LegendItemOverflowMode.wrap,
                  position: LegendPosition.bottom),
              series: <CircularSeries>[
                PieSeries<CategoryData, String>(
                  radius: '100%',
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                  dataSource: snapshot.data,
                  xValueMapper: (CategoryData data, _) => data.category,
                  yValueMapper: (CategoryData data, _) => data.revenue,
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class CategoryData {
  CategoryData(this.category, this.revenue);
  final String category;
  final double revenue;
}
