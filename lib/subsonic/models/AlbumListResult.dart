class AlbumListResult {
  SubsonicResponse? subsonicResponse;

  AlbumListResult({this.subsonicResponse});

  AlbumListResult.fromJson(Map<String, dynamic> json) {
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
  AlbumList? albumList;

  SubsonicResponse(
      {this.status,
        this.version,
        this.type,
        this.serverVersion,
        this.openSubsonic,
        this.albumList});

  SubsonicResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    version = json['version'];
    type = json['type'];
    serverVersion = json['serverVersion'];
    openSubsonic = json['openSubsonic'];
    albumList = json['albumList'] != null
        ? new AlbumList.fromJson(json['albumList'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['version'] = this.version;
    data['type'] = this.type;
    data['serverVersion'] = this.serverVersion;
    data['openSubsonic'] = this.openSubsonic;
    if (this.albumList != null) {
      data['albumList'] = this.albumList!.toJson();
    }
    return data;
  }
}

class AlbumList {
  List<Album>? album;

  AlbumList({this.album});

  AlbumList.fromJson(Map<String, dynamic> json) {
    if (json['album'] != null) {
      album = <Album>[];
      json['album'].forEach((v) {
        album!.add(new Album.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.album != null) {
      data['album'] = this.album!.map((v) => v.toJson()).toList();
    }
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
  int? year;
  String? genre;
  List<String>? genres;
  String? coverArt;
  int? duration;
  int? playCount;
  String? played;
  String? created;
  String? artistId;
  int? songCount;
  bool? isVideo;
  int? bpm;
  String? comment;

  Album(
      {this.id,
        this.parent,
        this.isDir,
        this.title,
        this.name,
        this.album,
        this.artist,
        this.year,
        this.genre,
        this.genres,
        this.coverArt,
        this.duration,
        this.playCount,
        this.played,
        this.created,
        this.artistId,
        this.songCount,
        this.isVideo,
        this.bpm,
        this.comment});

  Album.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parent = json['parent'];
    isDir = json['isDir'];
    title = json['title'];
    name = json['name'];
    album = json['album'];
    artist = json['artist'];
    year = json['year'];
    genre = json['genre'];
    if (json['genres'] != null) {
      genres = <String>[];
      json['genres'].forEach((v) {
        genres!.add(v);
      });
    }
    coverArt = json['coverArt'];
    duration = json['duration'];
    playCount = json['playCount'];
    played = json['played'];
    created = json['created'];
    artistId = json['artistId'];
    songCount = json['songCount'];
    isVideo = json['isVideo'];
    bpm = json['bpm'];
    comment = json['comment'];
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
    data['year'] = this.year;
    data['genre'] = this.genre;
    if (this.genres != null) {
      data['genres'] = this.genres!.map((v) => v).toList();
    }
    data['coverArt'] = this.coverArt;
    data['duration'] = this.duration;
    data['playCount'] = this.playCount;
    data['played'] = this.played;
    data['created'] = this.created;
    data['artistId'] = this.artistId;
    data['songCount'] = this.songCount;
    data['isVideo'] = this.isVideo;
    data['bpm'] = this.bpm;
    data['comment'] = this.comment;
    return data;
  }
}
