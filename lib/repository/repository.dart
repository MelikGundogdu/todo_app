import 'package:sqflite/sqflite.dart';
import 'package:to_do_app_android/repository/database_connection.dart';


class Repository{

  DatabaseConnection? _databaseConnection;
  Repository(){
    // Initialize database connection
    _databaseConnection = DatabaseConnection();
  }

static Database? _database;

  Future<Database?> get database async{
    if(_database != null) return _database;
    _database ??= await _databaseConnection?.setDatabase();
    return _database;
  }
  //insert data to table

  insertData(table,data) async{
    var connection = await database;
    return await connection?.insert(table, data);
  }

  //read data from table
  readData(table) async{
    var connection = await database;
    return await connection?.query(table);
  }

  readDataById(table,itemId) async{
    var connection = await database;
    return await connection?.query(table,where: 'id =?', whereArgs: [itemId]);
  }

  updateData(table ,data) async{
    var connection = await database;
    return await connection?.update(table, data,where: 'id =?', whereArgs: [data['id']]);
  }
}