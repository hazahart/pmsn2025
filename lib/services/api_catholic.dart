import 'package:dio/dio.dart';
import 'package:pmsn2020/utils/app_strings.dart';
import 'package:async/async.dart';

class ApiCatholic {
  Dio dio = Dio();
  Future<List<SeriesDAO>> getCategory(int idCategory) async {
    String URL = "${AppStrings.url_base}/json/categories/$idCategory.json";
    final response = await dio.get(URL);
    final res = response.data['series'] as List;
    return res.map((serie) => SeriesDAO.fromMap(serie)).toList();
  }

  Future<List<SeriesModel>> getAllCategories() async {
    final FutureGroup<List<SeriesDAO>> futureGroup = FutureGroup();
    futureGroup.add(getCategory(2));
    futureGroup.add(getCategory(3));
    futureGroup.add(getCategory(4));
    futureGroup.add(getCategory(5));
    futureGroup.add(getCategory(6));
    futureGroup.close();
    List<SerieDAO> listSeries = List<dynamic>.empty(growable: true);
    final List<List<dynamic>> results = await futureGroup.future;
    for (var result in results) {
      listSeries.add(result);
    }
    return listSeries;
  }


}