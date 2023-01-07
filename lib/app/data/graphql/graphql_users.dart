import 'package:graphql_flutter/graphql_flutter.dart';

final getUserProfileSubscription = gql(r'''
subscription Profile{
  users{
    id
    avatarUrl    
    displayName
  }
}
''');
