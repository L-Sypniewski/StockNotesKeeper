import 'package:stock_notes/model/stock_note.dart';

abstract class StockDatabase {

  void add(StockNote note);
  List<StockNote> read(String stockCompany);
}