class MusicDirectoryResult {
	SubsonicResponse? subsonicResponse;

	MusicDirectoryResult({this.subsonicResponse});

	MusicDirectoryResult.fromJson(Map<String, dynamic> json) {
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
	String? parent;
	int? playCount;
	String? played;
	String? coverArt;
	int? songCount;

	Directory(
			{this.child,
				this.id,
				this.name,
				this.parent,
				this.playCount,
				this.played,
				this.coverArt,
				this.songCount});

	Directory.fromJson(Map<String, dynamic> json) {
		if (json['child'] != null) {
			child = <Child>[];
			json['child'].forEach((v) {
				child!.add(new Child.fromJson(v));
			});
		}
		id = json['id'];
		name = json['name'];
		parent = json['parent'];
		playCount = json['playCount'];
		played = json['played'];
		coverArt = json['coverArt'];
		songCount = json['songCount'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.child != null) {
			data['child'] = this.child!.map((v) => v.toJson()).toList();
		}
		data['id'] = this.id;
		data['name'] = this.name;
		data['parent'] = this.parent;
		data['playCount'] = this.playCount;
		data['played'] = this.played;
		data['coverArt'] = this.coverArt;
		data['songCount'] = this.songCount;
		return data;
	}
}

class Child {
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

	Child(
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
				this.isVideo});

	Child.fromJson(Map<String, dynamic> json) {
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
		return data;
	}
}
