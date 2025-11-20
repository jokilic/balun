import 'account/account.dart';
import 'requests/requests.dart';
import 'subscription/subscription.dart';

class StatusInnerResponse {
  final Account? account;
  final Subscription? subscription;
  final Requests? requests;

  StatusInnerResponse({
    this.account,
    this.subscription,
    this.requests,
  });

  factory StatusInnerResponse.fromMap(Map<String, dynamic> map) => StatusInnerResponse(
    account: map['account'] != null ? Account.fromMap(map['account'] as Map<String, dynamic>) : null,
    subscription: map['subscription'] != null ? Subscription.fromMap(map['subscription'] as Map<String, dynamic>) : null,
    requests: map['requests'] != null ? Requests.fromMap(map['requests'] as Map<String, dynamic>) : null,
  );

  @override
  String toString() => 'StatusInnerResponse(account: $account, subscription: $subscription, requests: $requests)';

  @override
  bool operator ==(covariant StatusInnerResponse other) {
    if (identical(this, other)) {
      return true;
    }

    return other.account == account && other.subscription == subscription && other.requests == requests;
  }

  @override
  int get hashCode => account.hashCode ^ subscription.hashCode ^ requests.hashCode;
}
