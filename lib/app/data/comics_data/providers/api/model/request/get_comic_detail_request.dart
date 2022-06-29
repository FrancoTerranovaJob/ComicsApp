import 'package:equatable/equatable.dart';

class GetComicDetailRequest extends Equatable {
  final String detailUrl;

  const GetComicDetailRequest({
    required this.detailUrl,
  });

  @override
  List<Object> get props => [
        detailUrl,
      ];
}