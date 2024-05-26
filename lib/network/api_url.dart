class ApiUrl {
  // User
  static const String nickNameUpdate = "http://152.67.219.168/api/user/name";
  static const String profileImageUpdate =
      "http://152.67.219.168/api/user/image/profile";
  static const String backgroundImageUpdate =
      "http://152.67.219.168/api/user/image/background";
  static const String imageUpload = "/api/user/";
  static const String myInfo = "/api/user/myinfo";
  static const String allUsers = "/api/user/allusers";
  static const String specificusers = "/api/user/specificusers";

  // Auth
  static const String googleLogin =
      "http://152.67.219.168/api/auth/google/login";
  static const String kakaoLogin = "http://152.67.219.168/api/auth/kakao/login";
  static const String naverLogin = "http://152.67.219.168/api/auth/naver/login";
  static const String appleLogin = "http://152.67.219.168/api/auth/apple/login";
  static const String termsAgree = "http://152.67.219.168/api/auth/termsagree";
  static const String refresh = "http://152.67.219.168/api/auth/refresh";
  static const String logout = "http://152.67.219.168/api/auth/logout";
  static const String withDraw = "/api/auth/withdraw";
  static const String termsagree = "/api/auth/termsagree";

  // Location
  static const String getCode = "/api/common/location/getCode";
  static const String getNameByCodes = "/api/common/location/getnamebycodes";
  static const String getNameByCode = "/api/common/location/getnamebycode/";
  static const String getGrid = "/api/common/location/getgrid/";
  static const String freqDisrict =
      "http://152.67.219.168/api/common/location/freqdistrict";
  static const String locationDefault =
      "http://152.67.219.168/api/common/location/default";
  static const String sameGrid = "/api/common/location/samegrid/";
  static const String allDistricts =
      "http://152.67.219.168/api/common/location/alldistricts";

  // Weather
  static const String insert = "/api/common/weather/insert";
  static const String datas = "/api/common/weather/datas";
  static const String weather = "http://152.67.219.168/api/posting/weather";
  static const String weatherCount =
      "http://152.67.219.168/api/posting/weather/count";
  static const String weatherDelete = "/api/posting/weather/";
  static const String weatherPostingMy =
      "http://152.67.219.168/api/posting/weather/my";

  // Upload
  static const String posting = "http://152.67.219.168/api/posting/post";
  static const String report = "/api/posting/post/report";
  static const String like = "/api/posting/post/like";
  static const String posts = "http://152.67.219.168/api/posting/posts";
  static const String post = "/api/posting/post/";
  static const String test = "/api/posting/test";

  // Diary
  static const String myDiary =  "http://152.67.219.168/api/diary/my";
}
