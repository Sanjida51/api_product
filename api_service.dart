import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

class ApiService {
  static const String apiUrl = 'https://fakestoreapi.com/products';

  // Fetch products data from API
  static Future<List> getProducts() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }

  // Example of how to use CachedNetworkImage to cache images
  static Widget getCachedImage(String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => CircularProgressIndicator(), // Placeholder while loading
      errorWidget: (context, url, error) => Icon(Icons.error), // Error handling
    );
  }
}
