import 'package:equatable/equatable.dart';

class Comic extends Equatable {
  final String originalImageUrl;
  final String dateAdded;
  final String name;
  final String comicNumber;
  final String comicDetailUrl;

  const Comic(
      {required this.originalImageUrl,
      required this.dateAdded,
      required this.name,
      required this.comicNumber,
      required this.comicDetailUrl});

  @override
  List<Object> get props =>
      [originalImageUrl, dateAdded, name, comicNumber, comicDetailUrl];
}