
// ignore_for_file: prefer_interpolation_to_compose_strings

// first definition of an abstract class
abstract class Activity {
  DateTime? date;
  String? metadata;

  Activity(this.date, this.metadata);
}

// def over inheritance
class MoneyActivity extends Activity {

  int transaction;

  MoneyActivity(this.transaction, {DateTime? date, String? metadata}) : super(date, metadata);

  String get decimalString => transaction.toString().substring(0, transaction.toString().length - 2) 
    + "," + transaction.toString().substring(transaction.toString().length - 2, transaction.toString().length); 
  bool get isIncome => transaction > 0;

}

