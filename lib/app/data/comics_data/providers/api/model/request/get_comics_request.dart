import 'package:equatable/equatable.dart';

class GetComicsRequest extends Equatable {
  final int maxPageLength;
  final int offset;
  final int? numberOfPageResults;
  final String responseFormat;
  final String filters;

  factory GetComicsRequest.fromJson(Map<String, dynamic> json) {
    return GetComicsRequest(
        maxPageLength: json['maxPageLength'],
        offset: json['offset'],
        responseFormat: json['responseFormat'],
        numberOfPageResults: json['numberOfPageResults']);
  }

  const GetComicsRequest(
      {required this.maxPageLength,
      this.offset = 0,
      this.responseFormat = 'json',
      this.numberOfPageResults,
      this.filters = ''});

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    return data;
  }

  @override
  List<Object?> get props => [
        maxPageLength,
        offset,
        numberOfPageResults,
        responseFormat,
      ];
}