class SqSearchResult2 {
  SubsonicResponse? subsonicResponse;

  SqSearchResult2({this.subsonicResponse});

  SqSearchResult2.fromJson(Map<String, dynamic> json) {
    subsonicResponse = json['subsonic-response'] != null
        ? new SubsonicResponse.fromJson(json['subsonic-response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subsonicResponse != null) {
      data['subsonic-response'] = this.subsonicResponse!.toJson();
    }
    return data;
  }
}

class SubsonicResponse {
  String? status;
  String? version;
  String? type;
  String? serverVersion;
  bool? openSubsonic;
  SearchResult2? searchResult2;

  SubsonicResponse(
      {this.status,
        this.version,
        this.type,
        this.serverVersion,
        this.openSubsonic,
        this.searchResult2});

  SubsonicResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    version = json['version'];
    type = json['type'];
    serverVersion = json['serverVersion'];
    openSubsonic = json['openSubsonic'];
    searchResult2 = json['searchResult2'] != null
        ? new SearchResult2.fromJson(json['searchResult2'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['version'] = this.version;
    data['type'] = this.type;
    data['serverVersion'] = this.serverVersion;
    data['openSubsonic'] = this.openSubsonic;
    if (this.searchResult2 != null) {
      data['searchResult2'] = this.searchResult2!.toJson();
    }
    return data;
  }
}

class SearchResult2 {
  List<Artist>? artist;
  List<Album>? album;
  List<Song>? song;

  SearchResult2({this.artist, this.album, this.song});

