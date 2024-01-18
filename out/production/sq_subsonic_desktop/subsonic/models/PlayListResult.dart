class PlayListResult {
  SubsonicResponse? subsonicResponse;

  PlayListResult({this.subsonicResponse});

  PlayListResult.fromJson(Map<String, dynamic> json) {
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
  Playlist? playlist;

  SubsonicResponse(
      {this.status,
        this.version,
        this.type,
        this.serverVersion,
        this.playlist});

  SubsonicResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    version = json['version'];
    type = json['type'];
    serverVersion = json['serverVersion'];
    playlist = json['playlist'] != null
        ? new Playlist.fromJson(json['playlist'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['version'] = this.version;
    data['type'] = this.type;
    data['serverVersion'] = this.serverVersion;
    if (this.playlist != null) {
      data['playlist'] = this.playlist!.toJson();
    }
    return data;
  }
}

class Playlist {
  String? id;
  String? name;
  int? songCount;
  int? duration;
  bool? public;
  String? owner;
  String? created;
  String? changed;
  String? coverArt;
  List<Entry>? entry;

  Playlist(
      {this.id,
        this.name,
        this.songCount,
        this.duration,
        this.public,
        this.owner,
        this.created,
        this.changed,
        this.coverArt,
        this.entry});

  Playlist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    songCount = json['songCount'];
    duration = json['duration'];
    public = json['public'];
    owner = json['owner'];
    created = json['created'];
    changed = json['changed'];
    coverArt = json['coverArt'];
    if (json['entry'] != null) {
      entry = <Entry>[];
      json['entry'].forEach((v) {
        entry!.add(new Entry.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['songCount'] = this.songCount;
    data['duration'] = this.duration;
    data['public'] = this.public;
    data['owner'] = this.owner;
    data['created'] = this.created;
    data['changed'] = this.changed;
    data['coverArt'] = this.coverArt;
    if (this.entry != null) {
      data['entry'] = this.entry!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Entry {
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

  Entry(
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

  Entry.fromJson(Map<String, dynamic> json) {
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
