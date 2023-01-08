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

final updatePasswordMutation = gql(r'''
subscription Profile{
  users{
    id
    avatarUrl    
    displayName
  }
}
''');
