import 'dart:html';

class StockNote {
  final String relatedStock;
  final Url sourceUrl;
  final DateTime sourceCreationDate;
  final String title;
  final List<String> content;

  StockNote(this.relatedStock, this.sourceUrl, this.sourceCreationDate, this.title, this.content);
}