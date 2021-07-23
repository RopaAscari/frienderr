import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'package:time_elapsed/time_elapsed.dart';
import 'package:frienderr/blocs/user_bloc.dart';
import 'package:frienderr/state/user_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frienderr/screens/account/account.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:frienderr/widgets/render_posts_dynamic/render_posts_dynamic.dart';

class Notifications extends StatefulWidget {
  Notifications({Key? key}) : super(key: key);

  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<Notifications>
    with AutomaticKeepAliveClientMixin<Notifications> {
  @override
  bool get wantKeepAlive => true;
  Widget build(BuildContext context) {
    late UserState userState = context.read<UserBloc>().state;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text('Notifications'),
          backgroundColor: Theme.of(context).canvasColor,
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('activity')
                .doc(userState.user.id)
                .collection('notifications')
                .orderBy('dateCreated', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              final notifications = snapshot.data?.docs ?? [];
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              if (notifications.length == 0) {
                return Center(
                    child: Text('You have no notifications',
                        style: TextStyle(fontSize: 13)));
              }
              return ListView.builder(
                  itemExtent: 72,
                  itemCount: notifications.length,
                  itemBuilder: (BuildContext context, int index) {
                    final notificationType = notifications[index]['type'];

                    switch (notificationType) {
                      case 'Like':
                        return renderLikeNotification(notifications[index]);

                      case 'Follow':
                        return renderFollowNotification(notifications[index]);

                      case 'Comment':
                        return renderCommentNotification(notifications[index]);

                      default:
                        return Container();
                    }
                  });
            }));
  }

  Widget renderFollowNotification(
      QueryDocumentSnapshot<Object?> notifications) {
    final senderId = notifications['senderId'];
    final timeElasped = notifications['dateCreated'];
    final senderUsername = notifications['senderUsername'];
    final senderProfilePic = notifications['senderProfilePic'];

    return ListTile(
        leading: GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Account(
                          isProfileOwnerViewing: false,
                          profileUserId: senderId,
                        ))),
            child: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(senderProfilePic))),
        title: Text('$senderUsername has started following you',
            style: TextStyle(fontSize: 13)),
        trailing: Text(
            TimeElapsed().elapsedTimeDynamic(
                new DateTime.fromMicrosecondsSinceEpoch(timeElasped)
                    .toString()),
            style: TextStyle(fontSize: 13)));
  }

  Widget renderLikeNotification(QueryDocumentSnapshot<Object?> notifications) {
    final postId = notifications['postId'];
    final senderId = notifications['senderId'];
    final timeElasped = notifications['dateCreated'];
    final postThumbnail = notifications['postThumbnail'];
    final senderUsername = notifications['senderUsername'];
    final senderProfilePic = notifications['senderProfilePic'];

    return ListTile(
        leading: GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Account(
                          isProfileOwnerViewing: false,
                          profileUserId: senderId,
                        ))),
            child: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(senderProfilePic))),
        title: Text('$senderUsername liked your post',
            style: TextStyle(fontSize: 13)),
        trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RenderPostDynamic(
                            postId: postId, isPostOwner: true))),
                child: Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          alignment: Alignment(-.2, 0),
                          image: CachedNetworkImageProvider(postThumbnail),
                          fit: BoxFit.cover),
                      // color: Colors.red,
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
              Text(
                  TimeElapsed().elapsedTimeDynamic(
                      new DateTime.fromMicrosecondsSinceEpoch(timeElasped)
                          .toString()),
                  style: TextStyle(fontSize: 13))
            ]));
  }

  Widget renderCommentNotification(
      QueryDocumentSnapshot<Object?> notifications) {
    final postId = notifications['postId'];
    final comment = notifications['comment'];
    final senderId = notifications['senderId'];
    final timeElasped = notifications['dateCreated'];
    final postThumbnail = notifications['postThumbnail'];
    final senderUsername = notifications['senderUsername'];
    final senderProfilePic = notifications['senderProfilePic'];

    return ListTile(
        leading: GestureDetector(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Account(
                          isProfileOwnerViewing: false,
                          profileUserId: senderId,
                        ))),
            child: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(senderProfilePic))),
        title: Text('$senderUsername comment "$comment" on your post',
            style: TextStyle(fontSize: 13)),
        trailing: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RenderPostDynamic(
                                postId: postId,
                                isPostOwner: true,
                              ))),
                  child: Container(
                    height: 50,
                    width: 50,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            alignment: Alignment(-.2, 0),
                            image: CachedNetworkImageProvider(postThumbnail),
                            fit: BoxFit.cover),
                        // color: Colors.red,
                        borderRadius: BorderRadius.circular(5)),
                  )),
              Text(
                  TimeElapsed().elapsedTimeDynamic(
                      new DateTime.fromMicrosecondsSinceEpoch(timeElasped)
                          .toString()),
                  style: TextStyle(fontSize: 13))
            ]));
  }
}
