import 'package:equatable/equatable.dart';

class Comic extends Equatable {
  final String originalImageUrl;
  final String dateAdded;
  final String name;
  final String comicNumber;

  const Comic(
      {required this.originalImageUrl,
      required this.dateAdded,
      required this.name,
      required this.comicNumber});

  @override
  List<Object> get props => [
        originalImageUrl,
        dateAdded,
        name,
        comicNumber,
      ];
}