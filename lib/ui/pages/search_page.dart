import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:owl/models/owl_user.dart';
import 'package:owl/providers/chat_provider.dart';
import 'package:owl/providers/owl_user_provider.dart';
import 'package:owl/providers/search_provider.dart';
import 'package:owl/providers/selected_tab_provider.dart';
import 'package:owl/ui/pages/chat_page.dart';
import 'package:owl/ui/widgets/shimmer_widget.dart';
import 'package:owl/ui/widgets/user_tile.dart';
import 'package:owl/utils/generate_id.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final searchProvider = context.watch<SearchProvider>();

    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
      child: Column(
        children: [
          TextField(
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            textInputAction: TextInputAction.search,
            decoration: const InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search),
            ),
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                searchProvider.serchUserByUserName(userName: value);
              }
            },
          ),
          SizedBox(height: 24.h),
          Expanded(
            child: searchProvider.loading
                ? _loadingUI()
                : searchProvider.error != null
                    ? _errorUI(searchProvider.error!)
                    : _usersUi(context, searchProvider.owlUsers),
          )
        ],
      ),
    );
  }

  Widget _loadingUI() {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 16.h),
          child: Row(
            children: [
              ShimmerWidget.circular(size: 25.r),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerWidget.rectangular(height: 16.h, width: 150.h),
                  SizedBox(height: 8.h),
                  ShimmerWidget.rectangular(height: 12.h, width: 100.h),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _errorUI(String error) {
    return Center(
      child: Text(error),
    );
  }

  Widget _usersUi(BuildContext context, List<OwlUser> owlUsers) {
    final currentUser = context.read<OwlUserProvider>().owlUser!;
    return ListView.builder(
      itemCount: owlUsers.length,
      itemBuilder: (context, index) {
        return UserTile(
          owlUser: owlUsers[index],
          onTap: () {
            if (currentUser.uid == owlUsers[index].uid) {
              context.read<SelectedTabProvider>().selectTab(tab: 2);
              return;
            }
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ChangeNotifierProvider<ChatProvider>(
                create: (context) => ChatProvider(docId: generateDocumentId(uid1: currentUser.uid, uid2: owlUsers[index].uid)),
                child: ChatPage(
                    currentUser: currentUser,
                    otherUser: owlUsers[index],
                    convoId: generateDocumentId(uid1: currentUser.uid, uid2: owlUsers[index].uid)),
              );
            }));
          },
        );
      },
    );
  }
}
