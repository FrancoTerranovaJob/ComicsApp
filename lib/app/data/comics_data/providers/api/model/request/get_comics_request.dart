import 'package:equatable/equatable.dart';

class GetComicsRequest extends Equatable {
  final int maxPageLength;
  final int offset;
  final int? numberOfPageResults;

  factory GetComicsRequest.fromJson(Map<String, dynamic> json) {
    return GetComicsRequest(
        maxPageLength: json['maxPageLength'],
        offset: json['offset'],
        numberOfPageResults: json['numberOfPageResults']);
  }

  const GetComicsRequest({
    required this.maxPageLength,
    required this.offset,
    this.numberOfPageResults,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    return data;
  }

  @override
  List<Object?> get props => [
        maxPageLength,
        offset,
        numberOfPageResults,
      ];
}

enum OrderType { orderASC, orderDESC }

class RequestFilters extends Equatable {
  final OrderType order;
  final String dateRange;

  const RequestFilters({
    this.order = OrderType.orderDESC,
    this.dateRange = '',
  });

  @override
  List<Object> get props => [
        order,
        dateRange,
      ];
}