import 'package:graphql_flutter/graphql_flutter.dart';

final createLogs = gql(r'''
mutation LogsMutation($logs: logs_insert_input!) {
  insert_logs_one(object: $logs) {
    id
  }
}
''');

final logsQuery = gql(r'''
query logsQuery($created_by: uuid!, $like: String!) {
  logs(where: {created_by: {_eq: $created_by}, detail: {_like: $like}}) {
    detail
    created_by
    id
    created_at
  }
}
''');
