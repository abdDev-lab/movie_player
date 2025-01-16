import '../../domain/entities/media.dart';

class MediaGenresModel extends MediaGenres {
  MediaGenresModel.fromJson(Map<String, dynamic> json) {
    genres =
        (json['genres'] as List?)?.map((e) => GenresModel.fromJson(e)).toList();
  }
}

class GenresModel extends Genres {
  GenresModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class TrailersModel extends Trailer {
  TrailersModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    site = json['site'];
    key = json['key'];
    publishedAt = json['publishedAt'];
  }
}

class CreditModel extends Credit {
  CreditModel.fromJson(Map<String, dynamic> json) {
    role = json['character']??json['role'];
    name = json['name'];
    profilePath = json['profile_path'];
  }
}
