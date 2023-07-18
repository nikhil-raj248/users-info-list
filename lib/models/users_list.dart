class UsersListData {
  List<Users>? users;
  int? count;
  int? page;

  UsersListData({this.users, this.count, this.page});

  UsersListData.fromJson(Map<String, dynamic> json) {
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
    count = json['count'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    data['page'] = this.page;
    return data;
  }
}

class Users {
  Location? location;
  String? sId;
  String? name;
  String? email;
  String? phone;
  int? iV;
  String? createdAt;
  String? updatedAt;
  String? token;
  String? image;

  Users(
      {this.location,
        this.sId,
        this.name,
        this.email,
        this.phone,
        this.iV,
        this.createdAt,
        this.updatedAt,
        this.token,
        this.image});

  Users.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    token = json['token'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['__v'] = this.iV;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['token'] = this.token;
    data['image'] = this.image;
    return data;
  }
}

class Location {
  int? latitude;
  int? longitude;

  Location({this.latitude, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
