class ArtistsResult {
  SubsonicResponse? subsonicResponse;

  ArtistsResult({this.subsonicResponse});

  ArtistsResult.fromJson(Map<String, dynamic> json) {
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
  Artists? artists;

  SubsonicResponse(
      {this.status,
        this.version,
        this.type,
        this.serverVersion,
        this.openSubsonic,
        this.artists});

  SubsonicResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    version = json['version'];
    type = json['type'];
    serverVersion = json['serverVersion'];
    openSubsonic = json['openSubsonic'];
    artists =
    json['artists'] != null ? new Artists.fromJson(json['artists']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['version'] = this.version;
    data['type'] = this.type;
    data['serverVersion'] = this.serverVersion;
    data['openSubsonic'] = this.openSubsonic;
    if (this.artists != null) {
      data['artists'] = this.artists!.toJson();
    }
    return data;
  }
}

class Artists {
  List<Index>? index;
  int? lastModified;
  String? ignoredArticles;

  Artists({this.index, this.lastModified, this.ignoredArticles});

  Artists.fromJson(Map<String, dynamic> json) {
    if (json['index'] != null) {
      index = <Index>[];
      json['index'].forEach((v) {
        index!.add(new Index.fromJson(v));
      });
    }
    lastModified = json['lastModified'];
    ignoredArticles = json['ignoredArticles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.index != null) {
      data['index'] = this.index!.map((v) => v.toJson()).toList();
    }
    data['lastModified'] = this.lastModified;
    data['ignoredArticles'] = this.ignoredArticles;
    return data;
  }
}

class Index {
  String? name;
  List<Artist>? artist;

  Index({this.name, this.artist});

  Index.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    if (json['artist'] != null) {
      artist = <Artist>[];
      json['artist'].forEach((v) {
        artist!.add(new Artist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.artist != null) {
      data['artist'] = this.artist!.map((v) => v.toJson()).toList();
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
  String? starred;

  Artist(
      {this.id,
        this.name,
        this.albumCount,
        this.coverArt,
        this.artistImageUrl,
        this.starred});

  Artist.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    albumCount = json['albumCount'];
    coverArt = json['coverArt'];
    artistImageUrl = json['artistImageUrl'];
    starred = json['starred'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['albumCount'] = this.albumCount;
    data['coverArt'] = this.coverArt;
    data['artistImageUrl'] = this.artistImageUrl;
    data['starred'] = this.starred;
    return data;
  }
}
