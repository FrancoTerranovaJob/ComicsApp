import 'package:equatable/equatable.dart';

class GetComicDetailResponse extends Equatable {
  final String imageUrl;
  final List<CharacterCreditsResponse> characterCredits;
  final List<TeamCreditsResponse> teamCredits;
  final List<LocationCreditsResponse> locationCredits;

  const GetComicDetailResponse(
      {required this.imageUrl,
      required this.characterCredits,
      required this.teamCredits,
      required this.locationCredits});

  factory GetComicDetailResponse.fromJson(Map<String, dynamic> json) {
    final data = json['results'];
    var imageUrl = '';
    if (data['image'] != null) {
      imageUrl = data['image']['original_url'] ?? '';
    }
    final characterCreditsList =
        List<Map<String, dynamic>>.from(data['character_credits']);
    final teamCreditsList =
        List<Map<String, dynamic>>.from(data['team_credits']);
    final locationCreditsList =
        List<Map<String, dynamic>>.from(data['location_credits']);
    return GetComicDetailResponse(
        imageUrl: imageUrl,
        characterCredits: characterCreditsList
            .map((e) => CharacterCreditsResponse.fromJson(e))
            .toList(),
        teamCredits: teamCreditsList
            .map((e) => TeamCreditsResponse.fromJson(e))
            .toList(),
        locationCredits: locationCreditsList
            .map((e) => LocationCreditsResponse.fromJson(e))
            .toList());
  }

  @override
  List<Object> get props =>
      [imageUrl, characterCredits, teamCredits, locationCredits];
}

class LocationCreditsResponse extends Equatable {
  final String apiDetailUrl;
  final int id;
  final String name;
  final String siteDetailUrl;

  const LocationCreditsResponse(
      {required this.apiDetailUrl,
      required this.id,
      required this.name,
      required this.siteDetailUrl});

  factory LocationCreditsResponse.fromJson(Map<String, dynamic> json) {
    return LocationCreditsResponse(
        apiDetailUrl: json['api_detail_url'],
        id: json['id'],
        name: json['name'],
        siteDetailUrl: json['site_detail_url']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['api_detail_url'] = apiDetailUrl;
    data['id'] = id;
    data['name'] = name;
    data['site_detail_url'] = siteDetailUrl;
    return data;
  }

  @override
  List<Object> get props => [apiDetailUrl, id, name, siteDetailUrl];
}

class TeamCreditsResponse extends Equatable {
  final String apiDetailUrl;
  final int id;
  final String name;
  final String siteDetailUrl;

  const TeamCreditsResponse(
      {required this.apiDetailUrl,
      required this.id,
      required this.name,
      required this.siteDetailUrl});

  factory TeamCreditsResponse.fromJson(Map<String, dynamic> json) {
    return TeamCreditsResponse(
        apiDetailUrl: json['api_detail_url'],
        id: json['id'],
        name: json['name'],
        siteDetailUrl: json['site_detail_url']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['api_detail_url'] = apiDetailUrl;
    data['id'] = id;
    data['name'] = name;
    data['site_detail_url'] = siteDetailUrl;
    return data;
  }

  @override
  List<Object> get props => [apiDetailUrl, id, name, siteDetailUrl];
}

class CharacterCreditsResponse extends Equatable {
  final String apiDetailUrl;
  final int id;
  final String name;
  final String siteDetailUrl;

  const CharacterCreditsResponse(
      {required this.apiDetailUrl,
      required this.id,
      required this.name,
      required this.siteDetailUrl});

  factory CharacterCreditsResponse.fromJson(Map<String, dynamic> json) {
    return CharacterCreditsResponse(
        apiDetailUrl: json['api_detail_url'],
        id: json['id'],
        name: json['name'],
        siteDetailUrl: json['site_detail_url']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['api_detail_url'] = apiDetailUrl;
    data['id'] = id;
    data['name'] = name;
    data['site_detail_url'] = siteDetailUrl;
    return data;
  }

  @override
  List<Object> get props => [apiDetailUrl, id, name, siteDetailUrl];
}