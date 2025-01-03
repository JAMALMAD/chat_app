//
// import 'package:cheating_app/view/screen/profile_Screen.dart';
// import 'package:cheating_app/view/screen/widgets/user_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../model/user_model.dart';
// import 'auth/controller/user_controller.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   List<DataModel> dataList = [];
//   List _searchingList = [];
//   bool isSearching = false;
//   List<String> items = List.generate(20, (index) => "Item $index");
//
//   Future<void> _refresh() async {
//     await Future.delayed(Duration(seconds: 2));
//     setState(() {
//       items = List.generate(20, (index) => "Refreshed Item $index");
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     SystemChannels.lifecycle.setMessageHandler((message) {
//       if (UserController.firebaseAuth.currentUser != null) {
//         if (message.toString().contains("resume"))
//           UserController.userActiveStatus(true);
//         if (message.toString().contains("pause"))
//           UserController.userActiveStatus(false);
//       }
//       return Future.value(message);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       // ignore: deprecated_member_use
//       child: WillPopScope(
//         onWillPop: () {
//           if (isSearching) {
//             setState(() {
//               isSearching = !isSearching;
//             });
//             return Future.value(false);
//           } else {
//             return Future.value(true);
//           }
//         },
//         child: Scaffold(
//           appBar: AppBar(
//             title: isSearching
//                 ? Container(
//                     height: 40.h,
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                           contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(15))),
//                       onChanged: (searchValue) {
//                         _searchingList.clear();
//                         for (var i in dataList) {
//                           if (i.name
//                                   .toLowerCase()
//                                   .contains(searchValue.toLowerCase()) ||
//                               i.email
//                                   .toLowerCase()
//                                   .contains(searchValue.toLowerCase())) {
//                             _searchingList.add(i);
//                           }
//                           setState(() {
//                             _searchingList;
//                           });
//                         }
//                       },
//                     ),
//                   )
//                 : Text("Chat App"),
//             leading: IconButton(onPressed: () {}, icon: Icon(Icons.home)),
//             actions: [
//               IconButton(
//                   onPressed: () {
//                     setState(() {
//                       isSearching = !isSearching;
//                     });
//                   },
//                   icon: isSearching ? Icon(Icons.clear) : Icon(Icons.search)),
//               IconButton(
//                   onPressed: () {
//                     if (UserController.me != null) {
//                       // Get.to(() => ProfileScreen(myUser: UserController.me));
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) =>
//                               ProfileScreen(myUser: UserController.me),
//                         ),
//                       );
//                       // Navigator.push(context, AppRoute.profileScreen);
//                     } else {
//                       // Handle the case where `me` is null (maybe show a loading indicator)
//                       print('User data is not initialized yet');
//                     }
//                   },
//                   icon: Icon(Icons.more_vert)),
//             ],
//           ),
//           body: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
//             child: RefreshIndicator(
//               onRefresh: _refresh,
//               child: StreamBuilder(
//                 stream: UserController.getAllUser(),
//                 builder: (context, snapshot) {
//                   switch (snapshot.connectionState) {
//                     case ConnectionState.waiting:
//                     case ConnectionState.none:
//                       return Container();
//                     case ConnectionState.active:
//                     case ConnectionState.done:
//                       final data = snapshot.data!.docs;
//                       dataList = data
//                           .map((e) => DataModel.fromJson(e.data()))
//                           .toList();
//
//                       if (dataList.isNotEmpty) {
//                         return ListView.builder(
//                             itemCount: isSearching
//                                 ? _searchingList.length
//                                 : dataList.length,
//                             physics: BouncingScrollPhysics(),
//                             itemBuilder: (context, index) {
//                               return isSearching
//                                   ? MyUserCard(
//                                       myUser: _searchingList[index],
//                                     )
//                                   : MyUserCard(
//                                       myUser: dataList[index],
//                                     );
//                             });
//                       } else {
//                         return Center(
//                           child: Text(
//                             "No Data Found!",
//                             style: TextStyle(
//                                 fontSize: 25.sp, color: Colors.red.shade300),
//                           ),
//                         );
//                       }
//                   }
//                 }

