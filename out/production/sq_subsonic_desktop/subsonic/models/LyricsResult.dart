class LyricsResult {
  SubsonicResponse? subsonicResponse;

  LyricsResult({this.subsonicResponse});

  LyricsResult.fromJson(Map<String, dynamic> json) {
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
  Lyrics? lyrics;

  SubsonicResponse(
      {this.status,
        this.version,
        this.type,
        this.serverVersion,
        this.openSubsonic,
        this.lyrics});

  SubsonicResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    version = json['version'];
    type = json['type'];
    serverVersion = json['serverVersion'];
    openSubsonic = json['openSubsonic'];
    lyrics =
    json['lyrics'] != null ? new Lyrics.fromJson(json['lyrics']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['version'] = this.version;
    data['type'] = this.type;
    data['serverVersion'] = this.serverVersion;
    data['openSubsonic'] = this.openSubsonic;
    if (this.lyrics != null) {
      data['lyrics'] = this.lyrics!.toJson();
    }
    return data;
  }
}

class Lyrics {
  String? artist;
  String? title;
  String? value;

  Lyrics({this.artist, this.title, this.value});

  Lyrics.fromJson(Map<String, dynamic> json) {
    artist = json['artist'];
    title = json['title'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['artist'] = this.artist;
    data['title'] = this.title;
    data['value'] = this.value;
    return data;
  }
}
