import 'package:dio/dio.dart' as dio;
import 'package:intl/intl.dart';

import 'dart:convert';
import 'dart:io';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart' as shelf_router;
import 'package:shelf_static/shelf_static.dart' as shelf_static;

Future main() async {
  // If the "PORT" environment variable is set, listen to it. Otherwise, 8080.
  // https://cloud.google.com/run/docs/reference/container-contract#port
  final port = int.parse(Platform.environment['PORT'] ?? '8081');

  // See https://pub.dev/documentation/shelf/latest/shelf/Cascade-class.html
  final cascade = Cascade()
      // First, serve files from the 'public' directory
      .add(_staticHandler)
      // If a corresponding file is not found, send requests to a `Router`
      .add(_router);

  // See https://pub.dev/documentation/shelf/latest/shelf_io/serve.html
  final server = await shelf_io.serve(
    // See https://pub.dev/documentation/shelf/latest/shelf/logRequests.html
    logRequests()
        // See https://pub.dev/documentation/shelf/latest/shelf/MiddlewareExtensions/addHandler.html
        .addHandler(cascade.handler),
    InternetAddress.tryParse('127.0.0.1')!, // Allows external connections
    port,
  );

  print('Serving at http://${server.address.host}:${server.port}');
}

// Serve files from the file system.
final _staticHandler =
    shelf_static.createStaticHandler('public', defaultDocument: 'index.html');

// Router instance to handler requests.
final _router = shelf_router.Router()
  ..post('/issues', _issuesHandler)
  ..post(
    '/issue_detail',
    _issueDetailHandler,
  );

Future<Response> _issueDetailHandler(Request request) async {
  Map<String, dynamic> queryParams = request.url.queryParameters;
  final String comicDetailUrl = queryParams['detail_url'];
  final comicDetail = await dio.Dio().get(comicDetailUrl, queryParameters: {
    'api_key': '52d35075d54bfa2121e7d578a8fd15d635947f99',
    'format': 'json',
    'field_list': 'image,character_credits,team_credits,location_credits',
  });
  return Response.ok(
    jsonEncode(comicDetail.data),
    headers: {
      'content-type': 'application/json',
      // 'Cache-Control': 'public, max-age=604800',
    },
  );
}

Future<Response> _issuesHandler(Request request) async {
  final dateFormatter = DateFormat('yyyy-MM-dd');
  Map<String, dynamic> queryParams = request.url.queryParameters;
  print(queryParams);
  final startOfCurrentYear = DateTime(DateTime.now().year, 1, 1);
  final currentDate = DateTime.now();

  final formattedStartOfYearDate = dateFormatter.format(startOfCurrentYear);
  final formattedCurrentDate = dateFormatter.format(currentDate);
  final dateFilter = '$formattedStartOfYearDate|$formattedCurrentDate';
  final comics =
      await dio.Dio().get('https://comicvine.gamespot.com/api/issues',
          queryParameters: {
            'api_key': '52d35075d54bfa2121e7d578a8fd15d635947f99',
            'format': 'json',
            'limit': 30,
            'field_list':
                'id,image,date_added,name,api_detail_url,issue_number',
            'filter': 'date_added:$dateFilter',
            'sort': 'date_added:desc'
          }..addAll(queryParams));
  return Response.ok(
    jsonEncode(comics.data),
    headers: {
      'content-type': 'application/json',
      // 'Cache-Control': 'public, max-age=604800',
    },
  );
}