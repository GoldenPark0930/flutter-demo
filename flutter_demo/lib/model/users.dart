class User {
  String _username;
  String _password;
  String _id;
  String _email;
  String _name;

  User(this._username,this._password);

  User.map(dynamic obj) {
    // Json to Model Object 
    this._username = obj["email"];
    this._id = obj["id"].toString();
    this._name = obj["name"];
    this._email = obj["contact_email"];
  }

  String get username => _username;
  String get password => _password;

  Map<String, dynamic> toMap() {
      // Object model to json 
      var map = new Map<String, dynamic>();
      map["username"] = _username;
      map["password"] = _password;

      return map;
  }
}