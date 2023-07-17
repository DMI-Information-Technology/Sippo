import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopimges.dart';
import 'package:jobspot/JobThemes/themecontroller.dart';
import 'package:jobspot/Jobstoppages/Jobhomepages/jobstop_home.dart';
import 'package:jobspot/Jobstoppages/Jobmessgepages/jobstop_messageing.dart';
import 'package:jobspot/Jobstoppages/Jobpostpages/jobstop_posting.dart';

import '../Joborderpages/jobstop_oderpage.dart';

class JobDashboard extends StatefulWidget {
  const JobDashboard({Key? key}) : super(key: key);

  @override
  State<JobDashboard> createState() => _JobDashboardState();
}

class _JobDashboardState extends State<JobDashboard> {
  dynamic size;
  double height = 0.00;
  double width = 0.00;

  final themedata = Get.put(JobstopThemecontroler());

  int _selectedItemIndex = 0;

  final List<Widget> _pages = const [
    JobstopHome(),
    JobstopPosting(),
    JobMessageing(),
    JobstopOrder(),
  ];

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
          icon: Image.asset(JobstopPngImg.home,height: height/36,),
          activeIcon:Image.asset(JobstopPngImg.home,height: height/36,color:themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor ,),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(JobstopPngImg.posting,height: height/36,),
          activeIcon:Image.asset(JobstopPngImg.posting,height: height/36,color:themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(JobstopPngImg.message,height: height/36,),
          activeIcon:Image.asset(JobstopPngImg.message,height: height/36,color:themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),
          label: "",
        ),
        BottomNavigationBarItem(
          icon: Image.asset(JobstopPngImg.order,height: height/36,),
          activeIcon: Image.asset(JobstopPngImg.order,height: height/36,color:themedata.isdark ? Jobstopcolor.white : Jobstopcolor.primarycolor),
          label: '',
        ),
      ],
    );
  }

  void _onTap(int index) {
    setState(() {
      _selectedItemIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      bottomNavigationBar: _bottomTabBar(),
      body: _pages[_selectedItemIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {},
        backgroundColor: Jobstopcolor.primarycolor,
        child: const Icon(Icons.add,size: 20,color: Jobstopcolor.white,),
      ),
    );
  }
}

