import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jobspot/JobGlobalclass/media_query_sizes.dart';

import '../JobGlobalclass/jobstopfontstyle.dart';
import '../JobGlobalclass/sippo_customstyle.dart';
import '../JobGlobalclass/text_font_size.dart';
import '../utils/states.dart';

enum MessageType {
  WARNING,
  SUCCESS,
  ERROR,
}

class ColoredMessageCard {
  final Color? filledColor;
  final Color? borderColor;

  const ColoredMessageCard({
    required this.filledColor,
    required this.borderColor,
  });

  static final colors = {
    MessageType.WARNING: ColoredMessageCard(
      filledColor: Colors.orange[200],
      borderColor: Colors.orange[600],
    ),
    MessageType.SUCCESS: ColoredMessageCard(
      filledColor: Colors.green[200],
      borderColor: Colors.green[600],
    ),
    MessageType.ERROR: ColoredMessageCard(
      filledColor: Colors.red[100],
      borderColor: Colors.red[600],
    ),
  };
}

class CardNotifyMessage extends StatelessWidget {
  const CardNotifyMessage(
    this.message, {
    super.key,
    this.onCancelTap,
    this.messageType,
    this.bottomSpaceValue,
  }) : this.state = null;

  const CardNotifyMessage.success({
    super.key,
    this.state,
    this.onCancelTap,
    this.bottomSpaceValue,
  })  : this.message = "",
        this.messageType = MessageType.SUCCESS;

  const CardNotifyMessage.warning({
    super.key,
    this.state,
    this.onCancelTap,
    this.bottomSpaceValue,
  })  : this.message = "",
        this.messageType = MessageType.WARNING;

  const CardNotifyMessage.error({
    super.key,
    this.state,
    this.onCancelTap,
    this.bottomSpaceValue,
  })  : this.message = "",
        this.messageType = MessageType.ERROR;

  final States? state;
  final String message;
  final VoidCallback? onCancelTap;
  final MessageType? messageType;
  final double? bottomSpaceValue;
  static const Widget empty = const SizedBox.shrink();

  bool _buildState() {
    if (state == null && message.isNotEmpty) return true;
    switch (messageType) {
      case MessageType.WARNING:
        return state?.isWarning ?? false;
      case MessageType.SUCCESS:
        return state?.isSuccess ?? false;
      case MessageType.ERROR:
        return state?.isError ?? false;
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildState()
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: context.width,
                child: Card(
                  margin: EdgeInsets.zero,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(context.fromWidth(64)),
                    side: BorderSide(
                      width: context.width / 256,
                      color: ColoredMessageCard
                              .colors[messageType]?.borderColor ??
                          Colors.transparent,
                    ),
                  ),
                  color:
                      ColoredMessageCard.colors[messageType]?.filledColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            state?.message ?? message,
                            style: dmsregular.copyWith(
                              color: Colors.black87,
                              fontSize: FontSize.paragraph2(context),
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ),
                        //!TO DO
                        if (onCancelTap != null)
                          IconButton(
                            onPressed: onCancelTap,

                            icon: Icon(Icons.close,
                            size: 12,),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: bottomSpaceValue ??
                    context.fromHeight(CustomStyle.spaceBetween),
              ),
            ],
          )
        : empty;
  }
}
