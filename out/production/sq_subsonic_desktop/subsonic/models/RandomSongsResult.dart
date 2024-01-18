class RandomSongsResult {
  SubsonicResponse? subsonicResponse;

  RandomSongsResult({this.subsonicResponse});

  RandomSongsResult.fromJson(Map<String, dynamic> json) {
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
  RandomSongs? randomSongs;

  SubsonicResponse(
      {this.status,
        this.version,
        this.type,
        this.serverVersion,
        this.openSubsonic,
        this.randomSongs});

  SubsonicResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    version = json['version'];
    type = json['type'];
    serverVersion = json['serverVersion'];
    openSubsonic = json['openSubsonic'];
    randomSongs = json['randomSongs'] != null
        ? new RandomSongs.fromJson(json['randomSongs'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['version'] = this.version;
    data['type'] = this.type;
    data['serverVersion'] = this.serverVersion;
    data['openSubsonic'] = this.openSubsonic;
    if (this.randomSongs != null) {
      data['randomSongs'] = this.randomSongs!.toJson();
    }
    return data;
  }
}

class RandomSongs {
  List<Song>? song;

  RandomSongs({this.song});

  RandomSongs.fromJson(Map<String, dynamic> json) {
    if (json['song'] != null) {
      song = <Song>[];
      json['song'].forEach((v) {
        song!.add(new Song.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.song != null) {
      data['song'] = this.song!.map((v) => v.toJson()).toList();
    }
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
  int? playCount;
  String? played;
  int? track;
  String? genre;
  int? year;
  int? discNumber;
  String? starred;
  int? bookmarkPosition;

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
        this.playCount,
        this.played,
        this.track,
        this.genre,
        this.year,
        this.discNumber,
        this.starred,
        this.bookmarkPosition});

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
    playCount = json['playCount'];
    played = json['played'];
    track = json['track'];
    genre = json['genre'];
    year = json['year'];
    discNumber = json['discNumber'];
    starred = json['starred'];
    bookmarkPosition = json['bookmarkPosition'];
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
    data['playCount'] = this.playCount;
    data['played'] = this.played;
    data['track'] = this.track;
    data['genre'] = this.genre;
    data['year'] = this.year;
    data['discNumber'] = this.discNumber;
    data['starred'] = this.starred;
    data['bookmarkPosition'] = this.bookmarkPosition;
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
