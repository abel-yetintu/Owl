import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:owl/models/conversation.dart';
import 'package:owl/providers/auth_provider.dart';
import 'package:owl/providers/chat_provider.dart';
import 'package:owl/providers/conversation_provider.dart';
import 'package:owl/ui/pages/chat_page.dart';
import 'package:owl/ui/widgets/convo_tile.dart';
import 'package:owl/ui/widgets/shimmer_widget.dart';
import 'package:provider/provider.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUserUid = context.read<AuthProvider>().owlUser!.uid;
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Messages', style: Theme.of(context).textTheme.headlineLarge),
              IconButton(
                icon: const Icon(Icons.exit_to_app
                ),
                onPressed: () {
                  context.read<AuthProvider>().signOut();
                },
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Consumer<ConversationProvider>(
            builder: (context, provider, child) {
              if (provider.loading) {
                return Expanded(child: _loadingUi(context));
              } else if (provider.error != null) {
                return _errorUi(provider.error!);
              } else {
                return Expanded(child: _conversationsUi(provider.conversations, currentUserUid));
              }
            },
          )
        ],
      ),
    );
  }

  Widget _loadingUi(BuildContext context) {
    return ListView.builder(
      itemCount: 7,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 16.h),
          child: Row(
            children: [
              ShimmerWidget.circular(size: 25.r),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerWidget.rectangular(height: 16.h, width: 100.w),
                    SizedBox(height: 4.w),
                    ShimmerWidget.rectangular(height: 14.h, width: 200.w),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _errorUi(String errorMessage) {
    return Center(child: Text(errorMessage));
  }

  Widget _conversationsUi(List<Conversation> conversations, String currentUserUid) {
    return ListView.builder(
      itemCount: conversations.length,
      itemBuilder: (context, index) {
        return ConvoTile(
          convo: conversations[index],
          currentUserUid: currentUserUid,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ChangeNotifierProvider<ChatProvider>(
                create: (context) => ChatProvider(docId: conversations[index].documentId),
                child: ChatPage(
                    currentUser: conversations[index].participants.singleWhere((owlUser) => owlUser.uid == currentUserUid),
                    otherUser: conversations[index].participants.singleWhere((owlUser) => owlUser.uid != currentUserUid),
                    convoId: conversations[index].documentId),
              );
            }));
          },
        );
      },
    );
  }
}
