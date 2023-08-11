import 'package:flutter/material.dart';
import 'package:jobspot/JobGlobalclass/jobstopcolor.dart';
import 'package:jobspot/JobGlobalclass/jobstopfontstyle.dart';

import '../Jopstobdata/model/profile_model/jobstop_language_info_card_model.dart';

class LanguageCardInfoView extends StatelessWidget {
  final LanguageInfoCardModel? licm;
  final Function onDelete;

  const LanguageCardInfoView({this.licm, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Container(
      padding: EdgeInsets.all(height / 52),
      decoration: BoxDecoration(
          color: Jobstopcolor.white,
          borderRadius: BorderRadius.circular(height / 32)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: Container(
              width: height / 18,
              height: height / 18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                  image: AssetImage(licm?.countryFlag ?? ""),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(licm?.languageName ?? ""),
            trailing: IconButton(
              icon: Icon(
                Icons.delete_outline,
                color: Colors.redAccent,
                size: height / 25,
              ),
              onPressed: () => onDelete(),
            ),
          ),
          SizedBox(height: height / 64),
          Row(
            children: [
              SizedBox(width: width / 26),
              Icon(
                Icons.volume_up,
                color: Colors.grey,
              ),
              SizedBox(width: 4),
              Text(
                licm?.talkingLevel ?? "",
                style: dmsregular.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: height / 64),
          Row(
            children: [
              SizedBox(width: width / 26),
              Icon(
                Icons.create,
                color: Colors.grey,
              ),
              SizedBox(width: 4),
              Text(
                licm?.writtenLevel ?? "",
                style: dmsregular.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
