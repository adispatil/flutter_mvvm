class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class UserData {
  String userId;
  String fullName;
  String profilePhoto;
  String phoneNumber;
  String deviceId;

  UserData(this.userId, this.fullName, this.profilePhoto,
      this.phoneNumber, this.deviceId);
}

class Authentication {
  UserData? data;

  Authentication(this.data);
}

class DeviceInfo{
  String name;
  String identifier;
  String version;
  DeviceInfo(this.name, this.identifier, this.version);
}
