class StarResult {
  SubsonicResponse? subsonicResponse;

  StarResult({this.subsonicResponse});

  StarResult.fromJson(Map<String, dynamic> json) {
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
  Starred? starred;

  SubsonicResponse(
      {this.status, this.version, this.type, this.serverVersion, this.starred});

  SubsonicResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    version = json['version'];
    type = json['type'];
    serverVersion = json['serverVersion'];
    starred =
    json['starred'] != null ? new Starred.fromJson(json['starred']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['version'] = this.version;
    data['type'] = this.type;
    data['serverVersion'] = this.serverVersion;
    if (this.starred != null) {
      data['starred'] = this.starred!.toJson();
    }
    return data;
  }
}

class Starred {
  List<Artist>? artist;
  List<Album>? album;
  List<Song>? song;

  Starred({this.artist, this.album, this.song});

  Starred.fromJson(Map<String, dynamic> json) {
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
  String? starred;
  String? coverArt;
  String? artistImageUrl;

  Artist(
      {this.id,
        this.name,
        this.albumCount,
        this.starred,
        this.coverArt,
        this.artistImageUrl});

  Artist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    albumCount = json['albumCount'];
    starred = json['starred'];
    coverArt = json['coverArt'];
    artistImageUrl = json['artistImageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['albumCount'] = this.albumCount;
    data['starred'] = this.starred;
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
  String? coverArt;
  String? starred;
  int? duration;
  int? playCount;
  String? played;
  String? created;
  String? artistId;
  int? songCount;
  bool? isVideo;
  int? userRating;

  Album(
      {this.id,
        this.parent,
        this.isDir,
        this.title,
        this.name,
        this.album,
        this.artist,
        this.genre,
        this.coverArt,
        this.starred,
        this.duration,
        this.playCount,
        this.played,
        this.created,
        this.artistId,
        this.songCount,
        this.isVideo,
        this.userRating});

  Album.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parent = json['parent'];
    isDir = json['isDir'];
    title = json['title'];
    name = json['name'];
    album = json['album'];
    artist = json['artist'];
    genre = json['genre'];
    coverArt = json['coverArt'];
    starred = json['starred'];
    duration = json['duration'];
    playCount = json['playCount'];
    played = json['played'];
    created = json['created'];
    artistId = json['artistId'];
    songCount = json['songCount'];
    isVideo = json['isVideo'];
    userRating = json['userRating'];
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
    data['coverArt'] = this.coverArt;
    data['starred'] = this.starred;
    data['duration'] = this.duration;
    data['playCount'] = this.playCount;
    data['played'] = this.played;
    data['created'] = this.created;
    data['artistId'] = this.artistId;
    data['songCount'] = this.songCount;
    data['isVideo'] = this.isVideo;
    data['userRating'] = this.userRating;
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
  String? genre;
  String? coverArt;
  int? size;
  String? contentType;
  String? suffix;
  String? starred;
  int? duration;
  int? bitRate;
  String? path;
  int? playCount;
  String? played;
  String? created;
  String? albumId;
  String? artistId;
  String? type;
  bool? isVideo;
  int? userRating;

  Song(
      {this.id,
        this.parent,
        this.isDir,
        this.title,
        this.album,
        this.artist,
        this.genre,
        this.coverArt,
        this.size,
        this.contentType,
        this.suffix,
        this.starred,
        this.duration,
        this.bitRate,
        this.path,
        this.playCount,
        this.played,
        this.created,
        this.albumId,
        this.artistId,
        this.type,
        this.isVideo,
        this.userRating});

  Song.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parent = json['parent'];
    isDir = json['isDir'];
    title = json['title'];
    album = json['album'];
    artist = json['artist'];
    genre = json['genre'];
    coverArt = json['coverArt'];
    size = json['size'];
    contentType = json['contentType'];
    suffix = json['suffix'];
    starred = json['starred'];
    duration = json['duration'];
    bitRate = json['bitRate'];
    path = json['path'];
    playCount = json['playCount'];
    played = json['played'];
    created = json['created'];
    albumId = json['albumId'];
    artistId = json['artistId'];
    type = json['type'];
    isVideo = json['isVideo'];
    userRating = json['userRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent'] = this.parent;
    data['isDir'] = this.isDir;
    data['title'] = this.title;
    data['album'] = this.album;
    data['artist'] = this.artist;
    data['genre'] = this.genre;
    data['coverArt'] = this.coverArt;
    data['size'] = this.size;
    data['contentType'] = this.contentType;
    data['suffix'] = this.suffix;
    data['starred'] = this.starred;
    data['duration'] = this.duration;
    data['bitRate'] = this.bitRate;
    data['path'] = this.path;
    data['playCount'] = this.playCount;
    data['played'] = this.played;
    data['created'] = this.created;
    data['albumId'] = this.albumId;
    data['artistId'] = this.artistId;
    data['type'] = this.type;
    data['isVideo'] = this.isVideo;
    data['userRating'] = this.userRating;
    return data;
  }
}
