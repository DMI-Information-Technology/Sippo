import 'package:flutter/material.dart';
import 'package:sippo/JobGlobalclass/sippo_customstyle.dart';

import 'error_messages_dialog_snackbar/network_connnection_lost_widget.dart';

class NetworkStatusPreferredSizeWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const NetworkStatusPreferredSizeWidget({
    super.key,
    this.cancelNetworkStatusBar = true,
    this.showStatusNetworkBar = false,
  });

  final bool? cancelNetworkStatusBar;
  final bool showStatusNetworkBar;

  @override
  Widget build(BuildContext context) {
    print("cancelNetworkStatusBar = $cancelNetworkStatusBar");
    // final netController = InternetConnectionController.instance;
    return showStatusNetworkBar && !(cancelNetworkStatusBar == true)
        ? NetworkStatusNonWidget(
            color: Colors.black.withOpacity(0.65),
          )
        : const SizedBox.shrink();
  }

  @override
  Size get preferredSize {
    return showStatusNetworkBar
        ? Size.fromHeight(CustomStyle.connectionLostHeight)
        : Size.fromHeight(0.0);
  }
}
