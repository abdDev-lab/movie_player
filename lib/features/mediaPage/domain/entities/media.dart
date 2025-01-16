// ignore_for_file: public_member_api_docs, sort_constructors_first
class MediaGenres {
  List<Genres>? genres;
  MediaGenres({
    this.genres,
  });
}

class Genres {
  int? id;
  String? name;
}


class Trailer {
  String? name;
  String? site;
  String? key;
  String? publishedAt;
}

class Credit {
  String? role;
  String? name;
  String? profilePath;
}

