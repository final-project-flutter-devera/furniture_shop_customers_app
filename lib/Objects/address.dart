class Address {
  String name;
  String phone;
  String? street;
  String? place;
  String? district;
  String? city;
  String? country;
  String? zipCode;
  double? longitude;
  double? latitude;
  bool isDefault;
  Address({
    required this.name,
    required this.phone,
    required this.street,
    required this.place,
    required this.district,
    required this.city,
    required this.zipCode,
    required this.country,
    this.longitude,
    this.latitude,
    this.isDefault = false,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
        name: json['name'] as String,
        phone: json['phone'],
        street: json['street'],
        place: json['place'],
        city: json['city'],
        district: json['state'],
        zipCode: json['zipCode'],
        country: json['country'],
        longitude: json['longitude'] as double?,
        latitude: json['latitude'] as double?,
        isDefault: json['isDefault']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'street': street,
      'city': city,
      'place': place,
      'district': district,
      'zipCode': zipCode,
      'country': country,
      'longitude': longitude,
      'latitude': latitude,
      'isDefault': isDefault,
    };
  }
}
