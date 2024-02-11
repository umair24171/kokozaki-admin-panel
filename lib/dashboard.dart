// ignore_for_file: use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kokzaki_admin_panel/helper/colors.dart';
import 'package:kokzaki_admin_panel/screens/analytics_screen.dart';
import 'package:kokzaki_admin_panel/screens/chat_screen.dart';
import 'package:kokzaki_admin_panel/screens/login_screen.dart';
import 'package:kokzaki_admin_panel/screens/payments_screen.dart';
import 'package:kokzaki_admin_panel/screens/super_markets_screen.dart';
import 'package:kokzaki_admin_panel/screens/user_buyer_data_screen.dart';
import 'package:kokzaki_admin_panel/screens/user_roles_permissions.dart';
import 'package:sidebarx/sidebarx.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});
  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      key: _key,
      appBar: isSmallScreen
          ? AppBar(
              backgroundColor: Colors.white,
              title: Text(_getTitleByIndex(_controller.selectedIndex)),
              leading: IconButton(
                onPressed: () {
                  // if (!Platform.isAndroid && !Platform.isIOS) {
                  //   _controller.setExtended(true);
                  // }
                  _key.currentState?.openDrawer();
                },
                icon: const Icon(Icons.menu),
              ),
            )
          : null,
      drawer: SidebarItems(controller: _controller),
      body: Row(
        children: [
          if (!isSmallScreen) SidebarItems(controller: _controller),
          Expanded(
            child: Center(
              child: SidebarScreens(
                controller: _controller,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SidebarItems extends StatelessWidget {
  const SidebarItems({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;

  @override
  Widget build(BuildContext context) {
    return SidebarX(
      controller: _controller,
      theme: SidebarXTheme(
        margin: const EdgeInsets.all(20), // Removed margin to minimize spacing
        decoration: const BoxDecoration(
          color: Color(0xff26A8ED),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(0),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        hoverTextStyle: const TextStyle(
          color: Colors.white,
          fontFamily: 'Hind',
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
        textStyle: const TextStyle(
          color: Colors.white,
          fontFamily: 'Hind',
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
        selectedTextStyle: TextStyle(
          color: primaryColor,
          fontFamily: 'Hind',
          fontWeight: FontWeight.w500,
          fontSize: 17,
        ),
        itemTextPadding: const EdgeInsets.only(left: 20),
        selectedItemTextPadding: const EdgeInsets.only(left: 20),
        itemDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        selectedItemDecoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(0),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
        selectedIconTheme: IconThemeData(
          color: primaryColor,
          size: 20,
        ),
      ),
      extendedTheme: const SidebarXTheme(
        width: 250,
        decoration: BoxDecoration(
          color: Color(0xff3ea7d5),
          gradient: LinearGradient(
            colors: [Color(0xff26A8ED), Color(0xff6CC3E8)],
          ),
        ),
      ),
      headerBuilder: (context, extended) {
        return SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQhHDkrsXcQg5G2k-2zXv91GX36h1v2GEGVVk5moI1aFO-03WqIpA0HRXrzklJmk2LMIBg&usqp=CAU',
            ),
          ),
        );
      },
      items: const [
        SidebarXItem(
          icon: Icons.home,
          label: 'Dashboard',
        ),
        SidebarXItem(
          icon: Icons.person_2_outlined,
          label: 'User Buyer Data',
        ),
        SidebarXItem(
          icon: Icons.store,
          label: 'Super Markets',
        ),
        SidebarXItem(
          icon: Icons.construction_outlined,
          label: 'Access Controls',
        ),
        SidebarXItem(
          icon: Icons.refresh_rounded,
          label: 'Payment Refund ',
        ),
        SidebarXItem(
          icon: Icons.chat_bubble_outline_outlined,
          label: 'Chat System',
        ),
      ],
      footerBuilder: (context, extended) {
        // return SidebarXItem();
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (value) => false);
            },
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: whiteColor, borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.power_settings_new_outlined,
                      color: primaryColor,
                      size: 24,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (extended)
                      Text(
                        'Logout',
                        style: TextStyle(
                            fontFamily: 'Hind',
                            fontSize: 14,
                            color: primaryColor),
                      )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

String _getTitleByIndex(int index) {
  switch (index) {
    case 0:
      return 'Dashboard';
    case 1:
      return 'User Buyer Data';
    case 2:
      return 'Subscription Packages';
    // case 3:
    //   return 'Affiliate Program';
    // case 4:
    //   return 'Users Loyality Program';
    case 3:
      return 'Deals';
    // case 6:
    //   return 'Orders';
    // case 7:
    //   return 'Products';
    // case 8:
    //   return 'Categories';
    // case 9:
    //   return 'Access Controls';
    // case 10:
    //   return 'Subscription Management';
    default:
      return 'Not found page';
  }
}

class SidebarScreens extends StatelessWidget {
  const SidebarScreens({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final pageTitle = _getTitleByIndex(controller.selectedIndex);
        switch (controller.selectedIndex) {
          case 0:
            return AnalyticsScreen();
          case 1:
            return const UserBuyerData();
          case 2:
            return SuperMarkets();
          // case 3:
          //   return const AffiliateMarketScreen();
          // case 4:
          //   return const UsersloyalityPogram();
          case 3:
            return const UserRolesPermissions();
          case 4:
            return const RefundRequests();
          case 5:
            return const ChatScreen();
          default:
            return Text(
              pageTitle,
              style: theme.textTheme.headlineSmall,
            );
        }
      },
    );
  }
}
