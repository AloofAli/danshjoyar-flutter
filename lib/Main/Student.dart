
import 'package:danshjoyar/Main/BeheshtiUniversityField.dart';
import 'package:danshjoyar/Main/Gender.dart';
import 'package:danshjoyar/Main/Term.dart';

 class Student {

     String? _name;
     String? _PASSWORD;
     // final DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd ");
     Gender? _gender;
     String? _FatherName;
     // Date BirthDate;
     String? _NationalId;
     String? _StudentId;
     BeheshtiUniversityField? _field;
     String? _phoneNumber;
     List _terms = <Term>[Term()];
     int _currentTerm=0;
     bool? _isDormitory;
     double _currentAverage=0;
     double _totalAverage=0;
     int _totalPassedCredit=0;
}
