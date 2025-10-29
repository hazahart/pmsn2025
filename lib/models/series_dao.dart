import 'dart:convert';

SeriesDAO SeriesDAOFromJson(String str) => SeriesDAO.fromJson(json.decode(str));

String SeriesDAOToJson(SeriesDAO data) => json.encode(data.toJson());

class SeriesDAO {
  int seriesId;
  String url;
  String name;
  String title;
  String summary;
  String body;
  String kicker;
  String thumbUrl;
  String heroUrl;
  String titleUrl;
  String teaser;
  bool isMass;
  List<dynamic> shows;
  List<dynamic> tags;
  String platformPlayerId;
  bool hiddenFromApps;
  int relatedTagId;

  SeriesDAO({
    required this.seriesId,
    required this.url,
    required this.name,
    required this.title,
    required this.summary,
    required this.body,
    required this.kicker,
    required this.thumbUrl,
    required this.heroUrl,
    required this.titleUrl,
    required this.teaser,
    required this.isMass,
    required this.shows,
    required this.tags,
    required this.platformPlayerId,
    required this.hiddenFromApps,
    required this.relatedTagId,
  });

  factory SeriesDAO.fromJson(Map<String, dynamic> json) => SeriesDAO(
    seriesId: json["seriesId"],
    url: json["url"],
    name: json["name"],
    title: json["title"],
    summary: json["summary"],
    body: json["body"],
    kicker: json["kicker"],
    thumbUrl: json["thumbURL"],
    heroUrl: json["heroURL"],
    titleUrl: json["titleURL"],
    teaser: json["teaser"],
    isMass: json["isMass"],
    shows: List<dynamic>.from(json["shows"].map((x) => x)),
    tags: List<dynamic>.from(json["tags"].map((x) => x)),
    platformPlayerId: json["platformPlayerID"],
    hiddenFromApps: json["hiddenFromApps"],
    relatedTagId: json["relatedTagID"],
  );

  Map<String, dynamic> toJson() => {
    "seriesId": seriesId,
    "url": url,
    "name": name,
    "title": title,
    "summary": summary,
    "body": body,
    "kicker": kicker,
    "thumbURL": thumbUrl,
    "heroURL": heroUrl,
    "titleURL": titleUrl,
    "teaser": teaser,
    "isMass": isMass,
    "shows": List<dynamic>.from(shows.map((x) => x)),
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "platformPlayerID": platformPlayerId,
    "hiddenFromApps": hiddenFromApps,
    "relatedTagID": relatedTagId,
  };
}
