// To parse this JSON data, do
//
//     final chats = chatsFromJson(jsonString);

import 'dart:convert';

Chats chatsFromJson(String str) => Chats.fromJson(json.decode(str));

String chatsToJson(Chats data) => json.encode(data.toJson());

class Chats {
  Chats({
    this.connections,
    this.chats,
  });

  List<String>? connections;
  int? totalChats;
  int? totalRead;
  int? totalUnread;
  List<Chat>? chats;
  String? lastTime;

  factory Chats.fromJson(Map<String, dynamic> json) => Chats(
        connections: List<String>.from(json["connections"].map((x) => x)),
        chats: List<Chat>.from(json["chats"].map((x) => Chat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "connections": List<dynamic>.from(connections!.map((x) => x)),
        "chats": List<dynamic>.from(chats!.map((x) => x.toJson())),
      };
}

class Chat {
  Chat({
    this.pengirim,
    this.penerima,
    this.pesan,
    this.time,
    this.lastRead,
  });

  String? pengirim;
  String? penerima;
  String? pesan;
  String? time;
  bool? lastRead;

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        pengirim: json["pengirim"],
        penerima: json["penerima"],
        pesan: json["pesan"],
        time: json["time"],
        lastRead: json["lastRead"],
      );

  Map<String, dynamic> toJson() => {
        "pengirim": pengirim,
        "penerima": penerima,
        "pesan": pesan,
        "time": time,
        "lastRead": lastRead,
      };
}
