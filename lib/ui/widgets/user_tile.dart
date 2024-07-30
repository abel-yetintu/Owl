import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:owl/models/owl_user.dart';

class UserTile extends StatelessWidget {
  final OwlUser owlUser;
  final void Function() onTap;
  const UserTile({super.key, required this.owlUser, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            CircleAvatar(
              radius: 25.r,
              backgroundImage:
                  owlUser.profilePicture.isEmpty ? const AssetImage('assets/images/empty_pp.jpg') : NetworkImage(owlUser.profilePicture),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    owlUser.fullName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    owlUser.userName,
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
