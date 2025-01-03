import 'dart:io';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../helper/my_date_utile.dart';
import '../../../model/msg_model.dart';
import '../../../model/user_model.dart';
import '../widgets/massage_card.dart';
import '../widgets/user_profile.dart';
import 'controller/user_controller.dart';

class ChatScreen extends StatefulWidget {
  final DataModel chatUser;
  const ChatScreen({super.key, required this.chatUser});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();
  static RxBool isText = false.obs;
  List<MsgModel> msgList = [];
  RxBool isShowEmoji = false.obs;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        isShowEmoji.value = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: _appBar(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Expanded(child: _chatBody()),
              Column(
                children: [
                  _chatInput(),
                  Obx(() {
                    if (isShowEmoji.value) {
                      return EmojiPicker(
                        textEditingController: _controller,
                        onEmojiSelected: (category, emoji) {
                          _controller
                            ..selection = TextSelection.fromPosition(
                                TextPosition(offset: _controller.text.length));
                          isText.value = _controller.text.isNotEmpty;
                        },
                        config: Config(
                          emojiViewConfig: EmojiViewConfig(
                            emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // appbar widget=================
  Widget _appBar() {
    return Padding(
        padding: const EdgeInsets.only(top: 30, bottom: 5),
        child: StreamBuilder(
            stream: UserController.getUserInfo(widget.chatUser),
            builder: (context, snapshot) {
              final data = snapshot.data?.docs;
              final list =
                  data?.map((e) => DataModel.fromJson(e.data())).toList() ?? [];
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      )),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => UserProfileScreen(
                                  otherUser: widget.chatUser)));
                    },
                    child: Container(
                      child: Row(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Stack(
                                children: [
                                  Container(
                                    
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(shape: BoxShape.circle),
                                  ),
                                  Positioned(
                                      bottom: 1.h,
                                      right: 2.w,
                                      child: list.isNotEmpty
                                          ? list[0].isOnline
                                          ? Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.green,
                                          border: Border.all(
                                              color: Colors.white,
                                              width: 2),
                                        ),
                                      )
                                          : SizedBox()
                                          : SizedBox())
                                ],
                              )),
                          SizedBox(
                            width: 10.w,
                          ),
                          SizedBox(
                            width: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  list.isNotEmpty
                                      ? list[0].name
                                      : widget.chatUser.name,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                ),
                                Text(
                                  list.isNotEmpty
                                      ? list[0].isOnline
                                      ? "Active now"
                                      : MyDateUtil.getLastActiveTime(
                                      context: context,
                                      lastActive: list[0].lastActive)
                                      : MyDateUtil.getLastActiveTime(
                                      context: context,
                                      lastActive:
                                      widget.chatUser.lastActive),
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.normal),
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20.w,
                  ),
                  Container(
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.call,
                              color: Color.fromARGB(255, 0, 140, 255),
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              CupertinoIcons.video_camera,
                              color: Color.fromARGB(255, 0, 140, 255),
                            )),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => UserProfileScreen(
                                          otherUser: widget.chatUser)));
                            },
                            icon: Icon(
                              Icons.info,
                              color: Color.fromARGB(255, 0, 140, 255),
                            )),
                      ],
                    ),
                  )
                ],
              );
            }));
  }

  // here is chat input method==================>
  Widget _chatInput() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      child: Row(
        children: [
          Obx(
                () => isText.value
                ? Container()
                : Row(
              children: [
                IconButton(
                    onPressed: () async {
                      final ImagePicker _picker = ImagePicker();
                      final List<XFile> images =
                      await _picker.pickMultiImage(imageQuality: 100);
                      for (var i in images) {
                        UserController.sendChatImage(
                            widget.chatUser, File(i.path));
                      }
                    },
                    icon: Icon(
                      Icons.image,
                      color: Colors.blue,
                    )),
                IconButton(
                    onPressed: () async {
                      final ImagePicker _picker = ImagePicker();
                      final XFile? image = await _picker.pickImage(
                          source: ImageSource.camera, imageQuality: 100);
                      if (image != null) {
                        UserController.sendChatImage(
                            widget.chatUser, File(image.path));
                      }
                    },
                    icon: Icon(
                      CupertinoIcons.photo_camera_solid,
                      color: Colors.blue,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.mic,
                      color: Colors.blue,
                    )),
              ],
            ),
          ),
          Expanded(
            child: Card(
              child: Padding(
                padding: EdgeInsets.only(left: 5.w),
                child: TextFormField(
                  controller: _controller,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: Obx(() {
                        return Container(
                          child: IconButton(
                            onPressed: () {
                              if (isShowEmoji.value) {
                                isShowEmoji.value = false;
                                FocusScope.of(context).requestFocus(_focusNode);
                              } else {
                                isShowEmoji.value = true;
                                FocusScope.of(context).unfocus();
                              }
                            },
                            icon: Icon(
                              Icons.tag_faces_rounded,
                              color: isShowEmoji.value
                                  ? Color(0xFFD400FF)
                                  : Colors.grey,
                            ),
                          ),
                        );
                      }),
                      hintText: "Write something"),
                  maxLines: null,
                  onChanged: (txt) {
                    isText.value = txt.isNotEmpty;
                  },
                ),
              ),
            ),
          ),
          Obx(() => isText.value
              ? IconButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  UserController.sendMessage(
                      widget.chatUser, _controller.text, Type.text);
                  _controller.clear();
                  isText.value = false;
                }
              },
              icon: Icon(
                Icons.send,
                color: Colors.blue,
              ))
              : IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.thumb_up,
                color: Colors.blue,
              ))),
        ],
      ),
    );
  }

  //chatting body =======================>
  Widget _chatBody() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      child: StreamBuilder(
  stream: UserController.getAllMsg(widget.chatUser),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.none) {
      return Center(child: CircularProgressIndicator());
    }

    if (snapshot.connectionState == ConnectionState.done || snapshot.connectionState == ConnectionState.active) {
      final data = snapshot.data?.docs;
      if (data == null || data.isEmpty) {
        return Center(child: Text("No messages available"));
      }

      msgList = data.map((e) => MsgModel.fromJson(e.data())).toList();
      return ListView.builder(
        itemCount: msgList.length,
        reverse: true,
        itemBuilder: (context, index) {
          return AllMessage(message: msgList[index], chatUser: widget.chatUser);
        },
      );
    }
    return Center(child: Text("Unexpected error"));
  },
)

    );
  }
}

