import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/sippo_pages/sippo_company_pages/sippo_company_home.dart';

import '../../sippo_themes/themecontroller.dart';

class SippoCompanyDashboard extends StatefulWidget {
  const SippoCompanyDashboard({Key? key}) : super(key: key);

  @override
  State<SippoCompanyDashboard> createState() => _SippoCompanyDashboardState();
}

class _SippoCompanyDashboardState extends State<SippoCompanyDashboard> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;

  final themedata = Get.put(JobstopThemecontroler());

  int _selectedItemIndex = 0;

  final List<Widget> _pages = const [SippoCompanyHomePage()];

  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Widget _bottomTabBar() {
    return BottomNavigationBar(
      currentIndex: _selectedItemIndex,
      onTap: _onTap,
      backgroundColor: Jobstopcolor.transparent,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      fixedColor: themedata.isdark ? Jobstopcolor.white : Jobstopcolor.grey,
      elevation: 0,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Image.asset(
            JobstopPngImg.home,
            height: height / 36,
          ),
          activeIcon: Image.asset(
            JobstopPngImg.home,
            height: height / 36,
            color: themedata.isdark
                ? Jobstopcolor.white
                : Jobstopcolor.primarycolor,
          ),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            JobstopPngImg.posting,
            height: height / 36,
          ),
          activeIcon: Image.asset(JobstopPngImg.posting,
              height: height / 36,
              color: themedata.isdark
                  ? Jobstopcolor.white
                  : Jobstopcolor.primarycolor),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            JobstopPngImg.message,
            height: height / 36,
          ),
          activeIcon: Image.asset(JobstopPngImg.message,
              height: height / 36,
              color: themedata.isdark
                  ? Jobstopcolor.white
                  : Jobstopcolor.primarycolor),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            JobstopPngImg.order,
            height: height / 36,
          ),
          activeIcon: Image.asset(JobstopPngImg.order,
              height: height / 36,
              color: themedata.isdark
                  ? Jobstopcolor.white
                  : Jobstopcolor.primarycolor),
          label: '',
        ),
      ],
    );
  }

  void _onTap(int index) {
    // setState(() {
      _selectedItemIndex = 0;
    // });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      bottomNavigationBar: _bottomTabBar(),
      body: _pages[_selectedItemIndex],
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {},
        backgroundColor: Jobstopcolor.primarycolor,
        child: const Icon(
          Icons.add,
          size: 20,
          color: Jobstopcolor.white,
        ),
      ),
    );
  }
}