  SearchResult2.fromJson(Map<String, dynamic> json) {
    if (json['artist'] != null) {
      artist = <Artist>[];
      json['artist'].forEach((v) {
        artist!.add(new Artist.fromJson(v));
      });
    }
    if (json['album'] != null) {
      album = <Album>[];
      json['album'].forEach((v) {
        album!.add(new Album.fromJson(v));
      });
    }
    if (json['song'] != null) {
      song = <Song>[];
      json['song'].forEach((v) {
        song!.add(new Song.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.artist != null) {
      data['artist'] = this.artist!.map((v) => v.toJson()).toList();
    }
    if (this.album != null) {
      data['album'] = this.album!.map((v) => v.toJson()).toList();
    }
    if (this.song != null) {
      data['song'] = this.song!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Artist {
  String? id;
  String? name;
  int? albumCount;
  String? coverArt;
  String? artistImageUrl;

  Artist(
      {this.id,
        this.name,
        this.albumCount,
        this.coverArt,
        this.artistImageUrl});

  Artist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    albumCount = json['albumCount'];
    coverArt = json['coverArt'];
    artistImageUrl = json['artistImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['albumCount'] = this.albumCount;
    data['coverArt'] = this.coverArt;
    data['artistImageUrl'] = this.artistImageUrl;
    return data;
  }
}

class Album {
  String? id;
  String? parent;
  bool? isDir;
  String? title;
  String? name;
  String? album;
  String? artist;
  String? genre;
  List<Genres>? genres;
  String? coverArt;
  int? duration;
  String? created;
  String? artistId;
  int? songCount;
  bool? isVideo;
  int? bpm;
  String? comment;
  int? year;
  int? playCount;
  String? played;

  Album(
      {this.id,
        this.parent,
        this.isDir,
        this.title,
        this.name,
        this.album,
        this.artist,
        this.genre,
        this.genres,
        this.coverArt,
        this.duration,
        this.created,
        this.artistId,
        this.songCount,
        this.isVideo,
        this.bpm,
        this.comment,
        this.year,
        this.playCount,
        this.played});

  Album.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parent = json['parent'];
    isDir = json['isDir'];
    title = json['title'];
    name = json['name'];
    album = json['album'];
    artist = json['artist'];
    genre = json['genre'];
    if (json['genres'] != null) {
      genres = <Genres>[];
      json['genres'].forEach((v) {
        genres!.add(new Genres.fromJson(v));
      });
    }
    coverArt = json['coverArt'];
    duration = json['duration'];
    created = json['created'];
    artistId = json['artistId'];
    songCount = json['songCount'];
    isVideo = json['isVideo'];
    bpm = json['bpm'];
    comment = json['comment'];
    year = json['year'];
    playCount = json['playCount'];
    played = json['played'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent'] = this.parent;
    data['isDir'] = this.isDir;
    data['title'] = this.title;
    data['name'] = this.name;
    data['album'] = this.album;
    data['artist'] = this.artist;
    data['genre'] = this.genre;
    if (this.genres != null) {
      data['genres'] = this.genres!.map((v) => v.toJson()).toList();
    }
    data['coverArt'] = this.coverArt;
    data['duration'] = this.duration;
    data['created'] = this.created;
    data['artistId'] = this.artistId;
    data['songCount'] = this.songCount;
    data['isVideo'] = this.isVideo;
    data['bpm'] = this.bpm;
    data['comment'] = this.comment;
    data['year'] = this.year;
    data['playCount'] = this.playCount;
    data['played'] = this.played;
    return data;
  }
}

class Genres {
  String? name;

  Genres({this.name});

  Genres.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}

class Song {
  String? id;
  String? parent;
  bool? isDir;
  String? title;
  String? album;
  String? artist;
  List<Genres>? genres;
  String? coverArt;
  int? size;
  String? contentType;
  String? suffix;
  int? duration;
  int? bitRate;
  String? path;
  String? created;
  String? albumId;
  String? artistId;
  String? type;
  bool? isVideo;
  int? bpm;
  String? comment;
  String? genre;
  int? year;
  int? track;
  int? playCount;
  String? played;

  Song(
      {this.id,
        this.parent,
        this.isDir,
        this.title,
        this.album,
        this.artist,
        this.genres,
        this.coverArt,
        this.size,
        this.contentType,
        this.suffix,
        this.duration,
        this.bitRate,
        this.path,
        this.created,
        this.albumId,
        this.artistId,
        this.type,
        this.isVideo,
        this.bpm,
        this.comment,
        this.genre,
        this.year,
        this.track,
        this.playCount,
        this.played});

  Song.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parent = json['parent'];
    isDir = json['isDir'];
    title = json['title'];
    album = json['album'];
    artist = json['artist'];
    if (json['genres'] != null) {
      genres = <Genres>[];
      json['genres'].forEach((v) {
        genres!.add(new Genres.fromJson(v));
      });
    }
    coverArt = json['coverArt'];
    size = json['size'];
    contentType = json['contentType'];
    suffix = json['suffix'];
    duration = json['duration'];
    bitRate = json['bitRate'];
    path = json['path'];
    created = json['created'];
    albumId = json['albumId'];
    artistId = json['artistId'];
    type = json['type'];
    isVideo = json['isVideo'];
    bpm = json['bpm'];
    comment = json['comment'];
    genre = json['genre'];
    year = json['year'];
    track = json['track'];
    playCount = json['playCount'];
    played = json['played'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent'] = this.parent;
    data['isDir'] = this.isDir;
    data['title'] = this.title;
    data['album'] = this.album;
    data['artist'] = this.artist;
    if (this.genres != null) {
      data['genres'] = this.genres!.map((v) => v.toJson()).toList();
    }
    data['coverArt'] = this.coverArt;
    data['size'] = this.size;
    data['contentType'] = this.contentType;
    data['suffix'] = this.suffix;
    data['duration'] = this.duration;
    data['bitRate'] = this.bitRate;
    data['path'] = this.path;
    data['created'] = this.created;
    data['albumId'] = this.albumId;
    data['artistId'] = this.artistId;
    data['type'] = this.type;
    data['isVideo'] = this.isVideo;
    data['bpm'] = this.bpm;
    data['comment'] = this.comment;
    data['genre'] = this.genre;
    data['year'] = this.year;
    data['track'] = this.track;
    data['playCount'] = this.playCount;
    data['played'] = this.played;
    return data;
  }
}
