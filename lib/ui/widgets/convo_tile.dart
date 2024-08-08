import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:owl/models/conversation.dart';
import 'package:owl/utils/extension.dart';

class ConvoTile extends StatelessWidget {
  final Conversation convo;
  final String currentUserUid;
  final void Function() onTap;
  const ConvoTile({super.key, required this.convo, required this.currentUserUid, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final otherUser = convo.participants.singleWhere((user) => user.uid != currentUserUid);
    return Container(
      margin: EdgeInsets.only(bottom: 16.w),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25.r,
              backgroundImage: otherUser.profilePicture.isEmpty
                  ? const AssetImage('assets/images/empty_pp.jpg')
                  : NetworkImage(otherUser.profilePicture),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          otherUser.fullName,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          convo.lastMessage.timeStamp.toDate().getFormattedDate(textMode: false),
                          style: Theme.of(context).textTheme.titleSmall,
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          convo.lastMessage.message,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      if (convo.lastMessage.senderUid == currentUserUid)
                        convo.lastMessage.read
                              ? Icon(
                                  Icons.done_all_outlined,
                                  size: 18.r,
                                  color: Theme.of(context).colorScheme.secondary,
                                )
                              : Icon(
                                  Icons.check,
                                  size: 18.r,
                              ),
                      if (convo.lastMessage.senderUid != currentUserUid && !convo.lastMessage.read)
                        Icon(
                          Icons.circle,
                          size: 18.r,
                          color: Theme.of(context).colorScheme.secondary,
                        )
                        


                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
