import 'dart:io';

import 'package:ngobar_vania/app/models/product.dart';
import 'package:vania/vania.dart';

class ProductController extends Controller {
  Future<Response> create(Request request) async {
    // step1 : validasi inputan dari client
    request.validate({
      'name': 'required',
      'description': 'required',
      'price': 'required'
    }, {
      'name.required': 'nama harus diisi',
      'description.required': 'deskripsi harus diisi',
      'price.required': 'harga harus diisi'
    });

    // step2 : tangkap inputan client
    var requestData = request.input();

    // step3 : cek data di db (ada atau nggak data nya )
    var cekProduct =
        await Product().query().where('name', '=', requestData['name']).first();
    if (cekProduct != null) {
      return Response.json({
        "message": "product sudah ada",
      }, HttpStatus.conflict);
    }

    // step4 : masukan data ke database
    Product().query().insert(requestData);

    // step5 : response ke client
    return Response.json({
      "message": "berhasil mendafarkan user",
      "data": requestData,
    }, HttpStatus.created);
  }
}

final ProductController productController = ProductController();
