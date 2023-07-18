class LoginRequest {
  String? message;
  int? otp;

  LoginRequest({this.message, this.otp});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['otp'] = this.otp;
    return data;
  }
}