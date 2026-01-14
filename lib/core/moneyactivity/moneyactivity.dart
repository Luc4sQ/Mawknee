
// first definition of an abstract class
abstract class Activity {
  DateTime? date;

  Activity(this.date);
}

// def over inheritance
class MoneyActivity extends Activity {

  double transaction;

  MoneyActivity(this.transaction, {DateTime? date}) : super(date);

  bool get isIncome => transaction > 0;

}

