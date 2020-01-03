 class session
{
   static String _userId;
  static  String _userType;
  static  DateTime _logindatetime ;


  session(String userId , String type , DateTime logindatetime){
  _userId = userId;
  _userType = type;
  _logindatetime = logindatetime;
  }

  static bool  iSNursePermessions()
  {
    if(_userType == "N") 
    return true;
    else
    return false;

  }
}