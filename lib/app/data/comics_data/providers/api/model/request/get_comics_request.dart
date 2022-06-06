import 'package:equatable/equatable.dart';

class GetComicsRequest extends Equatable {
  final int maxPageLength;
  final int offset;
  final int? numberOfPageResults;
  final String responseFormat;
  final RequestFilters filters;

  factory GetComicsRequest.fromJson(Map<String, dynamic> json) {
    return GetComicsRequest(
        maxPageLength: json['maxPageLength'],
        offset: json['offset'],
        responseFormat: json['responseFormat'],
        numberOfPageResults: json['numberOfPageResults']);
  }

  const GetComicsRequest(
      {required this.maxPageLength,
      required this.offset,
      this.numberOfPageResults,
      this.responseFormat = 'json',
      this.filters = const RequestFilters()});

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

enum OrderType { orderASC, orderDESC }

class RequestFilters extends Equatable {
  final OrderType order;
  final String dateRange;
  final String requiredFields;

  const RequestFilters(
      {this.order = OrderType.orderDESC,
      this.dateRange = '',
      this.requiredFields = ''});

  @override
  List<Object> get props => [order, dateRange, requiredFields];
}