//
//                stream: UserController.getAllUser(),
// builder: (context, snapshot) {
//   if (snapshot.connectionState == ConnectionState.waiting) {
//     return Center(child: CircularProgressIndicator());
//   } else if (snapshot.connectionState == ConnectionState.none ||
//       snapshot.data == null) {
//     return Center(
//       child: Text("No data available", style: TextStyle(fontSize: 20.sp)),
//     );
//   } else if (snapshot.connectionState == ConnectionState.done ||
//       snapshot.connectionState == ConnectionState.active) {
//     // Ensure snapshot.data is not null here
//     final data = snapshot.data!.docs;
//
//     // Convert Firestore data to your model list
//     dataList = data
//         .map((e) => DataModel.fromJson(e.data()))
//         .toList();
//
//     if (dataList.isNotEmpty) {
//       return ListView.builder(
//         itemCount: isSearching ? _searchingList.length : dataList.length,
//         physics: BouncingScrollPhysics(),
//         itemBuilder: (context, index) {
//           return isSearching
//               ? MyUserCard(myUser: _searchingList[index])
//               : MyUserCard(myUser: dataList[index]);
//         },
//       );
//     } else {
//       return Center(
//         child: Text(
//           "No Data Found!",
//           style: TextStyle(fontSize: 25.sp, color: Colors.red.shade300),
//         ),
//       );
//     }
//   } else {
//     // Handle other connection states
//     return Center(
//       child: Text("Something went wrong", style: TextStyle(fontSize: 20.sp)),
//     );
//   }
//   // },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

