import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:owl/models/message.dart';
import 'package:owl/models/owl_user.dart';
import 'package:owl/providers/chat_provider.dart';
import 'package:owl/ui/widgets/group_header_card.dart';
import 'package:owl/ui/widgets/message_card.dart';
import 'package:owl/ui/widgets/shimmer_widget.dart';
import 'package:owl/utils/alert.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final OwlUser currentUser;
  final OwlUser otherUser;
  final String? convoId;

  const ChatPage({super.key, required this.currentUser, required this.otherUser, required this.convoId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ChatProvider chatProvider = context.watch<ChatProvider>();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: Theme.of(context).colorScheme.tertiary,
              height: 80.h,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Theme.of(context).colorScheme.onTertiary,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  CircleAvatar(
                    radius: 25.r,
                    backgroundImage: widget.otherUser.profilePicture == ""
                        ? const AssetImage('assets/images/empty_pp.jpg')
                        : NetworkImage(widget.otherUser.profilePicture),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Expanded(
                    child: Text(
                      widget.otherUser.fullName,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onTertiary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ),
            chatProvider.loading
                ? _loadingUi()
                : chatProvider.error != null
                    ? _errorUi(chatProvider.error!)
                    : _chatUi(chatProvider.messages, widget.otherUser),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 8.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },
                      controller: _textEditingController,
                      minLines: 1,
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Type here...',
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.h),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (_textEditingController.text != '') {
                        FocusScope.of(context).unfocus();
                        _sendMessage(
                          text: _textEditingController.text,
                          currentUser: widget.currentUser,
                          otherUser: widget.otherUser,
                          chatProvider: chatProvider,
                        );
                        _textEditingController.clear();
                      }
                    },
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _sendMessage({required String text, required OwlUser currentUser, required OwlUser otherUser, required ChatProvider chatProvider}) {
    chatProvider.sendMessage(text: text, currentUser: currentUser, otherUser: otherUser).then((value) {
      if (!value) {
        Alert.showErrorToast(context: context, text: 'Unable to send message.');
      }
    });
  }

  Widget _loadingUi() {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
      child: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(bottom: 16.w),
            child: Align(
              alignment: index % 2 == 0 ? Alignment.centerLeft : Alignment.centerRight,
              child: ShimmerWidget.rectangular(
                height: 50.h,
                width: 200.w,
                shapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
          );
        },
      ),
    ));
  }

  Widget _errorUi(String errorMessage) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 8.h),
        child: Center(
          child: Text(errorMessage),
        ),
      ),
    );
  }

  Widget _chatUi(List<Message> messages, OwlUser otherUser) {
    if (messages.isEmpty) {
      return Expanded(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 8.h),
          child: Center(
            child: Text('Start a conversation with ${otherUser.fullName}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                )),
          ),
        ),
      );
    }
    return Expanded(
      child: GroupedListView<Message, DateTime>(
        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 8.h),
        elements: messages,
        reverse: true,
        order: GroupedListOrder.DESC,
        groupBy: (message) => DateTime(
          message.timeStamp.toDate().year,
          message.timeStamp.toDate().month,
          message.timeStamp.toDate().day,
        ),
        groupHeaderBuilder: (message) {
          return GroupHeaderCard(message: message);
        },
        itemBuilder: (context, message) {
          return MessageCard(
            convoId: widget.convoId!,
            message: message,
            currentUserUid: widget.currentUser.uid,
          );
        },
        itemComparator: (message1, message2) {
          return message1.timeStamp.toDate().compareTo(message2.timeStamp.toDate());
        },
      ),
    );
  }
}
