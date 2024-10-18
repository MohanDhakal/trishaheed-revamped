import 'package:trishaheed/model/testimonial.dart';
import '../services/BaseApi.dart';
import '../utilities/api_routes.dart';

class TestimonialRepo {
    Future<List<Testimonial>> testimonials() async {
    List<Testimonial> tList = <Testimonial>[];
    BaseApi baseApi = BaseApi.createDio();
    var response = await baseApi.get(ApiRoutes.testimonials);
    response.fold((l) {
      for (var element in l.data) {
        final testimonial = Testimonial.fromMap(element);
        tList.add(testimonial);
      }
    }, (r) {
      print("Error with code: ${r.code} and message: ${r.message}");
    });
    return tList;
  }

}