//
//
// import 'package:cheating_app/view/screen/profile_Screen.dart';
// import 'package:cheating_app/view/screen/widgets/user_card.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../../model/user_model.dart';
// import 'auth/controller/user_controller.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   List<DataModel> dataList = [];
//   List _searchingList = [];
//   bool isSearching = false;
//   List<String> items = List.generate(20, (index) => "Item $index");
//
//   Future<void> _refresh() async {
//     await Future.delayed(Duration(seconds: 2));
//     setState(() {
//       items = List.generate(20, (index) => "Refreshed Item $index");
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize user data here
//     _initializeUserData();
//   }
//
//   // Function to initialize user data
//   Future<void> _initializeUserData() async {
//     await UserController.selfInfo(); // Ensure user data is loaded
//     setState(() {}); // Trigger rebuild to update UI once user data is fetched
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: WillPopScope(
//         onWillPop: () {
//           if (isSearching) {
//             setState(() {
//               isSearching = !isSearching;
//             });
//             return Future.value(false);
//           } else {
//             return Future.value(true);
//           }
//         },
//         child: Scaffold(
//           appBar: AppBar(
//             title: isSearching
//                 ? Container(
//               height: 40.h,
//               child: TextFormField(
//                 decoration: InputDecoration(
//                     contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15))),
//                 onChanged: (searchValue) {
//                   _searchingList.clear();
//                   for (var i in dataList) {
//                     if (i.name
//                         .toLowerCase()
//                         .contains(searchValue.toLowerCase()) ||
//                         i.email
//                             .toLowerCase()
//                             .contains(searchValue.toLowerCase())) {
//                       _searchingList.add(i);
//                     }
//                     setState(() {
//                       _searchingList;
//                     });
//                   }
//                 },
//               ),
//             )
//                 : Text("Chat App"),
//             leading: IconButton(onPressed: () {}, icon: Icon(Icons.home)),
//             actions: [
//               IconButton(
//                   onPressed: () {
//                     setState(() {
//                       isSearching = !isSearching;
//                     });
//                   },
//                   icon: isSearching ? Icon(Icons.clear) : Icon(Icons.search)),
//               IconButton(
//                   onPressed: () {
//                     // Check if the user data is initialized before navigating
//                     if (UserController.me != null) {
//                       Get.to(() => ProfileScreen(myUser: UserController.me));
//                     } else {
//                       // Handle the case where `me` is still null (maybe show a loading indicator)
//                       print('User data is not initialized yet');
//                     }
//                   },
//                   icon: Icon(Icons.more_vert)),
//             ],
//           ),
//           body: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
//             child: RefreshIndicator(
//               onRefresh: _refresh,
//               child: StreamBuilder(
//                 stream: UserController.getAllUser(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (snapshot.connectionState == ConnectionState.none ||
//                       snapshot.data == null) {
//                     return Center(
//                       child: Text("No data available", style: TextStyle(fontSize: 20.sp)),
//                     );
//                   } else if (snapshot.connectionState == ConnectionState.done ||
//                       snapshot.connectionState == ConnectionState.active) {
//                     final data = snapshot.data!.docs;
//                     dataList = data.map((e) => DataModel.fromJson(e.data())).toList();
//
//                     if (dataList.isNotEmpty) {
//                       return ListView.builder(
//                         itemCount: isSearching ? _searchingList.length : dataList.length,
//                         physics: BouncingScrollPhysics(),
//                         itemBuilder: (context, index) {
//                           return isSearching
//                               ? MyUserCard(myUser: _searchingList[index])
//                               : MyUserCard(myUser: dataList[index]);
//                         },
//                       );
//                     } else {
//                       return Center(
//                         child: Text(
//                           "No Data Found!",
//                           style: TextStyle(fontSize: 25.sp, color: Colors.red.shade300),
//                         ),
//                       );
//                     }
//                   } else {
//                     return Center(
//                       child: Text("Something went wrong", style: TextStyle(fontSize: 20.sp)),
//                     );
//                   }
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

//
//
// import 'package:cheating_app/view/screen/profile_Screen.dart';
// import 'package:cheating_app/view/screen/widgets/user_card.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../model/user_model.dart';
// import 'auth/controller/user_controller.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   List<DataModel> dataList = [];
//   List<DataModel> _searchingList = [];
//   bool isSearching = false;
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize user data here
//     _initializeUserData();
//
//     // Listen to lifecycle events for managing user's active status
//     SystemChannels.lifecycle.setMessageHandler((message) {
//       if (UserController.firebaseAuth.currentUser != null) {
//         if (message.toString().contains("resume"))
//           UserController.userActiveStatus(true);
//         if (message.toString().contains("pause"))
//           UserController.userActiveStatus(false);
//       }
//       return Future.value(message);
//     });
//   }
//
//   // Function to initialize user data
//   Future<void> _initializeUserData() async {
//     await UserController.selfInfo(); // Ensure user data is loaded
//     setState(() {}); // Trigger rebuild to update UI once user data is fetched
//   }
//
//   Future<void> _refresh() async {
//     // Simulate a refresh by waiting for a while
//     await Future.delayed(Duration(seconds: 2));
//     setState(() {
//       // Re-fetch or refresh data logic here if needed
//       // You can also reinitialize the user data if required
//       _searchingList.clear();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: WillPopScope(
//         onWillPop: () {
//           if (isSearching) {
//             setState(() {
//               isSearching = !isSearching;
//             });
//             return Future.value(false);
//           } else {
//             return Future.value(true);
//           }
//         },
//         child: Scaffold(
//           appBar: AppBar(
//             title: isSearching
//                 ? Container(
//               height: 40.h,
//               child: TextFormField(
//                 decoration: InputDecoration(
//                     contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
//                     border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(15))),
//                 onChanged: (searchValue) {
//                   _searchingList.clear();
//                   for (var i in dataList) {
//                     if (i.name
//                         .toLowerCase()
//                         .contains(searchValue.toLowerCase()) ||
//                         i.email
//                             .toLowerCase()
//                             .contains(searchValue.toLowerCase())) {
//                       _searchingList.add(i);
//                     }
//                   }
//                   setState(() {
//                     // Refresh the list
//                   });
//                 },
//               ),
//             )
//                 : Text("Chat App"),
//             leading: IconButton(onPressed: () {}, icon: Icon(Icons.home)),
//             actions: [
//               IconButton(
//                 onPressed: () {
//                   setState(() {
//                     isSearching = !isSearching;
//                   });
//                 },
//                 icon: isSearching ? Icon(Icons.clear) : Icon(Icons.search),
//               ),
//               IconButton(
//                 onPressed: () {
//                   if (UserController.me != null) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) =>
//                             ProfileScreen(myUser: UserController.me),
//                       ),
//                     );
//                   } else {
//                     print('User data is not initialized yet');
//                   }
//                 },
//                 icon: Icon(Icons.more_vert),
//               ),
//             ],
//           ),
//           body: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
//             child: RefreshIndicator(
//               onRefresh: _refresh,
//               child: StreamBuilder(
//                 stream: UserController.getAllUser(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting ||
//                       snapshot.connectionState == ConnectionState.none) {
//                     return Center(child: CircularProgressIndicator());
//                   } else if (snapshot.connectionState == ConnectionState.active ||
//                       snapshot.connectionState == ConnectionState.done) {
//                     final data = snapshot.data!.docs;
//                     dataList = data
//                         .map((e) => DataModel.fromJson(e.data()))
//                         .toList();
//
//                     if (dataList.isNotEmpty) {
//                       return ListView.builder(
//                         itemCount:
//                         isSearching ? _searchingList.length : dataList.length,
//                         physics: BouncingScrollPhysics(),
//                         itemBuilder: (context, index) {
//                           return isSearching
//                               ? MyUserCard(myUser: _searchingList[index])
//                               : MyUserCard(myUser: dataList[index]);
//                         },
//                       );
//                     } else {
//                       return Center(
//                         child: Text(
//                           "No Data Found!",
//                           style: TextStyle(
//                               fontSize: 25.sp, color: Colors.red.shade300),
//                         ),
//                       );
//                     }
//                   } else {
//                     return Center(
//                       child: Text(
//                         "Something went wrong",
//                         style: TextStyle(fontSize: 20.sp),
//                       ),
//                     );
//                   }
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:cheating_app/view/screen/profile_Screen.dart';
import 'package:cheating_app/view/screen/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/user_model.dart';
import 'auth/controller/user_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<DataModel> dataList = [];
  List _searchingList = [];
  bool isSearching = false;
  List<String> items = List.generate(20, (index) => "Item $index");

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      items = List.generate(20, (index) => "Refreshed Item $index");
    });
  }

  @override
  void initState() {
    super.initState();
    UserController.selfInfo();
    SystemChannels.lifecycle.setMessageHandler((message) {
      if (UserController.firebaseAuth.currentUser != null) {
        if (message.toString().contains("resume"))
          UserController.userActiveStatus(true);
        if (message.toString().contains("pause"))
          UserController.userActiveStatus(false);
      }
      return Future.value(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      // ignore: deprecated_member_use
      child: WillPopScope(
        onWillPop: () {
          if (isSearching) {
            setState(() {
              isSearching = !isSearching;
            });
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: isSearching
                ? Container(
                    height: 40.h,
                    child: TextFormField(
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                      onChanged: (searchValue) {
                        _searchingList.clear();
                        for (var i in dataList) {
                          if (i.name
                                  .toLowerCase()
                                  .contains(searchValue.toLowerCase()) ||
                              i.email
                                  .toLowerCase()
                                  .contains(searchValue.toLowerCase())) {
                            _searchingList.add(i);
                          }
                          setState(() {
                            _searchingList;
                          });
                        }
                      },
                    ),
                  )
                : Text("Chat App"),
            leading: IconButton(onPressed: () {}, icon: Icon(Icons.home)),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      isSearching = !isSearching;
                    });
                  },
                  icon: isSearching ? Icon(Icons.clear) : Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) =>
                                ProfileScreen(myUser: UserController.me)));
                  },
                  icon: Icon(Icons.more_vert)),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            child: RefreshIndicator(
                onRefresh: _refresh,
                child: StreamBuilder(
                  stream: UserController.getAllUser(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return Container(); // Show loading indicator or empty container

                      case ConnectionState.active:
                      case ConnectionState.done:
                        // Check if snapshot.data is null before accessing it
                        final data = snapshot.data
                            ?.docs; // Safely access docs with null-aware operator

                        // If data is null or empty, handle the case
                        if (data == null || data.isEmpty) {
                          return Center(
                            child: Text(
                              "No Data Found!",
                              style: TextStyle(
                                  fontSize: 25.sp, color: Colors.red.shade300),
                            ),
                          );
                        }

                        // Convert the documents to a list of DataModel objects
                        dataList = data
                            .map((e) => DataModel.fromJson(e.data()))
                            .toList();

                        return ListView.builder(
                          itemCount: isSearching
                              ? _searchingList.length
                              : dataList.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return isSearching
                                ? MyUserCard(myUser: _searchingList[index])
                                : MyUserCard(myUser: dataList[index]);
                          },
                        );
                    }
                  },
                )),
          ),
        ),
      ),
    );
  }
}
