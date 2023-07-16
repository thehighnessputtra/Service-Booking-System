import 'package:flutter/material.dart';
import 'package:service_booking_system/pages/form_booking/booking_page.dart';
import 'package:service_booking_system/pages/home/home_page.dart';
import 'package:service_booking_system/pages/jadwal_servis/jadwal_servis_page.dart';
import 'package:service_booking_system/pages/list_booking/list_booking_page.dart';

class NavigationBarUI extends StatefulWidget {
  NavigationBarUI({super.key, this.currentIndex = 0});
  int currentIndex;

  @override
  State<NavigationBarUI> createState() => _NavigationBarUIState();
}

class _NavigationBarUIState extends State<NavigationBarUI> {
  final List<Widget> screens = [
    const HomePage(),
    const JadwalServisPage(),
    const BookingPage(),
    const BookedPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[widget.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.lightGreen,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.white,
            iconSize: 25,
            currentIndex: widget.currentIndex,
            onTap: (index) => setState(() => widget.currentIndex = index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.schedule),
                label: 'Jadwal Servis',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.edit_document),
                label: 'Form Booking',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.document_scanner),
                label: 'List Booking',
              ),
            ]));
  }
}
