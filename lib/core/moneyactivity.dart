
// first definition of an abstract class
abstract class Activity {
  DateTime? date;
  String? metadata;

  Activity(this.date, this.metadata);
}

// def over inheritance
class MoneyActivity extends Activity {

  double transaction;

  MoneyActivity(this.transaction, {DateTime? date, String? metadata}) : super(date, metadata);

  bool get isIncome => transaction > 0;

}

