import 'package:graphql_flutter/graphql_flutter.dart';

final createLogs = gql(r'''
mutation LogsMutation($logs: logs_insert_input!) {
  insert_logs_one(object: $logs) {
    id
  }
}
''');
