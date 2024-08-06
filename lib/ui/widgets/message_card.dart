import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:owl/models/message.dart';
import 'package:owl/providers/chat_provider.dart';
import 'package:owl/utils/extension.dart';
import 'package:provider/provider.dart';

class MessageCard extends StatelessWidget {
  final Message message;
  final String currentUserUid;
  final String convoId;
  const MessageCard({super.key, required this.message, required this.currentUserUid, required this.convoId});

  @override
  Widget build(BuildContext context) {
    bool isCurrentUser = currentUserUid == message.senderUid;
    Color color = isCurrentUser ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary;
    Alignment alignment = isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    if (message.senderUid != currentUserUid && message.read == false) {
      context.read<ChatProvider>().markMessageAsRead(message: message, docId: convoId);
    }

    return Align(
      alignment: alignment,
      child: Card(
        color: color,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.r)),
        ),
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.8),
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                message.message,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 14.sp,
                      color: !isCurrentUser ? Theme.of(context).colorScheme.onSecondary : null,
                    ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message.timeStamp.toDate().getTimeOnly(),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: !isCurrentUser ? Theme.of(context).colorScheme.onSecondary : null,
                        ),
                  ),
                  if (message.senderUid == currentUserUid)
                    SizedBox(
                      width: 2.w,
                    ),
                  if (message.senderUid == currentUserUid)
                    message.read
                        ? Icon(Icons.done_all_outlined, size: 18.r, color: Theme.of(context).colorScheme.secondary)
                        : Icon(Icons.check, size: 18.r),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
