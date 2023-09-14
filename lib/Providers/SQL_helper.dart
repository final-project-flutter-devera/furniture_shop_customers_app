import 'package:furniture_shop/Providers/Product_class.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class SQLHelper {
  /////////////////////////////////
  ///////// GET DATABASE //////////
  ///////////////////////////////
  static Database? _database;

  static get getDatabase async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  //////////////////////////////////////////////
  //////////// INITIALIZE DATABASE ////////////
//////////////////////////////////////////////
//////////// CREATE & UPGRADE ///////////////

  static Future<Database> initDatabase() async {
    String path = p.join(await getDatabasesPath(), 'shopping_database.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute('''
CREATE TABLE cart_items (
  documentID TEXT PRIMARY KEY,
  name TEXT,
  price DOUBLE,
  quantity INTEGER,
  availableQuantity INTEGER,
  imageList TEXT,
  supplierID TEXT
)
''');

    batch.execute('''
CREATE TABLE wish_items (
  documentID TEXT PRIMARY KEY,
  name TEXT,
  price DOUBLE,
  quantity INTEGER,
  availableQuantity INTEGER,
  imageList TEXT,
  supplierID TEXT
)
''');

    batch.commit();
    print('on create was called');
  }

  //////////////////////////////////////////////////////
  /////////////// INSERT DATA INTO DATABASE ///////////
//////////////////////////////////////////////////////
  static Future insertCart(Product product) async {
    Database db = await getDatabase;
    await db.insert('cart_items', product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    print(await db.query('cart_items'));
  }

  static Future insertWish(Product product) async {
    Database db = await getDatabase;
    await db.insert('wish_items', product.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print(await db.query('wish_items'));
  }

  //////////////////////////////////////////////////////
  /////////////// RETRIEVE DATA FROM DATABASE /////////
//////////////////////////////////////////////////////
  static Future<List<Map>> loadCartItems() async {
    Database db = await getDatabase;
    return await db.query('cart_items');
  }

  static Future<List<Map>> loadWishItems() async {
    Database db = await getDatabase;
    return await db.query('wish_items');
  }

  //////////////////////////////////////////////////////
  /////////////// UPDATE DATA IN DATABASE /////////////
//////////////////////////////////////////////////////

  static Future updateQuantity(Product newProduct, String status) async {
    Database db = await getDatabase;
    await db
        .rawUpdate('UPDATE cart_items SET quantity = ? WHERE documentID = ?', [
      status == 'increment' ? newProduct.quantity + 1 : newProduct.quantity - 1,
      newProduct.documentID
    ]);
  }

  //////////////////////////////////////////////////////
  //////////////// DELETE DATA FROM DATABASE //////////
  ////////////////////////////////////////////////////

  static Future deleteCartItem(String documentID) async {
    Database db = await getDatabase;
    await db
        .delete('cart_items', where: 'documentID = ?', whereArgs: [documentID]);
  }

  static Future deleteWishItem(String documentID) async {
    Database db = await getDatabase;
    await db
        .delete('wish_items', where: 'documentID = ?', whereArgs: [documentID]);
  }

  static Future deleteAllCartItems() async {
    Database db = await getDatabase;
    await db.rawDelete('DELETE FROM cart_items');
  }

  static Future deleteAllWishItems() async {
    Database db = await getDatabase;
    await db.rawDelete('DELETE FROM wish_items');
  }
}