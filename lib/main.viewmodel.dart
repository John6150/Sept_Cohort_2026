import 'package:dio/dio.dart';
import 'package:local_storage/dioInterceptor.dart';
import 'package:logger/web.dart';

class MainViewModel {
  Future<void> fetchProducts() async {
    final dio = GetDio().dio_();
    try {
      Response res = await dio.get('/products');
      // res = ResponseModel(

      // );
      Logger().e(res.data);
    } catch (e) {
      if (e is DioException) {
        Logger().e(e.error);
        Logger().e(e.type);
      }
      Logger().e(e);
    }
  }
}
