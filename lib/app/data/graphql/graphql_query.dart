import 'package:graphql_flutter/graphql_flutter.dart';

final getDealers = gql(r'''
query MyQuery($dealerCode: String) {
  dealers(where: {dealer_code: {_regex: $dealerCode}}) {
    dealer_code
    name
  }
}
''');
