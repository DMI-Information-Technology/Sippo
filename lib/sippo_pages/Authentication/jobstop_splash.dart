import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sippo/JobGlobalclass/global_storage.dart';
import 'package:sippo/JobGlobalclass/jobstopcolor.dart';
import 'package:sippo/JobGlobalclass/jobstopimges.dart';
import 'package:sippo/JobGlobalclass/routes.dart';
import 'package:sippo/JobServices/ConnectivityController/internet_connection_controller.dart';
import 'package:sippo/sippo_custom_widget/widgets.dart';
import 'package:sippo/utils/app_use.dart';

class SippoSplash extends StatefulWidget {
  const SippoSplash({Key? key}) : super(key: key);

  @override
  State<SippoSplash> createState() => _SippoSplashState();
}

class _SippoSplashState extends State<SippoSplash> {
  int _alertCounter = 0;

  String _dashboardScreens() => switch (GlobalStorageService.appUse) {
        AppUsingType.user => SippoRoutes.userDashboard,
        AppUsingType.company => SippoRoutes.sippoCompanyDashboard,
        AppUsingType.guest => '',
      };

  String _entryScreen() => switch (GlobalStorageService.isAppLunchFirstTime) {
        true => SippoRoutes.onboarding,
        false => SippoRoutes.appUsingPage
      };

  Future<void> goToRoute() async {
    Future.doWhile(() async {
      if (_alertCounter >= 3) {
        await Get.dialog(
          CustomAlertDialog.verticalButtons(
            title: 'no_connection_title'.tr,
            description: 'no_connection_message'.tr,
            onConfirm: () => Get.back(),
          ),
        );
        _alertCounter = 0;
      }
      final result = await InternetConnectionService.getSignalStrength();
      _alertCounter++;
      print("==============================");
      print("**** Signal Strength is: $result *****");
      print("==============================");
      return !(result > 0.0);
    }).then((_) {
      if (kIsWeb) {
        Get.offAllNamed(SippoRoutes.appUsingPage);
      }
      if (GlobalStorageService.isLogged) {
        Get.offAllNamed(_dashboardScreens());
      } else {
        Get.offAllNamed(_entryScreen());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    Get.focusScope?.unfocus();
    goToRoute();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    double width = MediaQuery.sizeOf(context).width;
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      decoration: BoxDecoration(color: SippoColor.secondary),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            JobstopPngImg.splashlogo,
            fit: BoxFit.fitHeight,
            height: height / 10,
          ),
          SizedBox(height: height / 32),
          ThreeDotsAnimation(
            dotColor: Colors.white,
            dotSize: 10.0,
            animationDuration: Duration(milliseconds: 500),
          )
        ],
      ),
    );
    // return AnimatedSplashScreen.withScreenRouteFunction(
    //   curve: Curves.easeIn,
    //   splashTransition: SplashTransition.sizeTransition,
    //   backgroundColor: SippoColor.secondary,
    //   splash:,
    //   disableNavigation: true,
    //   screenRouteFunction: createRoute,
    // );
  }
}

class ThreeDotsAnimation extends StatefulWidget {
  final Color dotColor;
  final double dotSize;
  final Duration animationDuration;

  const ThreeDotsAnimation({
    Key? key,
    required this.dotColor,
    required this.dotSize,
    required this.animationDuration,
  }) : super(key: key);

  @override
  State<ThreeDotsAnimation> createState() => _ThreeDotsAnimationState();
}

class _ThreeDotsAnimationState extends State<ThreeDotsAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // First dot
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Opacity(
              opacity: _animation.value,
              child: child,
            );
          },
          child: Container(
            width: widget.dotSize,
            height: widget.dotSize,
            decoration: BoxDecoration(
              color: widget.dotColor,
              shape: BoxShape.circle,
            ),
          ),
        ),

        // Second dot
        SizedBox(width: widget.dotSize),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0.0, -widget.dotSize * _animation.value),
              child: child,
            );
          },
          child: Container(
            width: widget.dotSize,
            height: widget.dotSize,
            decoration: BoxDecoration(
              color: widget.dotColor,
              shape: BoxShape.circle,
            ),
          ),
        ),

        // Third dot
        SizedBox(width: widget.dotSize),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0.0, -widget.dotSize * 2 * _animation.value),
              child: child,
            );
          },
          child: Container(
            width: widget.dotSize,
            height: widget.dotSize,
            decoration: BoxDecoration(
              color: widget.dotColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}

class SmoothAnimatedRotation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double startAngle;
  final double endAngle;
  final bool isPlaying;

  const SmoothAnimatedRotation({
    Key? key,
    required this.child,
    required this.duration,
    required this.startAngle,
    required this.endAngle,
    required this.isPlaying,
  }) : super(key: key);

  @override
  State<SmoothAnimatedRotation> createState() => _SmoothAnimatedRotationState();
}

class _SmoothAnimatedRotationState extends State<SmoothAnimatedRotation> {
  double turns = 0;
  Timer? _timer;
  bool _isForward = true;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (_isForward) {
        _isForward = false;
        turns += 1 / 2;
      } else {
        _isForward = true;
        turns -= 1 / 2;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      turns: turns,
      duration: const Duration(seconds: 2),
      child: widget.child,
    );
  }
}

class RotatingWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;

  RotatingWidget({
    Key? key,
    required this.child,
    required this.duration,
  }) : super(key: key);

  @override
  State<RotatingWidget> createState() => _RotatingWidgetState();
}

class _RotatingWidgetState extends State<RotatingWidget> {
  double _angle = 0.0;

  @override
  void initState() {
    super.initState();

    Timer.periodic(widget.duration, (timer) {
      setState(() {
        _angle += 360.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: _angle,
      child: widget.child,
    );
  }
}
