class PlugSearchResult {
  String? msg;
  int? code;
  Data? data;

  PlugSearchResult({this.msg, this.code, this.data});

  PlugSearchResult.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? searchKeyWork;
  int? searchIndex;
  int? searchSize;
  int? searchTotal;
  List<Records>? records;
  String? searchType;

  Data(
      {this.searchKeyWork,
        this.searchIndex,
        this.searchSize,
        this.searchTotal,
        this.records,
        this.searchType});

  Data.fromJson(Map<String, dynamic> json) {
    searchKeyWork = json['searchKeyWork'];
    searchIndex = json['searchIndex'];
    searchSize = json['searchSize'];
    searchTotal = json['searchTotal'];
    if (json['records'] != null) {
      records = <Records>[];
      json['records'].forEach((v) {
        records!.add(new Records.fromJson(v));
      });
    }
    searchType = json['searchType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['searchKeyWork'] = this.searchKeyWork;
    data['searchIndex'] = this.searchIndex;
    data['searchSize'] = this.searchSize;
    data['searchTotal'] = this.searchTotal;
    if (this.records != null) {
      data['records'] = this.records!.map((v) => v.toJson()).toList();
    }
    data['searchType'] = this.searchType;
    return data;
  }
}

class Records {
  String? id;
  String? name;
  String? artistName;
  String? artistid;
  String? pic;
  String? albumName;
  String? albumid;
  Null? lyric;
  Null? lyricId;
  String? searchType;
  String? duration;
  String? oter;

  Records(
      {this.id,
        this.name,
        this.artistName,
        this.artistid,
        this.pic,
        this.albumName,
        this.albumid,
        this.lyric,
        this.lyricId,
        this.searchType,
        this.duration,
        this.oter});

  Records.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    artistName = json['artistName'];
    artistid = json['artistid'];
    pic = json['pic'];
    albumName = json['albumName'];
    albumid = json['albumid'];
    lyric = json['lyric'];
    lyricId = json['lyricId'];
    searchType = json['searchType'];
    duration = json['duration'];
    oter = json['oter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['artistName'] = this.artistName;
    data['artistid'] = this.artistid;
    data['pic'] = this.pic;
    data['albumName'] = this.albumName;
    data['albumid'] = this.albumid;
    data['lyric'] = this.lyric;
    data['lyricId'] = this.lyricId;
    data['searchType'] = this.searchType;
    data['duration'] = this.duration;
    data['oter'] = this.oter;
    return data;
  }
}
