
class Booking {
  Booking({
    String? id,
    String? userName,
    String? userPhone,
    String? userEmail,
    String? type,
    String? address,
    String? subscription,
  }) {
    _id = id;
    _userName = userName;
    _userPhone = userPhone;
    _userEmail = userEmail;
    _type = type;
    _address = address;
    _subscription = subscription;
  }

  Booking.fromJson(dynamic json) {
    _id = json['id'];
    _userName = json['userName'];
    _userPhone = json['userPhone'];
    _userEmail = json['userEmail'];
    _type = json['type'];
    _address = json['address'];
    _subscription = json['subscription'];
  }

  String? _id;
  String? _userName;
  String? _userPhone;
  String? _userEmail;
  String? _type;
  String? _address;
  String? _subscription;

  String? get id => _id;
  String? get userName => _userName;
  String? get userEmail => _userEmail;
  String? get userPhone => _userPhone;
  String? get type => _type;
  String? get address => _address;
  String? get subscription => _subscription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['userName'] = _userName;
    map['userPhone'] = _userPhone;
    map['userEmail'] = _userEmail;
    map['type'] = _type;
    map['address'] = _address;
    map['subscription'] = _subscription;

    return map;
  }
}