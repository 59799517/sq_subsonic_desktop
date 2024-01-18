class MusicDirectoryByAlubmResult {
  SubsonicResponse? subsonicResponse;

  MusicDirectoryByAlubmResult({this.subsonicResponse});

  MusicDirectoryByAlubmResult.fromJson(Map<String, dynamic> json) {
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
  Directory? directory;

  SubsonicResponse(
      {this.status,
        this.version,
        this.type,
        this.serverVersion,
        this.directory});

  SubsonicResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    version = json['version'];
    type = json['type'];
    serverVersion = json['serverVersion'];
    directory = json['directory'] != null
        ? new Directory.fromJson(json['directory'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['version'] = this.version;
    data['type'] = this.type;
    data['serverVersion'] = this.serverVersion;
    if (this.directory != null) {
      data['directory'] = this.directory!.toJson();
    }
    return data;
  }
}

class Directory {
  List<Child>? child;
  String? id;
  String? name;
  String? starred;
  int? playCount;
  String? played;
  int? albumCount;

  Directory(
      {this.child,
        this.id,
        this.name,
        this.starred,
        this.playCount,
        this.played,
        this.albumCount});

  Directory.fromJson(Map<String, dynamic> json) {
    if (json['child'] != null) {
      child = <Child>[];
      json['child'].forEach((v) {
        child!.add(new Child.fromJson(v));
      });
    }
    id = json['id'];
    name = json['name'];
    starred = json['starred'];
    playCount = json['playCount'];
    played = json['played'];
    albumCount = json['albumCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.child != null) {
      data['child'] = this.child!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['name'] = this.name;
    data['starred'] = this.starred;
    data['playCount'] = this.playCount;
    data['played'] = this.played;
    data['albumCount'] = this.albumCount;
    return data;
  }
}

class Child {
  String? id;
  String? parent;
  bool? isDir;
  String? title;
  String? name;
  String? album;
  String? artist;
  int? year;
  String? genre;
  String? coverArt;
  int? duration;
  int? playCount;
  String? played;
  String? created;
  String? artistId;
  int? songCount;
  bool? isVideo;

  Child(
      {this.id,
        this.parent,
        this.isDir,
        this.title,
        this.name,
        this.album,
        this.artist,
        this.year,
        this.genre,
        this.coverArt,
        this.duration,
        this.playCount,
        this.played,
        this.created,
        this.artistId,
        this.songCount,
        this.isVideo});

  Child.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parent = json['parent'];
    isDir = json['isDir'];
    title = json['title'];
    name = json['name'];
    album = json['album'];
    artist = json['artist'];
    year = json['year'];
    genre = json['genre'];
    coverArt = json['coverArt'];
    duration = json['duration'];
    playCount = json['playCount'];
    played = json['played'];
    created = json['created'];
    artistId = json['artistId'];
    songCount = json['songCount'];
    isVideo = json['isVideo'];
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
    data['coverArt'] = this.coverArt;
    data['duration'] = this.duration;
    data['playCount'] = this.playCount;
    data['played'] = this.played;
    data['created'] = this.created;
    data['artistId'] = this.artistId;
    data['songCount'] = this.songCount;
    data['isVideo'] = this.isVideo;
    return data;
  }
}
