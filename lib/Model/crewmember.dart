import 'User.dart';
import 'enumTypes.dart';

class CrewMember {
  String name;
  UserType type;
  String memberId;

  CrewMember(newMemberName, newMemberType, newMemberId) {
    this.name = newMemberName;
    this.type = newMemberType;
    this.memberId = newMemberId;
  }

  CrewMember.fromMap(Map snapshot, String id)
      : memberId = snapshot['id'] ?? '',
        type = User.getInstance().stringToUserTypeConvert(snapshot['type'] ?? 'Other' ) ,
        name = snapshot['name'] ?? '';




   Map<String, dynamic> toMap() {
    return {
      'id': this.memberId,
      'name': this.name,
      'type': this.type.toString().split('.').last
    };



  }
}
