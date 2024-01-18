class PlayListsResult {
  SubsonicResponse? subsonicResponse;

  PlayListsResult({this.subsonicResponse});

  PlayListsResult.fromJson(Map<String, dynamic> json) {
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
  Playlists? playlists;

  SubsonicResponse(
      {this.status,
      this.version,
      this.type,
      this.serverVersion,
      this.playlists});

  SubsonicResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    version = json['version'];
    type = json['type'];
    serverVersion = json['serverVersion'];
    playlists = json['playlists'] != null
        ? new Playlists.fromJson(json['playlists'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['version'] = this.version;
    data['type'] = this.type;
    data['serverVersion'] = this.serverVersion;
    if (this.playlists != null) {
      data['playlists'] = this.playlists!.toJson();
    }
    return data;
  }
}

class Playlists {
  List<Playlist>? playlist;

  Playlists({this.playlist});

  Playlists.fromJson(Map<String, dynamic> json) {
    if (json['playlist'] != null) {
      playlist = <Playlist>[];
      json['playlist'].forEach((v) {
        playlist!.add(new Playlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.playlist != null) {
      data['playlist'] = this.playlist!.map((v) => v.toJson()).toList();
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

  Playlist(
      {this.id,
      this.name,
      this.songCount,
      this.duration,
      this.public,
      this.owner,
      this.created,
      this.changed,
      this.coverArt});

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
    return data;
  }
}
