import 'package:flutter/material.dart';
import 'package:kokzaki_admin_panel/helper/colors.dart';
import 'package:kokzaki_admin_panel/widgets/package_container.dart';

class PackagesScreen extends StatefulWidget {
  const PackagesScreen({super.key});

  @override
  State<PackagesScreen> createState() => _PackagesScreenState();
}

class _PackagesScreenState extends State<PackagesScreen> {
  bool isMonthly = true;

  bool isYearly = false;

  List<PackageDetails> basicPackage = [
    const PackageDetails(packageDetails: 'free to join'),
    const PackageDetails(packageDetails: 'sell products')
  ];

  List<PackageDetails> standordPackage = [
    const PackageDetails(packageDetails: 'sell products'),
    const PackageDetails(
        packageDetails: 'Get Access to user buyer behaviour data '),
    const PackageDetails(
        packageDetails: 'get access to offer personalized deals'),
  ];

  List<PackageDetails> professionalPackage = [
    const PackageDetails(packageDetails: 'sell products'),
    const PackageDetails(
        packageDetails: 'Get Access to user buyer behaviour data '),
    const PackageDetails(
        packageDetails: 'get access to offer personalized deals'),
    const PackageDetails(packageDetails: 'get access to extend those deals'),
    const PackageDetails(
        packageDetails: 'get access to generate 5 refferal links'),
  ];
  List<PackageDetails> bigBusinessPackage = [
    const PackageDetails(packageDetails: 'sell products'),
    const PackageDetails(
        packageDetails: 'Get Access to user buyer behaviour data '),
    const PackageDetails(
        packageDetails: 'get access to offer personalized deals'),
    const PackageDetails(packageDetails: 'get access to extend those deals'),
    const PackageDetails(
        packageDetails: 'get access to generate unlimited refferal links'),
    const PackageDetails(
        packageDetails: 'get access to see the data of other buyers'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35)),
                color: whiteColor,
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(35)),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isMonthly = true;
                            isYearly = false;
                          });
                        },
                        child: Card(
                          elevation: 2,
                          shadowColor: Colors.white,
                          child: Container(
                            decoration: BoxDecoration(
                                color: isYearly ? whiteColor : primaryColor,
                                borderRadius: BorderRadius.circular(35)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Pay Monthly',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: isYearly ? Colors.black : whiteColor,
                                    fontFamily: 'Hind'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isMonthly = false;
                            isYearly = true;
                          });
                        },
                        child: Card(
                          elevation: 2,
                          shadowColor: Colors.white,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(35),
                              color: isYearly ? primaryColor : whiteColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Pay Yearly(25%)',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: isYearly ? whiteColor : Colors.black,
                                    fontFamily: 'Hind'),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            if (isMonthly)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PackageContainer(
                      packageTitle: 'Basic',
                      buttonText: 'Free To Use',
                      price: 0,
                      callback: () {},
                      isYearly: isYearly,
                      packageDetails: basicPackage),
                  PackageContainer(
                      packageTitle: 'Standard',
                      buttonText: 'Register Now',
                      price: 10,
                      isYearly: isYearly,
                      callback: () {},
                      packageDetails: standordPackage),
                ],
              ),
            const SizedBox(
              height: 20,
            ),
            if (isMonthly)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PackageContainer(
                      packageTitle: 'Professional',
                      buttonText: 'Register Now',
                      price: 33,
                      isYearly: isYearly,
                      callback: () {},
                      packageDetails: professionalPackage),
                  PackageContainer(
                      packageTitle: 'Big Business',
                      buttonText: 'Register Now',
                      price: 120,
                      callback: () {},
                      isYearly: isYearly,
                      packageDetails: bigBusinessPackage),
                ],
              ),
            if (isMonthly)
              const SizedBox(
                height: 50,
              ),
            if (isYearly)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PackageContainer(
                      packageTitle: 'Basic',
                      buttonText: 'Free To Use',
                      price: 0,
                      callback: () {},
                      isYearly: isYearly,
                      packageDetails: basicPackage),
                  PackageContainer(
                      packageTitle: 'Standard',
                      buttonText: 'Register Now',
                      price: 10,
                      isYearly: isYearly,
                      callback: () {},
                      packageDetails: standordPackage),
                ],
              ),
            const SizedBox(
              height: 20,
            ),
            if (isYearly)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PackageContainer(
                      packageTitle: 'Professional',
                      buttonText: 'Register Now',
                      price: 33,
                      isYearly: isYearly,
                      callback: () {},
                      packageDetails: professionalPackage),
                  PackageContainer(
                      packageTitle: 'Big Business',
                      buttonText: 'Register Now',
                      price: 120,
                      callback: () {},
                      isYearly: isYearly,
                      packageDetails: bigBusinessPackage),
                ],
              ),
            if (isYearly)
              const SizedBox(
                height: 50,
              ),
          ],
        ),
      ),
    );
  }
}
