import 'package:flutter/material.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopfontstyle.dart';
import 'package:sippo/JobGlobalclass/jobstopimges.dart';

import '../sippo_data/model/profile_model/profile_resource_model/language_model.dart';

class LanguageCardInfoView extends StatelessWidget {
  final LanguageModel? lang;
  final Function onDelete;

  const LanguageCardInfoView({this.lang, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Container(
      padding: EdgeInsets.all(height / 52),
      decoration: BoxDecoration(
          color: SippoColor.white,
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
                  colorFilter: lang?.countryFlag == null
                      ? ColorFilter.mode(
                          SippoColor.primarycolor,
                          BlendMode.srcIn,
                        )
                      : null,
                  image: AssetImage(
                    lang?.countryFlag ?? JobstopPngImg.language,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            title: Text(lang?.name ?? ""),
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
                Icons.star_half_rounded,
                color: Colors.grey,
              ),
              SizedBox(width: 4),
              Text(
                lang?.level ?? "",
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
