import 'package:flutter/material.dart';

import '../../../JobGlobalclass/jobstopcolor.dart';

class ShowCompanyJobsList extends StatelessWidget {
 const ShowCompanyJobsList({super.key});

  // final _controller = <  >

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return RefreshIndicator(
      onRefresh: () async {},
      child: GridView.builder(
        itemCount: 5,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          childAspectRatio: 2 / 2.2,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            // onTap: () => Get.to(() => const JobstopAbouts()),
            child: SizedBox(
              width: width / 2.3,
              height: height / 6,
              child: Card(
                color: Jobstopcolor.primary,
              ),
            ),
          );
        },
      ),
    );
  }
}
