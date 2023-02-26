import 'package:graphql_flutter/graphql_flutter.dart';

final getArtWork = gql(r'''
query getArtWork {
  files(where: {name: {_eq: "artwork"}}, order_by: {createdAt: desc}, limit: 1, offset: 0) {
    id
  }
}
''');
