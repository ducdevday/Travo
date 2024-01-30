import 'seat_model.dart';

class SeatPlaceModel {
  final Map<String, List<bool>> positions;

  const SeatPlaceModel({
    required this.positions,
  }); //

  factory SeatPlaceModel.fromJson(Map<String, dynamic> json) {
    return SeatPlaceModel(
      positions: Map<String, List<bool>>.from(json.map((key, value) {
        return MapEntry(key, List<bool>.from(value));
      })),
    );
  }

  static SeatType getSeatType(int index){
    SeatType seatType;
    switch (index){
      case 0:
        seatType = SeatType.Bussiness;
      case 1:
        seatType = SeatType.Economy;
      default:
        seatType =  SeatType.Economy;
    }
    return seatType;
  }

  static String getChosenSeatCharacter(int seatIndex) {
    String character = "";
    switch (seatIndex) {
      case 0:
        character = "A";
        break;
      case 1:
        character = "B";
        break;
      case 2:
        character = "C";
        break;
      case 3:
        character = "D";
        break;
      case 4:
        character = "E";
        break;
      case 5:
        character = "F";
        break;
      default:
        character = "";
    }
    return character;
  }

  static int getChosenSeatIndex(String name) {
    String character = name.substring(name.length - 1);
    int chosenIndex = 0;
    switch (character) {
      case "A":
        chosenIndex = 0;
        break;
      case "B":
        chosenIndex = 1;
        break;
      case "C":
        chosenIndex = 2;
        break;
      case "D":
        chosenIndex = 3;
        break;
      case "E":
        chosenIndex = 4;
        break;
      case "F":
        chosenIndex = 5;
        break;
      default:
        chosenIndex = 0;
    }
    return chosenIndex;
  }

  static int getChosenRowIndex(String name) {
    int chosenIndex = int.parse(name.substring(0, name.length - 1));
    return chosenIndex;
  }
}
