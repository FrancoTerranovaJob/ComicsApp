import 'package:equatable/equatable.dart';

class GetComicsResponse extends Equatable {
  final List<ComicResponse> comics;
  final int remainingComicsCount;
  final int pagesCount;

  const GetComicsResponse(
      {required this.comics,
      required this.remainingComicsCount,
      required this.pagesCount});

  factory GetComicsResponse.fromJson(Map<String, dynamic> json) {
    final comicsList = List<Map<String, dynamic>>.from(json['results']);

    return GetComicsResponse(
        comics: comicsList.map((e) => ComicResponse.fromJson(e)).toList(),
        remainingComicsCount: json['number_of_total_results'],
        pagesCount: json['number_of_page_results']);
  }

  @override
  List<Object> get props => [comics, remainingComicsCount, pagesCount];
}

class ComicResponse extends Equatable {
  final int id;
  final String imageUrl;
  final String dateAdded;
  final String name;
  final String detailUrl;
  final String comicNumber;

  factory ComicResponse.fromJson(Map<String, dynamic> json) {
    var imageUrl = '';

    if (json['image'] != null) {
      imageUrl = json['image']['original_url'] ?? '';
    }

    return ComicResponse(
        id: json['id'],
        imageUrl: imageUrl,
        dateAdded: json['date_added'] ?? '',
        name: json['name'] ?? '',
        detailUrl: json['api_detail_url'] ?? '',
        comicNumber: json['issue_number']);
  }

  const ComicResponse(
      {required this.id,
      required this.imageUrl,
      required this.dateAdded,
      required this.name,
      required this.detailUrl,
      required this.comicNumber});

  @override
  List<Object> get props => [
        id,
        imageUrl,
        dateAdded,
        name,
        detailUrl,
        comicNumber,
      ];
}