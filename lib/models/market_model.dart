import 'dart:convert';
import 'package:kokzaki_admin_panel/models/subscription_model.dart';

class MarketModel {
  final String uid;
  final String marketName;
  final String email;
  final String password;
  bool isAdmin;
  bool status;
  String imageUrl;
  String category;
  SubscriptionModel? subscription;
  double ratings;

  MarketModel(
      {required this.uid,
      required this.marketName,
      required this.email,
      required this.password,
      required this.isAdmin,
      required this.imageUrl,
      required this.status,
      required this.category,
      required this.ratings,
      this.subscription});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'marketName': marketName,
      'email': email,
      'password': password,
      'isAdmin': isAdmin,
      'imageUrl': imageUrl,
      'status': status,
      'category': category,
      'ratings': ratings,
      'subscription': subscription?.toMap() ?? ''
    };
  }

  factory MarketModel.fromMap(Map<String, dynamic> map) {
    return MarketModel(
        uid: map['uid'] ?? '',
        marketName: map['marketName'] ?? '',
        email: map['email'] ?? '',
        password: map['password'] ?? '',
        isAdmin: map['isAdmin'] ?? false,
        status: map['status'] ?? false,
        category: map['category'] ?? '',
        ratings: map['ratings'] ?? 0.0,
        imageUrl: map['imageUrl'] ??
            'https://www.shutterstock.com/image-vector/user-profile-icon-vector-avatar-600nw-2220431045.jpg',
        subscription: map['subscription'] != ''
            ? SubscriptionModel.fromMap(
                map['subscription'] as Map<String, dynamic>)
            : SubscriptionModel(
                id: 'No id Found',
                title: 'Subscription Expired',
                description: 'Subscription Expired',
                price: 0 as double,
                duration: DateTime.now(),
                status: false,
              ));
  }
  // static MarketModel fromSNap(DocumentSnapshot snapshot) {
  //   Object snap = snapshot.data() as Map<String, dynamic>;
  //   return MarketModel(
  //       uid: (snap as Map<String, dynamic>)['uid'],
  //       marketName: snap['marketName'],
  //       email: snap['email'],
  //       password: snap['password'],
  //       isAdmin: snap['isAdmin'],
  //       imageUrl: snap['imageUrl'],
  //       subscription: snap['subscription']);
  // }

  String toJson() => json.encode(toMap());

  factory MarketModel.fromJson(String source) =>
      MarketModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
