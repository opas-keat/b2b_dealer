import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../data/graphql/graphql_users.dart';
import '../../../data/models/user_response.dart';
import '../../../shared/constant.dart';

class ProfileDetailWidget extends StatelessWidget {
  ProfileDetailWidget({
    Key? key,
  }) : super(key: key);

  final scrollBarController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Subscription(
        options: SubscriptionOptions(
          document: getUserProfileSubscription,
        ),
        builder: (result) {
          // has error
          if (result.hasException) {
            return const Text('Error loading user data!');
          }
          //loading
          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          //show data
          // debugPrint('${result.data}');
          final users = (result.data!['users'] as List)
              .map((e) => UserResponse.fromMap(e))
              .toList();
          // debugPrint('${users.first.id}');
          return ListView(
            controller: scrollBarController,
            padding: const EdgeInsets.all(defaultPadding * 2),
            children: [
              CircleAvatar(
                radius: 75,
                backgroundColor: primaryColor,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(users.first.avatarUrl),
                  radius: 70,
                ),
              ),
              Center(
                child: Text(
                  users.first.displayName,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
