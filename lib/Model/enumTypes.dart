enum InstructionType { IV,PO ,SIV,SPO}
enum BedStatus { 
  CT, 
  Cateter, 
  Fasting, 
  Infected,
  SocialAid,
  PhysoAid,
  DiatentAid,
  O2,
  Petsa,
  Invasive ,
  Pranola,
  Seodi,
  Cognitive
  }


enum BedAction { 
    Move,
    Swap,
    Clean,
    Release
  }
  
enum RoomAction { 
   Infected,
   CancelInfection
  }

  enum UserType { Doctor , Nurse, NurseShiftManager, DepartmentManager, Other}


  
enum FieldType { 
    Date,
    DateTime,
    String,
    bool
    
  }


  enum BridgeOperation{
      BuildDoctorsShift,
      BuildNursesShift,
      CleanBed,
      MoveBed,
      ReleaseBed,
      SendMessages,
      RemoveInstruction,
      AddInstruction,
      ChangeBedStatus,
      UserManagment,
      SetRoomAsInfected,
      CancelRoomInfectectionStatus
      

  }

