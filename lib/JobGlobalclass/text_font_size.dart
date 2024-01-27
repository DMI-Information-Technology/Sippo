import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//
// class FontSize {
//   static const double _labelSize = 32;
//
//   static const double _titleSize = 12;
//
//   static const double _paragraphSize = 24;
//
//   static const double _buttonFontSize = 18;
//
//   static double _targetPlatformFontSize(BuildContext context, double fSize) {
//     if (kIsWeb) {
//       print("from web");
//       return context.height / (fSize + 3);
//     }
//     switch (defaultTargetPlatform) {
//       case TargetPlatform.android:
//       case TargetPlatform.fuchsia:
//       case TargetPlatform.iOS:
//         return context.width / fSize;
//       case TargetPlatform.linux:
//       case TargetPlatform.macOS:
//       case TargetPlatform.windows:
//         return context.height / fSize;
//     }
//   }
//
//   FontSize._();
//
//   static double label(BuildContext context, [sizeLevel = 0]) {
//     return _targetPlatformFontSize(
//       context,
//       (_labelSize + (3 * sizeLevel)),
//     );
//   }
//
//   static double label2(BuildContext context) {
//     return _targetPlatformFontSize(context, (_labelSize + 3));
//   }
//
//   static double label3(BuildContext context) {
//     return _targetPlatformFontSize(context, (_labelSize + 6));
//   }
//
//   static double title(BuildContext context, [sizeLevel = 0]) {
//     return _targetPlatformFontSize(context, (_titleSize + (3 * sizeLevel)));
//   }
//
//   static double title2(BuildContext context) {
//     return _targetPlatformFontSize(context, (_titleSize + 3));
//   }
//
//   static double title3(BuildContext context) {
//     return _targetPlatformFontSize(context, (_titleSize + 6));
//   }
//
//   static double title4(BuildContext context) {
//     return _targetPlatformFontSize(context, (_titleSize + 9));
//   }
//
//   static double title5(BuildContext context) {
//     return _targetPlatformFontSize(context, (_titleSize + 12));
//   }
//
//   static double title6(BuildContext context) {
//     return _targetPlatformFontSize(context, (_titleSize + 16));
//   }
//
//   static double paragraph(BuildContext context, [sizeLevel = 0]) {
//     return _targetPlatformFontSize(context, (_paragraphSize + (3 * sizeLevel)));
//   }
//
//   static double paragraph2(BuildContext context) {
//     return _targetPlatformFontSize(context, (_paragraphSize + 3));
//   }
//
//   static double paragraph3(BuildContext context) {
//     return _targetPlatformFontSize(context, (_paragraphSize + 6));
//   }
//
//   static double paragraph4(BuildContext context) {
//     return _targetPlatformFontSize(context, (_paragraphSize + 9));
//   }
//
//   static double button(BuildContext context, [sizeLevel = 0]) {
//     return _targetPlatformFontSize(
//       context,
//       (_buttonFontSize + (3 * sizeLevel)),
//     );
//   }
//
//   static double button2(BuildContext context) {
//     return _targetPlatformFontSize(context, (_buttonFontSize + 3));
//   }
//
//   static double button3(BuildContext context) {
//     return _targetPlatformFontSize(context, (_buttonFontSize + 6));
//   }
// }
class FontSize {
  static const double _labelSize = 32;

  static const double _titleSize = 12;

  static const double _paragraphSize = 24;

  static const double _buttonFontSize = 18;

  static double _targetPlatformFontSize(BuildContext context, double fSize) {
    final size = MediaQuery.sizeOf(context);
    if (kIsWeb) {
      // print("from web");
      if (size.height > 630) return size.height /( fSize * 2);
      return context.height / (fSize + 3);
    }

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.iOS:
        if (size.height > 630) return size.height / (fSize * 2);
        return context.width / fSize;
      case TargetPlatform.linux:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        return context.height / fSize;
    }
  }

  FontSize._();

  static double label(BuildContext context, [sizeLevel = 0]) {
    return _targetPlatformFontSize(
      context,
      (_labelSize + (3 * sizeLevel)),
    );
  }

  static double label2(BuildContext context) {
    return _targetPlatformFontSize(context, (_labelSize + 3));
  }

  static double label3(BuildContext context) {
    return _targetPlatformFontSize(context, (_labelSize + 6));
  }

  static double title(BuildContext context, [sizeLevel = 0]) {
    return _targetPlatformFontSize(context, (_titleSize + (3 * sizeLevel)));
  }

  static double title2(BuildContext context) {
    return _targetPlatformFontSize(context, (_titleSize + 3));
  }

  static double title3(BuildContext context) {
    return _targetPlatformFontSize(context, (_titleSize + 6));
  }

  static double title4(BuildContext context) {
    return _targetPlatformFontSize(context, (_titleSize + 9));
  }

  static double title5(BuildContext context) {
    return _targetPlatformFontSize(context, (_titleSize + 12));
  }

  static double title6(BuildContext context) {
    return _targetPlatformFontSize(context, (_titleSize + 16));
  }

  static double paragraph(BuildContext context, [sizeLevel = 0]) {
    return _targetPlatformFontSize(context, (_paragraphSize + (3 * sizeLevel)));
  }

  static double paragraph2(BuildContext context) {
    return _targetPlatformFontSize(context, (_paragraphSize + 3));
  }

  static double paragraph3(BuildContext context) {
    return _targetPlatformFontSize(context, (_paragraphSize + 6));
  }

  static double paragraph4(BuildContext context) {
    return _targetPlatformFontSize(context, (_paragraphSize + 9));
  }

  static double button(BuildContext context, [sizeLevel = 0]) {
    return _targetPlatformFontSize(
      context,
      (_buttonFontSize + (3 * sizeLevel)),
    );
  }

  static double button2(BuildContext context) {
    return _targetPlatformFontSize(context, (_buttonFontSize + 3));
  }

  static double button3(BuildContext context) {
    return _targetPlatformFontSize(context, (_buttonFontSize + 6));
  }
}
