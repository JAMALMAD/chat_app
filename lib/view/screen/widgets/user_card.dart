import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../helper/my_date_utile.dart';
import '../../../model/msg_model.dart';
import '../../../model/user_model.dart';
import '../auth/chat_screen.dart';
import '../auth/controller/user_controller.dart';

// ignore: must_be_immutable
class MyUserCard extends StatefulWidget {
  final DataModel myUser;
  MyUserCard({super.key, required this.myUser});

  @override
  State<MyUserCard> createState() => _MyUserCardState();
}

class _MyUserCardState extends State<MyUserCard> {
  MsgModel? message;
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    return Card(
      elevation: 1.5,
      child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ChatScreen(chatUser: widget.myUser)));
          },
          child: StreamBuilder(
              stream: UserController.getLastMsg(widget.myUser),
              builder: (context, snapshot) {
                final data = snapshot.data?.docs;
                final list =
                    data?.map((e) => MsgModel.fromJson(e.data())).toList() ??
                        [];
                if (list.isNotEmpty) {
                  message = list[0];
                }

                return ListTile(
                    leading: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Stack(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Colors.green, shape: BoxShape.circle),
                              child: Center(
                                child: Icon(
                                  Icons.person,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            Positioned(
                                bottom: 3.h,
                                right: 5.w,
                                child: widget.myUser.isOnline
                                    ? Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.green,
                                          border: Border.all(
                                              color: Colors.white, width: 2),
                                        ),
                                      )
                                    : SizedBox())
                          ],
                        )),
                    title: Text(
                      widget.myUser.name,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: SizedBox(
                      child: message == null
                          ? Text("")
                          : message?.type == Type.image
                              ? Text("Image")
                              : Text(
                                  message!.message,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.bold),
                                ),
                    ),
                    trailing: message == null
                        ? null
                        : message!.read.isEmpty &&
                                message!.fromId != UserController.curentUser.uid
                            ? Container(
                                height: 15.h,
                                width: 15.h,
                                decoration: BoxDecoration(
                                    color: Colors.greenAccent,
                                    borderRadius: BorderRadius.circular(50)),
                              )
                            : Text(
                                list.isNotEmpty
                                    ? widget.myUser.isOnline
                                        ? "Active now"
                                        : MyDateUtil.getLastActiveTime(
                                            context: context,
                                            lastActive:
                                                widget.myUser.lastActive)
                                    : MyDateUtil.getLastActiveTime(
                                        context: context,
                                        lastActive: widget.myUser.lastActive),
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.normal),
                                overflow: TextOverflow.clip,
                                maxLines: 1,
                              ));
              })),
    );
  }
}
