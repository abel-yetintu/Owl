import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:owl/providers/auth_provider.dart';
import 'package:owl/providers/owl_user_provider.dart';
import 'package:owl/providers/theme_provider.dart';
import 'package:owl/services/image_picker_service.dart';
import 'package:owl/services/storage_service.dart';
import 'package:owl/utils/alert.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final owlUser = context.watch<OwlUserProvider>().owlUser!;
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 0),
      child: Column(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: () => showImagePickerBottomSheet(context),
                    child: CircleAvatar(
                      radius: 60.r,
                      backgroundImage: owlUser.profilePicture == ""
                          ? const AssetImage('assets/images/empty_pp.jpg')
                          : NetworkImage(owlUser.profilePicture),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: ClipOval(
                      child: Container(
                        color: Theme.of(context).colorScheme.secondary,
                        padding: EdgeInsets.all(6.r),
                        child: Icon(
                          Icons.edit,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 12.h),
              Text(
                owlUser.fullName,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '@${owlUser.userName}',
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Card(
            margin: const EdgeInsets.all(0),
            color: Theme.of(context).colorScheme.tertiary,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              child: Row(
                children: [
                  Icon(
                    Icons.email,
                    color: Theme.of(context).colorScheme.onTertiary,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    owlUser.email,
                    style: TextStyle(color: Theme.of(context).colorScheme.onTertiary),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Text(
                'Settings',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Card(
            margin: const EdgeInsets.all(0),
            color: Theme.of(context).colorScheme.tertiary,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.dark_mode,
                        color: Theme.of(context).colorScheme.onTertiary,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Dark Mode',
                        style: TextStyle(color: Theme.of(context).colorScheme.onTertiary),
                      ),
                    ],
                  ),
                  Switch(
                    value: context.watch<ThemeProvider>().themeMode == ThemeMode.dark,
                    onChanged: (value) {
                      context.read<ThemeProvider>().toggleTheme(isDark: value);
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    context.read<AuthProvider>().signOut();
                  },
                  child: const Text('Log out'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void showImagePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Pick an image'),
              onTap: () {
                pickImage(context: context, imageSource: ImageSource.gallery);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Take a picture'),
              onTap: () {
                pickImage(context: context, imageSource: ImageSource.camera);
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  Future<void> pickImage({required BuildContext context, required ImageSource imageSource}) async {
    try {
      var file = await context.read<ImagePickerService>().pickImage(imageSource: imageSource);
      if (file != null) {
        var result =
            await context.read<StorageService>().uploadProficePicture(file: file, owlUser: context.read<OwlUserProvider>().owlUser!);
        if (result) {
          Alert.showToast(context: context, text: 'Profile pictue updated.', icon: Icons.image);
        }
      }
    } catch (_) {
      Alert.showErrorToast(context: context, text: 'Error. Please try agian.');
    }
  }
}
