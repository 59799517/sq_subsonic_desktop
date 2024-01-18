class SqSearchResult3 {
  SubsonicResponse? subsonicResponse;

  SqSearchResult3({this.subsonicResponse});

  SqSearchResult3.fromJson(Map<String, dynamic> json) {
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
  SearchResult3? searchResult3;

  SubsonicResponse(
      {this.status,
        this.version,
        this.type,
        this.serverVersion,
        this.searchResult3});

  SubsonicResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    version = json['version'];
    type = json['type'];
    serverVersion = json['serverVersion'];
    searchResult3 = json['searchResult3'] != null
        ? new SearchResult3.fromJson(json['searchResult3'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['version'] = this.version;
    data['type'] = this.type;
    data['serverVersion'] = this.serverVersion;
    if (this.searchResult3 != null) {
      data['searchResult3'] = this.searchResult3!.toJson();
    }
    return data;
  }
}

class SearchResult3 {
  List<Album>? album;
  List<Song>? song;

  SearchResult3({this.album, this.song});

  SearchResult3.fromJson(Map<String, dynamic> json) {
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
    if (this.album != null) {
      data['album'] = this.album!.map((v) => v.toJson()).toList();
    }
    if (this.song != null) {
      data['song'] = this.song!.map((v) => v.toJson()).toList();
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
  String? coverArt;
  int? duration;
  String? created;
  String? artistId;
  int? songCount;
  bool? isVideo;

  Album(
      {this.id,
        this.parent,
        this.isDir,
        this.title,
        this.name,
        this.album,
        this.artist,
        this.coverArt,
        this.duration,
        this.created,
        this.artistId,
        this.songCount,
        this.isVideo});

  Album.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parent = json['parent'];
    isDir = json['isDir'];
    title = json['title'];
    name = json['name'];
    album = json['album'];
    artist = json['artist'];
    coverArt = json['coverArt'];
    duration = json['duration'];
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
    data['coverArt'] = this.coverArt;
    data['duration'] = this.duration;
    data['created'] = this.created;
    data['artistId'] = this.artistId;
    data['songCount'] = this.songCount;
    data['isVideo'] = this.isVideo;
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

  Song(
      {this.id,
        this.parent,
        this.isDir,
        this.title,
        this.album,
        this.artist,
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
        this.isVideo});

  Song.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parent = json['parent'];
    isDir = json['isDir'];
    title = json['title'];
    album = json['album'];
    artist = json['artist'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent'] = this.parent;
    data['isDir'] = this.isDir;
    data['title'] = this.title;
    data['album'] = this.album;
    data['artist'] = this.artist;
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
    return data;
  }
}
