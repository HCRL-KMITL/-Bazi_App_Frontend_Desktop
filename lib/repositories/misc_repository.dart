import 'package:bazi_app_frontend/constants/constants.dart';

class MiscRepository {
  String displayThaiDate(String bdate) {
    List<String> date = bdate.split("-");
    String year = (int.parse(date[0]) + 543).toString();
    return "${date[2]} ${thaiMonth[date[1]]} $year";
  }
}
