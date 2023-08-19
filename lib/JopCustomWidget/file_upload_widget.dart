import 'package:flutter/material.dart';
import 'package:jobspot/JopCustomWidget/resume_card_widget.dart';
import '../JobGlobalclass/jobstopcolor.dart';
import '../JobGlobalclass/jobstopfontstyle.dart';
import '../JobGlobalclass/text_font_size.dart';
import '../sippo_data/model/profile_model/jobstop_resume_file_info.dart';

class DottedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final dashWidth = 5;
    final dashSpace = 5;
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }

    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashWidth), paint);
      startY += dashWidth + dashSpace;
    }

    double endX = size.width;
    while (endX > 0) {
      canvas.drawLine(Offset(endX, size.height),
          Offset(endX - dashWidth, size.height), paint);
      endX -= dashWidth + dashSpace;
    }

    double endY = size.height;
    while (endY > 0) {
      canvas.drawLine(Offset(size.width, endY),
          Offset(size.width, endY - dashWidth), paint);
      endY -= dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class FileUploadWidget extends StatelessWidget {
  final void Function() onUploadTapped;
  final ResumeFileInfo? resume;
  final void Function() onDeletedFile;
  final bool isUploaded;
  final String title;

  FileUploadWidget({
    required this.onUploadTapped,
    this.resume,
    required this.title,
    required this.onDeletedFile,
    required this.isUploaded,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    return GestureDetector(
      onTap: !isUploaded ? onUploadTapped : null,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isUploaded ? Jobstopcolor.lightprimary3 : null,
        ),
        child: CustomPaint(
          painter: DottedBorderPainter(),
          child: Padding(
            padding: EdgeInsets.all(width / 12),
            child: !isUploaded
                ? _buildTapToBrowseFile(context)
                : _buildResumeCardWidget(context),
          ),
        ),
      ),
    );
  }

  Column _buildResumeCardWidget(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    return Column(
      children: [
        ResumeCardWidget(),
        SizedBox(height: height / 95),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: TextButton.icon(
            onPressed: () {
              onDeletedFile();
            },
            icon: Icon(
              Icons.delete_forever_outlined,
              color: Colors.redAccent,
            ),
            label: Text(
              "Remove Resume",
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        )
      ],
    );
  }

  Column _buildTapToBrowseFile(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.cloud_upload,
          size: width / 8,
          color: Colors.black.withOpacity(0.3),
        ),
        SizedBox(height: height / 95),
        Text(
          title,
          style: dmsbold.copyWith(fontSize: FontSize.titleFontSize4(context)),
        ),
        SizedBox(height: height / 225),
        Text(
          'Tap to browse',
          style: dmsregular.copyWith(
            fontSize: FontSize.titleFontSize5(context),
          ),
        ),
      ],
    );
  }
}
