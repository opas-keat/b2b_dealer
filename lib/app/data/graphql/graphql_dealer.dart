import 'package:graphql_flutter/graphql_flutter.dart';

final getDealers = gql(r'''
query MyQuery($dealerCode: String) {
  dealers(where: {dealer_code: {_regex: $dealerCode}}) {
    dealer_code
    name
  }
}
''');

final createDealers = gql(r'''
mutation CreateDealers($dealers: [dealers_insert_input!]!) {
  insert_dealers(objects: $dealers) {
    returning {
      id
      address
      name
      link_id
      phone
    }
    affected_rows
  }
}
''');

final getDealersSubscription = gql(r'''
subscription DealersSubscription($id: uuid = "") {
  dealers(where: {created_by: {_eq: $id}}, order_by: {set_default: desc_nulls_last}) {
    id
    dealer_code
    link_id
    name
    address
    phone
    set_default
  }
}
''');
