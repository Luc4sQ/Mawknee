import "package:sqflite/sqflite.dart";
import "package:path/path.dart";


abstract class FinancialDatabase {
  // declare db structure
  final String name;
  final Map<String, String> tablestruct = {
    "amount": "REAL",
    "date": "INTEGER",
    "id": "INTEGER PRIMARY KEY"
  };

  String? path;

  FinancialDatabase(this.name);
}

class FinancialDatabaseConnector extends FinancialDatabase {

  Database? con;
  int length = 0;

  // the name of the saved file
  FinancialDatabaseConnector(super.name);

  void initDatabase() async {
    // create path
    path = join(await getDatabasesPath(),"$name.db");
    // create initial query
    String initQuery = "CREATE TABLE moneyactivity (";
    int tlen = tablestruct.length;
    List<String> keys = tablestruct.keys.toList();
    for (var i = 0; i < tlen - 1; i++) {
      initQuery += "${keys[i]} ${tablestruct[keys[i]]}, ";
    }
    initQuery += "${keys[tlen-1]} ${tablestruct[keys[tlen - 1]]});";
    // init database
    con = await openDatabase(
      path!, 
      version: 1,
      onCreate: 
        (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(initQuery);
        });
  }

  bool get isNull => con == null ? true : false;

  void insertDummy(int id) async {
    length++;
    int? ids = await con?.insert("moneyactivity", {"amount": 0, "id": id, "date": 0});
  }


}




 