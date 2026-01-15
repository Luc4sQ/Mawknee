import "package:sqflite/sqflite.dart";
import "package:path/path.dart";


abstract class FinancialDatabase {
  // declare db structure
  final String tablename = "moneyactivity";
  final String name;
  final List<String> colnames = [
    "amount",
    "date",
    "id"
  ];
  late final Map<String, String> tablestruct = {
    colnames[0]: "REAL",
    colnames[1]: "INTEGER",
    colnames[2]: "INTEGER PRIMARY KEY"
  };

  String? path;

  FinancialDatabase(this.name);
}

class FinancialDatabaseConnector extends FinancialDatabase {

  Database? con;
  int length = 0;

  // the name of the saved file
  FinancialDatabaseConnector(super.name);

  Future<void> initDatabase() async {
    // create path
    path = join(await getDatabasesPath(),"$name.db");
    // create initial query
    String initQuery = "CREATE TABLE $tablename (";
    int tlen = tablestruct.length;
    for (var i = 0; i < tlen - 1; i++) {
      initQuery += "${colnames[i]} ${tablestruct[colnames[i]]}, ";
    }
    initQuery += "${colnames[tlen-1]} ${tablestruct[colnames[tlen - 1]]});";
    // init database
    con = await openDatabase(
      path!, 
      version: 1,
      onCreate: 
        (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(initQuery);
        });

    List<Map<String, Object?>>? stuff = await con?.query(tablename, 
      columns: [colnames[2]]
    );

    await Future.delayed(Duration(seconds: 2));

    length = stuff?.length ?? 0;

  }

  bool get isNull => con == null ? true : false;

  Future<void> insertDummy(int id) async {
    length++;
    int? ids = await con?.insert("moneyactivity", {"amount": 0, "id": id, "date": 0});
    print("Added");
  }


}




 