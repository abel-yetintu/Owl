import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:owl/models/message.dart';
import 'package:owl/utils/extension.dart';

class GroupHeaderCard extends StatelessWidget {
  final Message message;
  const GroupHeaderCard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Theme.of(context).colorScheme.tertiary,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4.r)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
          child: Text(
            message.timeStamp.toDate().getFormattedDate(textMode: true),
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
          ),
        ),
      ),
    );
  }
}
