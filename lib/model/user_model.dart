class UserModel {
  int? id;
  String? username;
  String? lastname;
  String? contact;
  String? email;
  String? registerDate;
  String? isVerify;
  String? notificationToken;
  String? createdAt;
  String? updatedAt;
  String? dob;
  String? address;
  String? image;

  UserModel(
      {this.id,
        this.username,
        this.lastname,
        this.contact,
        this.email,
        this.registerDate,
        this.isVerify,
        this.notificationToken,
        this.createdAt,
        this.updatedAt,
        this.dob,
        this.address,
        this.image});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    lastname = json['lastname'];
    contact = json['contact'];
    email = json['email'];
    registerDate = json['register_date'];
    isVerify = json['is_verify'];
    notificationToken = json['notification_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    dob = json['dob'];
    address = json['address'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['lastname'] = this.lastname;
    data['contact'] = this.contact;
    data['email'] = this.email;
    data['register_date'] = this.registerDate;
    data['is_verify'] = this.isVerify;
    data['notification_token'] = this.notificationToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['dob'] = this.dob;
    data['address'] = this.address;
    data['image'] = this.image;
    return data;
  }
}
