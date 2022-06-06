import 'package:equatable/equatable.dart';

class ComicDetail extends Equatable {
  final String originalImageUrl;
  final List<Character> characterCredits;
  final List<Team> teamCredits;
  final List<LocationCredits> locationCredits;

  const ComicDetail(
      {required this.originalImageUrl,
      required this.characterCredits,
      required this.teamCredits,
      required this.locationCredits});

  @override
  List<Object> get props => [
        originalImageUrl,
        characterCredits,
        teamCredits,
        locationCredits,
      ];
}

class LocationCredits extends Equatable {
  final String apiDetailUrl;
  final int id;
  final String name;
  final String siteDetailUrl;

  const LocationCredits(
      this.apiDetailUrl, this.id, this.name, this.siteDetailUrl);

  @override
  List<Object> get props => [apiDetailUrl, id, name, siteDetailUrl];
}

class Team extends Equatable {
  final String apiDetailUrl;
  final int id;
  final String name;
  final String siteDetailUrl;

  const Team(this.apiDetailUrl, this.id, this.name, this.siteDetailUrl);

  @override
  List<Object> get props => [apiDetailUrl, id, name, siteDetailUrl];
}

class Character extends Equatable {
  final String apiDetailUrl;
  final int id;
  final String name;
  final String siteDetailUrl;

  const Character(this.apiDetailUrl, this.id, this.name, this.siteDetailUrl);

  @override
  List<Object> get props => [apiDetailUrl, id, name, siteDetailUrl];
}