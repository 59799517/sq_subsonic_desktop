
class PlayMusicEntity {
  String? id;
  String? parent;
  bool? isDir;
  String? title;
  String? album;
  String? artist;
  int? track;
  int? year;
  String? genre;
  String? coverArt;
  int? size;
  String? contentType;
  String? suffix;
  int? duration;
  int? bitRate;
  String? path;
  int? playCount;
  String? played;
  int? discNumber;
  String? created;
  String? albumId;
  String? artistId;
  String? type;
  bool? isVideo;
  String? url;
  String? lyric;
  // plug为插件空为系统
  String? sourType;


  PlayMusicEntity(
      {this.id,
        this.parent,
        this.isDir,
        this.title,
        this.album,
        this.artist,
        this.track,
        this.year,
        this.genre,
        this.coverArt,
        this.size,
        this.contentType,
        this.suffix,
        this.duration,
        this.bitRate,
        this.path,
        this.playCount,
        this.played,
        this.discNumber,
        this.created,
        this.albumId,
        this.artistId,
        this.type,
        this.isVideo,
        this.url,
        this.lyric,
        this.sourType,
      });

  PlayMusicEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parent = json['parent'];
    isDir = json['isDir'];
    title = json['title'];
    album = json['album'];
    artist = json['artist'];
    track = json['track'];
    year = json['year'];
    genre = json['genre'];
    coverArt = json['coverArt'];
    size = json['size'];
    contentType = json['contentType'];
    suffix = json['suffix'];
    duration = json['duration'];
    bitRate = json['bitRate'];
    path = json['path'];
    playCount = json['playCount'];
    played = json['played'];
    discNumber = json['discNumber'];
    created = json['created'];
    albumId = json['albumId'];
    artistId = json['artistId'];
    type = json['type'];
    isVideo = json['isVideo'];
    url = json['url'];
    lyric = json['lyric'];
    sourType = json['sourType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent'] = this.parent;
    data['isDir'] = this.isDir;
    data['title'] = this.title;
    data['album'] = this.album;
    data['artist'] = this.artist;
    data['track'] = this.track;
    data['year'] = this.year;
    data['genre'] = this.genre;
    data['coverArt'] = this.coverArt;
    data['size'] = this.size;
    data['contentType'] = this.contentType;
    data['suffix'] = this.suffix;
    data['duration'] = this.duration;
    data['bitRate'] = this.bitRate;
    data['path'] = this.path;
    data['playCount'] = this.playCount;
    data['played'] = this.played;
    data['discNumber'] = this.discNumber;
    data['created'] = this.created;
    data['albumId'] = this.albumId;
    data['artistId'] = this.artistId;
    data['type'] = this.type;
    data['isVideo'] = this.isVideo;
    data['url'] = this.url;
    data['lyric'] = this.lyric;
    data['sourType'] = this.sourType;
    return data;
  }
}
