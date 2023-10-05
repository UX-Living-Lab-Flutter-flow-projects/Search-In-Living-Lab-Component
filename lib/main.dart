import 'dart:async';
import 'dart:convert' show utf8;
import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'dart:math' as math;
import 'dart:math';
import 'dart:typed_data' show Uint8List;

import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:collection/collection.dart';
import 'package:csv/csv.dart';
import 'package:download/download.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import 'package:flutter/scheduler.dart';

import 'package:flutter/services.dart';

import 'package:flutter_animate/flutter_animate.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:from_css_color/from_css_color.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart' as gm;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:json_path/json_path.dart';
import 'package:mime_type/mime_type.dart';
import 'package:provider/provider.dart';
import 'package:search_in_u_x_living_lab/main.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

// import '../../../flutter_flow/flutter_flow_util.dart';

// import '../flutter_flow/nav/nav.dart';

// import '/custom_code/actions/index.dart' as actions;
// import '/custom_code/widgets/index.dart' as custom_widgets;

// import '/flutter_flow/custom_functions.dart' as functions;

// import '/flutter_flow/flutter_flow_google_map.dart';

// export '../../app_state.dart';
// export '../api_manager.dart' show ApiCallResponse;
// export '../contribution_request_model.dart';
// export '../custom_web_view_page.dart' show CustomWebViewPage;
// export '../distance_placeholder_model.dart';
// export '../download_csv.dart' show downloadCsv;
// export '../dropdown_placeholder_model.dart';
// export '../email_model.dart';
// export '../exit_app.dart' show exitApp;
// export '../flutter_flow_model.dart';
// export '../internationalization.dart' show FFLocalizations;
// export '../lat_lng.dart' show LatLng;
// export '../lat_lng.dart';
// export '../launch_u_r_l_in_web_view.dart' show launchURLInWebView;
// export '../living_lab_map.dart' show LivingLabMap;
// export '../living_lab_web_view_model.dart';
// export '../nav/nav.dart';
// export '../nearby_locations_model.dart';
// export '../open_url.dart' show openUrl;
// export '../place.dart';
// export '../refresh.dart' show refresh;
// export '../reset_a_p_i_results.dart' show resetAPIResults;
// export '../serialization_util.dart';
// export '../splashscreen_model.dart';
// export '../uploaded_file.dart';
// export '/living_lab_web_view/living_lab_web_view_widget.dart';
// export '/nearby_locations/nearby_locations_widget.dart';
// export '/splashscreen/splashscreen_widget.dart' show SplashscreenWidget;
export 'dart:async' show Completer;
export 'dart:convert' show jsonEncode, jsonDecode;
export 'dart:math' show min, max;
export 'dart:typed_data' show Uint8List;
export 'package:go_router/go_router.dart';
export 'package:google_maps_flutter/google_maps_flutter.dart' hide LatLng;
export 'package:intl/intl.dart';
export 'package:page_transition/page_transition.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  bool _refreshed = true;
  bool get refreshed => _refreshed;
  set refreshed(bool _value) {
    _refreshed = _value;
  }

  LatLng? _location;
  LatLng? get location => _location;
  set location(LatLng? _value) {
    _location = _value;
  }

  String _locationName = '';
  String get locationName => _locationName;
  set locationName(String _value) {
    _locationName = _value;
  }
}

LatLng? _latLngFromString(String? val) {
  if (val == null) {
    return null;
  }
  final split = val.split(',');
  final lat = double.parse(split.first);
  final lng = double.parse(split.last);
  return LatLng(lat, lng);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}

const _kPrivateApiFunctionName = 'ffPrivateApiCall';

class GetNearbyLocationsIdCall {
  static Future<ApiCallResponse> call({
    int? radius1,
    int? radius2,
    String? centerLat = '',
    String? centerLon = '',
    String? queryString = '',
    String? limit = '60',
  }) {
    final ffApiRequestBody = '''
{
  "radius1": ${radius1},
  "radius2": ${radius2},
  "center_lat": "${centerLat}",
  "center_lon": "${centerLon}",
  "query_string": "${queryString}",
  "limit": "${limit}",
  "api_key": "EhdQUTM2K0hNLCBOYWlyb2JpLCBLZW55YSImOiQKCg2PPDr"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetNearbyLocationsId',
      apiUrl: 'https://100086.pythonanywhere.com/accounts/get-local-nearby-v2/',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic iDsList(dynamic response) => getJsonField(
        response,
        r'''$.place_id_list''',
        true,
      );
  static dynamic centerCoordinate(dynamic response) => getJsonField(
        response,
        r'''$.center_loc''',
      );
}

class GetCoordinatesCall {
  static Future<ApiCallResponse> call({
    String? location = '',
  }) {
    final ffApiRequestBody = '''
{
  "region": "${location}",
  "api_key": "EhdQUTM2K0hNLCBOYWlyb2JpLCBLZW55YSImOiQKCg2PPDr"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetCoordinates',
      apiUrl: 'https://100074.pythonanywhere.com/get-coords/',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic lat(dynamic response) => getJsonField(
        response,
        r'''$.data.location.lat''',
      );
  static dynamic lng(dynamic response) => getJsonField(
        response,
        r'''$.data.location.lng''',
      );
}

class DowellSendEmailCall {
  static Future<ApiCallResponse> call({
    String? toEmail = '',
    String? toName = '',
    String? message = '',
    String? title = 'Searching Nearby Locations Results',
  }) {
    final ffApiRequestBody = '''
{
  "toname": "${toName}",
  "toemail": "${toEmail}",
  "subject": "${title}",
  "email_content": "${message}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'DowellSendEmail',
      apiUrl: 'https://100085.pythonanywhere.com/api/email/',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
}

class SubscribeToNewsLetterCall {
  static Future<ApiCallResponse> call({
    String? subscriberEmail = '',
  }) {
    final ffApiRequestBody = '''
{
  "topic": "newsletter1",
  "subscriberEmail": "${subscriberEmail}",
  "typeOfSubscriber": "public"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'SubscribeToNewsLetter',
      apiUrl:
          'https://100085.pythonanywhere.com/uxlivinglab/newsletter/v1/4f0bd662-8456-4b2e-afa6-293d4135facf/?type=subscribe_newsletter',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic message(dynamic response) => getJsonField(
        response,
        r'''$.message''',
      );
}

class MakePaymentCall {
  static Future<ApiCallResponse> call({
    int? price,
    String? product = '',
    String? currencyCode = '',
  }) {
    final ffApiRequestBody = '''
{
  "price": ${price},
  "product": "${product}",
  "currency_code":"${currencyCode}"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'MakePayment',
      apiUrl: 'https://100088.pythonanywhere.com/api/stripe/initialize',
      callType: ApiCallType.POST,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Api-Key sgwF6fcb.RJKV99CLmI8TPM6op4SiZN9PukDJRU2p',
      },
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic detailsPageUrl(dynamic response) => getJsonField(
        response,
        r'''$.approval_url''',
      );
  static dynamic paymentId(dynamic response) => getJsonField(
        response,
        r'''$.payment_id''',
      );
}

class GetCitiesCall {
  static Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'GetCities',
      apiUrl:
          'https://100074.pythonanywhere.com/regions/johnDoe123/haikalsb1234/100074/?format=json',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic citiesName(dynamic response) => getJsonField(
        response,
        r'''$..name''',
        true,
      );
}

class GetCategoriesCall {
  static Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'GetCategories',
      apiUrl:
          'https://100086.pythonanywhere.com/accounts/get-categories/?api_key=EhdQUTM2K0hNLCBOYWlyb2JpLCBLZW55YSImOiQKCg2PPDr',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic categories(dynamic response) => getJsonField(
        response,
        r'''$.categories''',
      );
}

class GetNearbyLocationsCall {
  static Future<ApiCallResponse> call({
    List<String>? placeIdsList,
    String? centerCoord = '',
  }) {
    final placeIds = _serializeList(placeIdsList);

    final ffApiRequestBody = '''
{
  "place_id_list": ${placeIds},
  "center_loc": "${centerCoord}",
  "api_key": "EhdQUTM2K0hNLCBOYWlyb2JpLCBLZW55YSImOiQKCg2PPDr"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'GetNearbyLocations',
      apiUrl:
          'https://100086.pythonanywhere.com/accounts/get-details-list-stage1/',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }

  static dynamic locationList(dynamic response) => getJsonField(
        response,
        r'''$.succesful_results''',
        true,
      );
  static dynamic coordinates(dynamic response) => getJsonField(
        response,
        r'''$.succesful_results[:].location_coord''',
        true,
      );
}

class CalculateDistanceCall {
  static Future<ApiCallResponse> call({
    String? origins = '',
    String? destinations = '',
  }) async {
    final response = await makeCloudCall(
      _kPrivateApiFunctionName,
      {
        'callName': 'CalculateDistanceCall',
        'variables': {
          'origins': origins,
          'destinations': destinations,
        },
      },
    );
    return ApiCallResponse.fromCloudCallResponse(response);
  }

  static dynamic distance(dynamic response) => getJsonField(
        response,
        r'''$.rows[:].elements[:].distance.text''',
        true,
      );
}

class CheckCredSysCall {
  static Future<ApiCallResponse> call() {
    final ffApiRequestBody = '''
{
    "sub_service_ids": ["DOWELL100231", "DOWELL100232", "DOWELL100233", "DOWELL100234", "DOWELL100235"],
    "service_id": "DOWELL10023"
}''';
    return ApiManager.instance.makeApiCall(
      callName: 'CheckCredSys',
      apiUrl:
          'https://100105.pythonanywhere.com/api/v3/process-services/?type=product_service&api_key=0360fae8-16f6-40ce-91c2-46c6371509cf',
      callType: ApiCallType.POST,
      headers: {},
      params: {},
      body: ffApiRequestBody,
      bodyType: BodyType.JSON,
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class ThreeCall {
  static Future<ApiCallResponse> call() {
    return ApiManager.instance.makeApiCall(
      callName: 'three',
      apiUrl: 'www.google.com',
      callType: ApiCallType.GET,
      headers: {},
      params: {},
      returnBody: true,
      encodeBodyUtf8: false,
      decodeUtf8: false,
      cache: false,
    );
  }
}

class ApiPagingParams {
  int nextPageNumber = 0;
  int numItems = 0;
  dynamic lastResponse;

  ApiPagingParams({
    required this.nextPageNumber,
    required this.numItems,
    required this.lastResponse,
  });

  @override
  String toString() =>
      'PagingParams(nextPageNumber: $nextPageNumber, numItems: $numItems, lastResponse: $lastResponse,)';
}

String _serializeList(List? list) {
  list ??= <String>[];
  try {
    return json.encode(list);
  } catch (_) {
    return '[]';
  }
}

String _serializeJson(dynamic jsonVar, [bool isList = false]) {
  jsonVar ??= (isList ? [] : {});
  try {
    return json.encode(jsonVar);
  } catch (_) {
    return isList ? '[]' : '{}';
  }
}

enum ApiCallType {
  GET,
  POST,
  DELETE,
  PUT,
  PATCH,
}

enum BodyType {
  NONE,
  JSON,
  TEXT,
  X_WWW_FORM_URL_ENCODED,
  MULTIPART,
}

class ApiCallRecord extends Equatable {
  ApiCallRecord(this.callName, this.apiUrl, this.headers, this.params,
      this.body, this.bodyType);
  final String callName;
  final String apiUrl;
  final Map<String, dynamic> headers;
  final Map<String, dynamic> params;
  final String? body;
  final BodyType? bodyType;

  @override
  List<Object?> get props =>
      [callName, apiUrl, headers, params, body, bodyType];
}

class ApiCallResponse {
  const ApiCallResponse(
    this.jsonBody,
    this.headers,
    this.statusCode, {
    this.response,
  });
  final dynamic jsonBody;
  final Map<String, String> headers;
  final int statusCode;
  final http.Response? response;
  // Whether we received a 2xx status (which generally marks success).
  bool get succeeded => statusCode >= 200 && statusCode < 300;
  String getHeader(String headerName) => headers[headerName] ?? '';
  // Return the raw body from the response, or if this came from a cloud call
  // and the body is not a string, then the json encoded body.
  String get bodyText =>
      response?.body ??
      (jsonBody is String ? jsonBody as String : jsonEncode(jsonBody));

  static ApiCallResponse fromHttpResponse(
    http.Response response,
    bool returnBody,
    bool decodeUtf8,
  ) {
    var jsonBody;
    try {
      final responseBody = decodeUtf8 && returnBody
          ? const Utf8Decoder().convert(response.bodyBytes)
          : response.body;
      jsonBody = returnBody ? json.decode(responseBody) : null;
    } catch (_) {}
    return ApiCallResponse(
      jsonBody,
      response.headers,
      response.statusCode,
      response: response,
    );
  }

  static ApiCallResponse fromCloudCallResponse(Map<String, dynamic> response) =>
      ApiCallResponse(
        response['body'],
        ApiManager.toStringMap(response['headers'] ?? {}),
        response['statusCode'] ?? 400,
      );
}

class ApiManager {
  ApiManager._();

  // Cache that will ensure identical calls are not repeatedly made.
  static Map<ApiCallRecord, ApiCallResponse> _apiCache = {};

  static ApiManager? _instance;
  static ApiManager get instance => _instance ??= ApiManager._();

  // If your API calls need authentication, populate this field once
  // the user has authenticated. Alter this as needed.
  static String? _accessToken;

  // You may want to call this if, for example, you make a change to the
  // database and no longer want the cached result of a call that may
  // have changed.
  static void clearCache(String callName) => _apiCache.keys
      .toSet()
      .forEach((k) => k.callName == callName ? _apiCache.remove(k) : null);

  static Map<String, String> toStringMap(Map map) =>
      map.map((key, value) => MapEntry(key.toString(), value.toString()));

  static String asQueryParams(Map<String, dynamic> map) => map.entries
      .map((e) =>
          "${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value.toString())}")
      .join('&');

  static Future<ApiCallResponse> urlRequest(
    ApiCallType callType,
    String apiUrl,
    Map<String, dynamic> headers,
    Map<String, dynamic> params,
    bool returnBody,
    bool decodeUtf8,
  ) async {
    if (params.isNotEmpty) {
      final specifier =
          Uri.parse(apiUrl).queryParameters.isNotEmpty ? '&' : '?';
      apiUrl = '$apiUrl$specifier${asQueryParams(params)}';
    }
    final makeRequest = callType == ApiCallType.GET ? http.get : http.delete;
    final response =
        await makeRequest(Uri.parse(apiUrl), headers: toStringMap(headers));
    return ApiCallResponse.fromHttpResponse(response, returnBody, decodeUtf8);
  }

  static Future<ApiCallResponse> requestWithBody(
    ApiCallType type,
    String apiUrl,
    Map<String, dynamic> headers,
    Map<String, dynamic> params,
    String? body,
    BodyType? bodyType,
    bool returnBody,
    bool encodeBodyUtf8,
    bool decodeUtf8,
  ) async {
    assert(
      {ApiCallType.POST, ApiCallType.PUT, ApiCallType.PATCH}.contains(type),
      'Invalid ApiCallType $type for request with body',
    );
    final postBody =
        createBody(headers, params, body, bodyType, encodeBodyUtf8);

    if (bodyType == BodyType.MULTIPART) {
      return multipartRequest(
          type, apiUrl, headers, params, returnBody, decodeUtf8);
    }

    final requestFn = {
      ApiCallType.POST: http.post,
      ApiCallType.PUT: http.put,
      ApiCallType.PATCH: http.patch,
    }[type]!;
    final response = await requestFn(Uri.parse(apiUrl),
        headers: toStringMap(headers), body: postBody);
    return ApiCallResponse.fromHttpResponse(response, returnBody, decodeUtf8);
  }

  static Future<ApiCallResponse> multipartRequest(
    ApiCallType? type,
    String apiUrl,
    Map<String, dynamic> headers,
    Map<String, dynamic> params,
    bool returnBody,
    bool decodeUtf8,
  ) async {
    assert(
      {ApiCallType.POST, ApiCallType.PUT, ApiCallType.PATCH}.contains(type),
      'Invalid ApiCallType $type for request with body',
    );
    bool Function(dynamic) _isFile = (e) =>
        e is FFUploadedFile ||
        e is List<FFUploadedFile> ||
        (e is List && e.firstOrNull is FFUploadedFile);

    final nonFileParams = toStringMap(
        Map.fromEntries(params.entries.where((e) => !_isFile(e.value))));

    List<http.MultipartFile> files = [];
    params.entries.where((e) => _isFile(e.value)).forEach((e) {
      final param = e.value;
      final uploadedFiles = param is List
          ? param as List<FFUploadedFile>
          : [param as FFUploadedFile];
      uploadedFiles.forEach((uploadedFile) => files.add(
            http.MultipartFile.fromBytes(
              e.key,
              uploadedFile.bytes ?? Uint8List.fromList([]),
              filename: uploadedFile.name,
              contentType: _getMediaType(uploadedFile.name),
            ),
          ));
    });

    final request = http.MultipartRequest(
        type.toString().split('.').last, Uri.parse(apiUrl))
      ..headers.addAll(toStringMap(headers))
      ..files.addAll(files);
    nonFileParams.forEach((key, value) => request.fields[key] = value);

    final response = await http.Response.fromStream(await request.send());
    return ApiCallResponse.fromHttpResponse(response, returnBody, decodeUtf8);
  }

  static MediaType? _getMediaType(String? filename) {
    final contentType = mime(filename);
    if (contentType == null) {
      return null;
    }
    final parts = contentType.split('/');
    if (parts.length != 2) {
      return null;
    }
    return MediaType(parts.first, parts.last);
  }

  static dynamic createBody(
    Map<String, dynamic> headers,
    Map<String, dynamic>? params,
    String? body,
    BodyType? bodyType,
    bool encodeBodyUtf8,
  ) {
    String? contentType;
    dynamic postBody;
    switch (bodyType) {
      case BodyType.JSON:
        contentType = 'application/json';
        postBody = body ?? json.encode(params ?? {});
        break;
      case BodyType.TEXT:
        contentType = 'text/plain';
        postBody = body ?? json.encode(params ?? {});
        break;
      case BodyType.X_WWW_FORM_URL_ENCODED:
        contentType = 'application/x-www-form-urlencoded';
        postBody = toStringMap(params ?? {});
        break;
      case BodyType.MULTIPART:
        contentType = 'multipart/form-data';
        postBody = params;
        break;
      case BodyType.NONE:
      case null:
        break;
    }
    // Set "Content-Type" header if it was previously unset.
    if (contentType != null &&
        !headers.keys.any((h) => h.toLowerCase() == 'content-type')) {
      headers['Content-Type'] = contentType;
    }
    return encodeBodyUtf8 && postBody is String
        ? utf8.encode(postBody)
        : postBody;
  }

  Future<ApiCallResponse> makeApiCall({
    required String callName,
    required String apiUrl,
    required ApiCallType callType,
    Map<String, dynamic> headers = const {},
    Map<String, dynamic> params = const {},
    String? body,
    BodyType? bodyType,
    bool returnBody = true,
    bool encodeBodyUtf8 = false,
    bool decodeUtf8 = false,
    bool cache = false,
  }) async {
    final callRecord =
        ApiCallRecord(callName, apiUrl, headers, params, body, bodyType);
    // Modify for your specific needs if this differs from your API.
    if (_accessToken != null) {
      headers[HttpHeaders.authorizationHeader] = 'Token $_accessToken';
    }
    if (!apiUrl.startsWith('http')) {
      apiUrl = 'https://$apiUrl';
    }

    // If we've already made this exact call before and caching is on,
    // return the cached result.
    if (cache && _apiCache.containsKey(callRecord)) {
      return _apiCache[callRecord]!;
    }

    ApiCallResponse result;
    switch (callType) {
      case ApiCallType.GET:
      case ApiCallType.DELETE:
        result = await urlRequest(
          callType,
          apiUrl,
          headers,
          params,
          returnBody,
          decodeUtf8,
        );
        break;
      case ApiCallType.POST:
      case ApiCallType.PUT:
      case ApiCallType.PATCH:
        result = await requestWithBody(
          callType,
          apiUrl,
          headers,
          params,
          body,
          bodyType,
          returnBody,
          encodeBodyUtf8,
          decodeUtf8,
        );
        break;
    }

    // If caching is on, cache the result (if present).
    if (cache) {
      _apiCache[callRecord] = result;
    }

    return result;
  }
}

Future<Map<String, dynamic>> makeCloudCall(
  String callName,
  Map<String, dynamic> input,
) async {
  try {
    final response = await FirebaseFunctions.instance
        .httpsCallable(callName, options: HttpsCallableOptions())
        .call(input);
    return response.data is Map
        ? Map<String, dynamic>.from(response.data as Map)
        : {};
  } on FirebaseFunctionsException catch (e) {
    if (e is FirebaseFunctionsException) {
      print(
        'Cloud call error!\n'
        'Code: ${e.code}\n'
        'Details: ${e.details}\n'
        'Message: ${e.message}',
      );
    } else {
      print('Cloud call error: $e');
    }
    return {};
  }
}

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDpGygMEesMI1tucBfXILDD-JiZv54D5Mg",
            authDomain: "search-livinglab-map.firebaseapp.com",
            projectId: "search-livinglab-map",
            storageBucket: "search-livinglab-map.appspot.com",
            messagingSenderId: "482902116718",
            appId: "1:482902116718:web:4f5fc32085610cff77997f",
            measurementId: "G-J2312KVQ70"));
  } else {
    await Firebase.initializeApp();
  }
}

class ContributionRequestModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for amount widget.
  TextEditingController? amountController;
  String? Function(BuildContext, String?)? amountControllerValidator;
  String? _amountControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    return null;
  }

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    amountControllerValidator = _amountControllerValidator;
  }

  void dispose() {
    amountController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}

class ContributionRequestWidget extends StatefulWidget {
  const ContributionRequestWidget({
    Key? key,
    required this.locations,
    this.query,
    required this.location,
    required this.distances,
  }) : super(key: key);

  final List<dynamic>? locations;
  final String? query;
  final String? location;
  final List<String>? distances;

  @override
  _ContributionRequestWidgetState createState() =>
      _ContributionRequestWidgetState();
}

class _ContributionRequestWidgetState extends State<ContributionRequestWidget> {
  late ContributionRequestModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ContributionRequestModel());

    _model.amountController ??= TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: MediaQuery.sizeOf(context).width > kBreakpointMedium
          ? (MediaQuery.sizeOf(context).width * 0.6)
          : (MediaQuery.sizeOf(context).width * 0.98),
      height: MediaQuery.sizeOf(context).height > kBreakpointMedium
          ? (MediaQuery.sizeOf(context).height * 0.35)
          : (MediaQuery.sizeOf(context).height * 0.6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FlutterFlowIconButton(
                  borderColor: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: 20.0,
                  borderWidth: 1.0,
                  buttonSize: 40.0,
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                  icon: Icon(
                    Icons.close_rounded,
                    color: FlutterFlowTheme.of(context).primary,
                    size: 24.0,
                  ),
                  showLoadingIndicator: true,
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(0.0),
              child: Image.asset(
                'assets/images/fa6-solid_hand-holding-dollar.png',
                width: 48.0,
                height: 43.0,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Contribute',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(12.0, 4.0, 12.0, 12.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      child: Text(
                        'If you found the information is useful contribute',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFF57636C),
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: _model.formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FlutterFlowDropDown<String>(
                    controller: _model.dropDownValueController ??=
                        FormFieldController<String>(
                      _model.dropDownValue ??= 'USD',
                    ),
                    options: [
                      'USD',
                      'EUR',
                      'JPY',
                      'GBP',
                      'AUD',
                      'CAD',
                      'CHF',
                      'CNH',
                      'INR'
                    ],
                    onChanged: (val) =>
                        setState(() => _model.dropDownValue = val),
                    width: 170.0,
                    height: 50.0,
                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Poppins',
                          color: Colors.black,
                        ),
                    hintText: 'Please select...',
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Color(0xFF57636C),
                      size: 24.0,
                    ),
                    fillColor: Colors.white,
                    elevation: 2.0,
                    borderColor: FlutterFlowTheme.of(context).alternate,
                    borderWidth: 2.0,
                    borderRadius: 8.0,
                    margin:
                        EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
                    hidesUnderline: true,
                    isSearchable: false,
                    isMultiSelect: false,
                  ),
                  Container(
                    width: 170.0,
                    child: TextFormField(
                      controller: _model.amountController,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Amount',
                        labelStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF14181B),
                                ),
                        hintText: 'Enter amount ',
                        hintStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF14181B),
                                  fontWeight: FontWeight.w300,
                                ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).alternate,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primary,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Poppins',
                            color: Color(0xFF14181B),
                          ),
                      keyboardType: TextInputType.number,
                      cursorColor: Color(0xFF570861),
                      validator: _model.amountControllerValidator!
                          .asValidator(context),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                      ],
                    ),
                  ),
                ].divide(SizedBox(width: 16.0)),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.00, -1.00),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 12.0, 0.0, 0.0),
                          child: FFButtonWidget(
                            onPressed: () {
                              print('PayLaterButton pressed ...');
                            },
                            text: 'Email',
                            options: FFButtonOptions(
                              width: 110.0,
                              height: 50.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: Colors.white,
                              textStyle: GoogleFonts.getFont(
                                'Poppins',
                                color: FlutterFlowTheme.of(context).primary,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                                height: 1.2,
                              ),
                              elevation: 2.0,
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).primary,
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 12.0, 0.0, 0.0),
                          child: FFButtonWidget(
                            onPressed: () {
                              print('PayNowButton pressed ...');
                            },
                            text: 'Now',
                            options: FFButtonOptions(
                              width: 110.0,
                              height: 50.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: GoogleFonts.getFont(
                                'Poppins',
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              ),
                              elevation: 2.0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ].divide(SizedBox(width: 16.0)),
                    ),
                  ].divide(SizedBox(width: 4.0)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DistancePlaceholderModel extends FlutterFlowModel {
  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}

class DistancePlaceholderWidget extends StatefulWidget {
  const DistancePlaceholderWidget({Key? key}) : super(key: key);

  @override
  _DistancePlaceholderWidgetState createState() =>
      _DistancePlaceholderWidgetState();
}

class _DistancePlaceholderWidgetState extends State<DistancePlaceholderWidget> {
  late DistancePlaceholderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DistancePlaceholderModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Text(
      'Calculating distance...',
      style: FlutterFlowTheme.of(context).bodyLarge,
    );
  }
}

class DropdownPlaceholderModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this component.

  // State field(s) for Query widget.
  String? queryValue;
  FormFieldController<String>? queryValueController;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {}

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}

class DropdownPlaceholderWidget extends StatefulWidget {
  const DropdownPlaceholderWidget({Key? key}) : super(key: key);

  @override
  _DropdownPlaceholderWidgetState createState() =>
      _DropdownPlaceholderWidgetState();
}

class _DropdownPlaceholderWidgetState extends State<DropdownPlaceholderWidget> {
  late DropdownPlaceholderModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DropdownPlaceholderModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FlutterFlowDropDown<String>(
      controller: _model.queryValueController ??=
          FormFieldController<String>(null),
      options: <String>[],
      onChanged: (val) => setState(() => _model.queryValue = val),
      width: MediaQuery.sizeOf(context).width * 0.5,
      textStyle: GoogleFonts.getFont(
        'Poppins',
        color: Color(0xFFB4B4B4),
        fontWeight: FontWeight.normal,
        fontSize: 16.0,
      ),
      hintText: 'Loading items..',
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: Color(0xFF57636C),
        size: 24.0,
      ),
      fillColor: Colors.white,
      elevation: 8.0,
      borderColor: Color(0xFFB4B4B4),
      borderWidth: 1.0,
      borderRadius: 8.0,
      margin: EdgeInsetsDirectional.fromSTEB(6.0, 0.0, 0.0, 0.0),
      hidesUnderline: true,
      isSearchable: false,
      isMultiSelect: false,
    );
  }
}

class EmailModel extends FlutterFlowModel {
  ///  Local state fields for this component.

  bool? subscribeToNewsLetter;

  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for toEmail widget.
  TextEditingController? toEmailController;
  String? Function(BuildContext, String?)? toEmailControllerValidator;
  String? _toEmailControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Field is required';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Has to be a valid email address.';
    }
    return null;
  }

  // Stores action output result for [Backend Call - API (DowellSendEmail)] action in EmailButton widget.
  ApiCallResponse? sendEmailResult;
  // Stores action output result for [Backend Call - API (DowellSendEmail)] action in EmailButton widget.
  ApiCallResponse? sendCopyEmailResult;
  // Stores action output result for [Backend Call - API (SubscribeToNewsLetter)] action in EmailButton widget.
  ApiCallResponse? apiResultc4k;
  // Stores action output result for [Backend Call - API (DowellSendEmail)] action in PayLaterButton widget.
  ApiCallResponse? pEmail;
  // Stores action output result for [Backend Call - API (DowellSendEmail)] action in PayLaterButton widget.
  ApiCallResponse? dEmail;
  // Stores action output result for [Backend Call - API (SubscribeToNewsLetter)] action in PayLaterButton widget.
  ApiCallResponse? apiResultc;
  // State field(s) for NewsletterCheckbox widget.
  bool? newsletterCheckboxValue;
  // Stores action output result for [Backend Call - API (MakePayment)] action in contribute widget.
  ApiCallResponse? paymentResults;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    toEmailControllerValidator = _toEmailControllerValidator;
  }

  void dispose() {
    toEmailController?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}

class EmailWidget extends StatefulWidget {
  const EmailWidget({
    Key? key,
    required this.locations,
    this.query,
    required this.location,
    required this.distances,
    required this.distance,
  }) : super(key: key);

  final List<dynamic>? locations;
  final String? query;
  final String? location;
  final List<String>? distances;
  final double? distance;

  @override
  _EmailWidgetState createState() => _EmailWidgetState();
}

class _EmailWidgetState extends State<EmailWidget> {
  late EmailModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EmailModel());

    _model.toEmailController ??= TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      width: () {
        if (MediaQuery.sizeOf(context).width < kBreakpointSmall) {
          return MediaQuery.sizeOf(context).width;
        } else if (MediaQuery.sizeOf(context).width < kBreakpointMedium) {
          return (MediaQuery.sizeOf(context).width * 0.85);
        } else if (MediaQuery.sizeOf(context).width < kBreakpointLarge) {
          return (MediaQuery.sizeOf(context).width * 0.65);
        } else {
          return (MediaQuery.sizeOf(context).width * 0.35);
        }
      }(),
      height: 290.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: AlignmentDirectional(1.00, -1.00),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FlutterFlowIconButton(
                  borderColor: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: 20.0,
                  borderWidth: 1.0,
                  buttonSize: 40.0,
                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                  icon: Icon(
                    Icons.close_rounded,
                    color: FlutterFlowTheme.of(context).primary,
                    size: 24.0,
                  ),
                  showLoadingIndicator: true,
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  child: Form(
                    key: _model.formKey,
                    autovalidateMode: AutovalidateMode.always,
                    child: Container(
                      width: 200.0,
                      decoration: BoxDecoration(),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 8.0, 8.0, 8.0),
                            child: TextFormField(
                              controller: _model.toEmailController,
                              autofocus: true,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'To Email',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF14181B),
                                    ),
                                hintText: 'Enter your/friends email address',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF14181B),
                                      fontWeight: FontWeight.w300,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        FlutterFlowTheme.of(context).alternate,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).primary,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 2.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                prefixIcon: Icon(
                                  Icons.attach_email_sharp,
                                  color: FlutterFlowTheme.of(context).secondary,
                                ),
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Poppins',
                                    color: Color(0xFF14181B),
                                  ),
                              keyboardType: TextInputType.emailAddress,
                              cursorColor: Color(0xFF570861),
                              validator: _model.toEmailControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          if (_model.formKey.currentState == null ||
                              !_model.formKey.currentState!.validate()) {
                            return;
                          }
                          _model.sendEmailResult =
                              await DowellSendEmailCall.call(
                            toEmail: _model.toEmailController.text,
                            toName:
                                getNameFromEmail(_model.toEmailController.text),
                            message: formatJsonToEmailBody(
                                widget.locations!.toList(),
                                'The search result for ${widget.query} in ${widget.location} within ${widget.distance?.toString()} meters, ${widget.locations?.length?.toString()}  results found.  Thank you ${_model.toEmailController.text} for using DoWell UX Living Lab. Search results limited to maximum 60.',
                                widget.distances?.toList(),
                                _model.toEmailController.text,
                                widget.query!,
                                widget.location!,
                                widget.distance!.toString()),
                          );
                          _model.sendCopyEmailResult =
                              await DowellSendEmailCall.call(
                            toEmail: 'dowell@dowellresearch.uk',
                            toName: 'Dowell Research',
                            message: formatJsonToEmailBody(
                                widget.locations!.toList(),
                                'The search result for ${widget.query} in ${widget.location} within ${widget.distance?.toString()} meters, ${widget.locations?.length?.toString()}  results found.  Thank you ${_model.toEmailController.text} for using DoWell UX Living Lab. Search results limited to maximum 60.',
                                widget.distances?.toList(),
                                _model.toEmailController.text,
                                widget.query!,
                                widget.location!,
                                widget.distance!.toString()),
                          );
                          if (_model.newsletterCheckboxValue!) {
                            _model.apiResultc4k =
                                await SubscribeToNewsLetterCall.call(
                              subscriberEmail: _model.toEmailController.text,
                            );
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: Text('Newsletter Subscription'),
                                  content:
                                      Text(SubscribeToNewsLetterCall.message(
                                    (_model.apiResultc4k?.jsonBody ?? ''),
                                  ).toString()),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(alertDialogContext),
                                      child: Text('Ok'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                          await showDialog(
                            context: context,
                            builder: (alertDialogContext) {
                              return AlertDialog(
                                title: Text('Email Sent Status'),
                                content: Text(DowellSendEmailCall.message(
                                  (_model.sendEmailResult?.jsonBody ?? ''),
                                ).toString()),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(alertDialogContext),
                                    child: Text('Ok'),
                                  ),
                                ],
                              );
                            },
                          );
                          Navigator.pop(context);

                          setState(() {});
                        },
                        text: 'Send to email',
                        options: FFButtonOptions(
                          width: 160.0,
                          height: 50.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          textStyle:
                              FlutterFlowTheme.of(context).titleSmall.override(
                                    fontFamily: 'Lexend Deca',
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                          elevation: 2.0,
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primary,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
                      child: FFButtonWidget(
                        onPressed: () async {
                          if (_model.formKey.currentState == null ||
                              !_model.formKey.currentState!.validate()) {
                            return;
                          }
                          Navigator.pop(context);
                          await downloadCsv(
                            widget.locations!.toList(),
                            widget.distances!.toList(),
                            _model.toEmailController!.text,
                            widget.query!,
                            widget.location!,
                            widget.distance!.toString(),
                          );
                          _model.pEmail = await DowellSendEmailCall.call(
                            toEmail: _model.toEmailController!.text,
                            toName: getNameFromEmail(
                                _model.toEmailController!.text),
                            message:
                                'You have downloaded the search result successfully to ${_model.toEmailController!.text} for ${widget.query} in ${widget.location} within ${widget.distance?.toString()} meters, ${widget.locations?.length?.toString()}  results found.  Thank you for using DoWell UX Living Lab. Search results limited to maximum 60.',
                          );
                          _model.dEmail = await DowellSendEmailCall.call(
                            toEmail: 'dowell@dowellresearch.uk',
                            toName: 'Dowell Research',
                            message: formatJsonToEmailBody(
                                widget.locations!.toList(),
                                'You have downloaded the search result successfully to ${_model.toEmailController!.text} for ${widget.query} in ${widget.location} within ${widget.distance?.toString()} meters, ${widget.locations?.length?.toString()}  results found.  Thank you for using DoWell UX Living Lab. Search results limited to maximum 60.',
                                widget.distances?.toList(),
                                _model.toEmailController!.text,
                                widget.query!,
                                widget.location!,
                                widget.distance!.toString()),
                          );
                          if (_model.newsletterCheckboxValue!) {
                            _model.apiResultc =
                                await SubscribeToNewsLetterCall.call(
                              subscriberEmail: _model.toEmailController!.text,
                            );
                            await showDialog(
                              context: context,
                              builder: (alertDialogContext) {
                                return AlertDialog(
                                  title: Text('Newsletter Subscription'),
                                  content:
                                      Text(SubscribeToNewsLetterCall.message(
                                    (_model.apiResultc4k?.jsonBody ?? ''),
                                  ).toString()),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(alertDialogContext),
                                      child: Text('Ok'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }

                          setState(() {});
                        },
                        text: 'Download',
                        options: FFButtonOptions(
                          width: 170.0,
                          height: 50.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FlutterFlowTheme.of(context).primary,
                          textStyle: GoogleFonts.getFont(
                            'Poppins',
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0,
                            height: 1.2,
                          ),
                          elevation: 2.0,
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).secondary,
                            width: 1.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(12.0, 4.0, 12.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Theme(
                        data: ThemeData(
                          checkboxTheme: CheckboxThemeData(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                          ),
                          unselectedWidgetColor: Color(0xFF57636C),
                        ),
                        child: Checkbox(
                          value: _model.newsletterCheckboxValue ??= false,
                          onChanged: (newValue) async {
                            setState(() =>
                                _model.newsletterCheckboxValue = newValue!);
                          },
                          activeColor: FlutterFlowTheme.of(context).primary,
                          checkColor: Colors.white,
                        ),
                      ),
                      Text(
                        'Subscribe to Newsletter',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodySmall.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFF57636C),
                            ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 8.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      if (_model.formKey.currentState == null ||
                          !_model.formKey.currentState!.validate()) {
                        return;
                      }
                      if (isWeb) {
                        await openUrl(
                          '\"url\"',
                        );
                      } else {
                        _model.paymentResults = await MakePaymentCall.call(
                          product: 'Search LivingLab Maps',
                          price: 12,
                          currencyCode: 'INR',
                        );
                        if ((_model.paymentResults?.succeeded ?? true)) {
                          context.pushNamed(
                            'LivingLabWebView',
                            queryParameters: {
                              'url': serializeParam(
                                MakePaymentCall.detailsPageUrl(
                                  (_model.paymentResults?.jsonBody ?? ''),
                                ).toString(),
                                ParamType.String,
                              ),
                            }.withoutNulls,
                          );
                        }
                      }

                      Navigator.pop(context);

                      setState(() {});
                    },
                    text: 'Contribute',
                    options: FFButtonOptions(
                      width: 170.0,
                      height: 50.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle: GoogleFonts.getFont(
                        'Poppins',
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                      elevation: 2.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      hoverColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      hoverTextColor: FlutterFlowTheme.of(context).primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// Automatic FlutterFlow imports
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future downloadCsv(List<dynamic> docs, List<String> distances, String email,
    String searchWord, String searchLocation, String distanceRange) async {
  get(int index, List list) {
    try {
      return list[index];
    } on RangeError {
      return null;
    }
  }

  // //Set Metadata
  // List metadata = [
  //   "Date of Search",
  //   "Time of search",
  //   "User Name",
  //   "User Email",
  //   "Search Word",
  //   "Search Location",
  //   "From Distance",
  //   "To Distance"
  // ];
  DateTime now = new DateTime.now();
  DateFormat date = DateFormat.yMMMMd('en_US');
  DateFormat time = DateFormat('Hms');

  // List<String> metadataValues = [
  //   date.format(now),
  //   time.format(now)
  //   "UxLivingLab",
  //   email,
  //   searchWord,
  //   searchLocation,
  //   "0 meters",
  //   "$distance meters"
  // ];

  // Set the header
  List header = [
    "Date of Search",
    "Time of search",
    "User Name",
    "User Email",
    "Search Word",
    "Search Location",
    "From Distance",
    "To Distance",
    "Name",
    "Category",
    "Address",
    "Distance from City Center",
    "Day Hours",
    "Phone Number",
    "Website",
  ];

  List<List<dynamic>> fileContent = [];
  fileContent.add(header);

  docs.asMap().forEach((index, record) {
    record as Map;
    String dayHours;
    if (record['day_hours'] is String) {
      dayHours = record['day_hours'] as String;
    } else {
      var dh = record['day_hours'] as List;
      dayHours = dh.join(',\n');
    }
    String category = record['category'].join(',\n');
    var distance = get(index, distances).toString();

    List row = [
      date.format(now),
      time.format(now),
      "UxLivingLab",
      email,
      searchWord,
      searchLocation,
      "0 meters",
      "$distanceRange meters",
      "${record['place_name']}".toString(),
      category.toString(),
      "${record['address']}".toString(),
      distance,
      dayHours.toString(),
      "${record['phone']}".toString(),
      "${record['website']}".toString(),
    ];
    fileContent.add(row);
  });

  final fileName = "NearbyPlaces.csv";

  // Encode the string as a List<int> of UTF-8 bytes
  var csvFile = ListToCsvConverter().convert(fileContent);

  final stream = Stream.fromIterable(csvFile.codeUnits);
  return download(stream, fileName);
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the button on the right!
// Automatic FlutterFlow imports
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future exitApp() async {
  // Exit application on button click
  await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
}
// Automatic FlutterFlow imports
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// launch url in webview
// Import necessary packages

// Define the function to launch URL in webview
Future launchURLInWebView(
    BuildContext context, Color backgroundColor, Color progressColor) async {
  String uri = "https://monosnap.com/file/rAJcNJVnKzy3Gcgk6mXPZWZzIMsgaH";
  // Create a new webview instance
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(backgroundColor)
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          Center(child: CircularProgressIndicator(color: progressColor));
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse(uri));

  // Show the webview in a dialog
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: WebViewWidget(controller: controller),
        ),
        actions: <Widget>[
          InkWell(
            child: Text('Close'),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
// Automatic FlutterFlow imports
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future openUrl(String url) async {
// Use the url_launcher package to launch the URL
  if (await canLaunchUrl(
      Uri.parse("https://buy.stripe.com/8wMcNf4MKcp55tm6oC"))) {
    return launchUrl(Uri.parse("https://buy.stripe.com/8wMcNf4MKcp55tm6oC"));
  } else {
    throw 'Could not launch https://buy.stripe.com/8wMcNf4MKcp55tm6oC';
  }
}
// Automatic FlutterFlow imports
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future refresh(BuildContext context) async {
  // refresh NearbyLocations Page with the route /nearbyLocation
  await Navigator.pushReplacementNamed(context, '/nearbyLocations');
}
// Automatic FlutterFlow imports
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future resetAPIResults(dynamic apiBody) async {
  // Add your function code here!
  setState() {
    return apiBody = null;
  }
}
// Automatic FlutterFlow imports
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class CustomWebViewPage extends StatefulWidget {
  const CustomWebViewPage({
    Key? key,
    this.width,
    this.height,
    required this.url,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String url;

  @override
  _CustomWebViewPageState createState() => _CustomWebViewPageState();
}

class _CustomWebViewPageState extends State<CustomWebViewPage> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    // late final PlatformWebViewControllerCreationParams params;
    // if (WebViewPlatform.instance is WebKitWebViewPlatform) {
    //   params = WebKitWebViewControllerCreationParams(
    //     allowsInlineMediaPlayback: true,
    //     mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
    //   );
    // } else {
    //   params = const PlatformWebViewControllerCreationParams();
    // }

    // final WebViewController controller =
    //     WebViewController.fromPlatformCreationParams(params);
    // // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (request) {
          if (request.url ==
              ('https://100088.pythonanywhere.com/api/success')) {
            debugPrint('blocking navigation to ${request.url}');
            Navigator.pop(context, true);
            return NavigationDecision.prevent;
          }
          debugPrint('allowing navigation to ${request.url}');
          return NavigationDecision.navigate;
        },
      ))
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
// Automatic FlutterFlow imports
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class LivingLabMap extends StatefulWidget {
  const LivingLabMap({
    Key? key,
    this.width,
    this.height,
    required this.target,
    required this.center,
    required this.radius,
  }) : super(key: key);

  final double? width;
  final double? height;
  final LatLng target;
  final LatLng center;
  final double radius;

  @override
  _LivingLabMapState createState() => _LivingLabMapState();
}

class _LivingLabMapState extends State<LivingLabMap> {
  final Completer<gm.GoogleMapController> _mapController =
      Completer<gm.GoogleMapController>();

  late List<gm.Marker> markers;

  @override
  void initState() {
    super.initState();
    markers = [
      // gm.Marker(
      //   markerId: gm.MarkerId('Center'), // A unique ID for the marker
      //   position: gm.LatLng(widget.center.latitude,
      //       widget.center.longitude), // The location coordinates
      //   icon: gm.BitmapDescriptor.defaultMarker, // Marker icon (optional)
      // ),
      gm.Marker(
        markerId: gm.MarkerId('Location'), // A unique ID for the marker
        position: gm.LatLng(widget.target.latitude,
            widget.target.longitude), // The location coordinates
        icon: gm.BitmapDescriptor.defaultMarkerWithHue(
            gm.BitmapDescriptor.hueBlue), // Marker icon (optional)
      ),
    ];
  }
  // Add more markers as needed...

  @override
  Widget build(BuildContext context) {
    return Container(
      child: gm.GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            _mapController.complete(controller);
          });
        },
        initialCameraPosition: gm.CameraPosition(
          target: gm.LatLng(widget.target.latitude,
              widget.target.longitude), // Set your initial map coordinates
          zoom: 12.0, // Adjust the zoom level as needed
        ),
        markers: Set<gm.Marker>.of(markers),
        circles: <gm.Circle>{
          gm.Circle(
            circleId:
                gm.CircleId("geofence_circle"), // A unique ID for the circle
            center: gm.LatLng(
                widget.center.latitude,
                widget.center
                    .longitude), // Center of the circle (same as map's center)
            radius: widget.radius, // Radius in meters (adjust as needed)
            fillColor: Colors.blue.withOpacity(0.3), // Fill color of the circle
            strokeColor: Colors.blue, // Stroke color of the circle
            strokeWidth: 2, // Stroke width
          ),
        },
      ),
    );
  }
}

String? getDistanceInMeters(double? havDistance) {
  return "${havDistance?.ceilToDouble()} meters";
}

String formatCoords(String coords) {
  List<String> coordsList = coords.split('');
  if (coordsList.length < 9) {
    return coordsList.sublist(0, 2).join();
  }
  var flist = coordsList.sublist(0, coordsList.length - 4);
  return flist.join();
}

String formatLng(String lng) {
  List<String> coordsList = lng.split('');
  if (coordsList.length < 9) {
    return coordsList.sublist(0, 2).join();
  }
  var flist = coordsList.sublist(0, coordsList.length - 4);
  return flist.join();
}

bool isListEmpty(List<dynamic> list) {
  return list.isEmpty;
}

String formatJsonToEmailBody(
  List<dynamic> data,
  String message,
  List<String>? distances,
  String email,
  String searchWord,
  String searchLocation,
  String distanceRange,
) {
  get(int index, List list) {
    try {
      return list[index];
    } on RangeError {
      return null;
    }
  }

  //Set Metadata

  DateTime now = new DateTime.now();
  DateFormat date = DateFormat.yMMMMd('en_US');
  DateFormat time = DateFormat('Hms');

  // format a list of json to string so that it can be send in email body
  // print(data);
  var html =
      '<html> <body> <header> <h4>$message</h4> </header><table style=\\"border-collapse: collapse;\\"> <colgroup><col width=\\"8%\\"><col width=\\"5%\\"><col width=\\"5%\\"><col width=\\"8%\\"><col width=\\"5%\\"><col width=\\"5%\\"><col width=\\"8%\\"><col width=\\"8%\\"><col width=\\"10%\\"><col width=\\"7%\\"><col width=\\"10%\\"><col width=\\"10%\\"><col width=\\"6%\\"><col width=\\"5%\\"></colgroup> <tr><th style=\\"border: 1px solid black; padding: 8px;\\">Date of Search</th><th style=\\"border: 1px solid black; padding: 8px;\\">Time of search</th><th style=\\"border: 1px solid black; padding: 8px;\\">User Name</th><th style=\\"border: 1px solid black; padding: 8px;\\">User Email</th><th style=\\"border: 1px solid black; padding: 8px;\\">Search Word</th><th style=\\"border: 1px solid black; padding: 8px;\\">Search Location</th><th style=\\"border: 1px solid black; padding: 8px;\\">From Distance</th><th style=\\"border: 1px solid black; padding: 8px;\\">To Distance</th><th style=\\"border: 1px solid black; padding: 8px;\\">Name</th> <th style=\\"border: 1px solid black; padding: 8px;\\">Distance from City Center</th><th style=\\"border: 1px solid black; padding: 8px;\\">Opening Days/Hours</th> <th style=\\"border: 1px solid black; padding: 8px;\\">Website</th> <th style=\\"border: 1px solid black; padding: 8px;\\">Phone Number</th> <th style=\\"border: 1px solid black; padding: 8px;\\">Rating</th></tr>';
  int index = 0;
  for (var value in data) {
    var mvalue = value as Map<dynamic, dynamic>;
    String name = mvalue['place_name'].toString();
    String dHours = "<ul>";
    if (mvalue['day_hours'] is String) {
      dHours = mvalue['day_hours'] as String;
    } else {
      List dHoursList = mvalue['day_hours'] as List;
      for (var dh in dHoursList) {
        dHours += "<li>$dh</li>";
      }
      dHours += "</ul>";
    }
    String distance =
        distances == null ? "None" : get(index, distances).toString();
    String website = mvalue['website'].toString();
    String phone = mvalue['phone'].toString();
    String rating = mvalue['rating'].toString();

    html +=
        '<tr><td style=\\"border: 1px solid black; padding: 8px; text-align: center;\\">${date.format(now)}</td><td style=\\"border: 1px solid black; padding: 8px; text-align: center;\\">${time.format(now)}</td><td style=\\"border: 1px solid black; padding: 8px; text-align: center;\\">UxLivingLab</td><td style=\\"border: 1px solid black; padding: 8px; text-align: center;\\">$email</td><td style=\\"border: 1px solid black; padding: 8px; text-align: center;\\">$searchWord</td><td style=\\"border: 1px solid black; padding: 8px; text-align: center;\\">$searchLocation</td><td style=\\"border: 1px solid black; padding: 8px; text-align: center;\\">0 meters</td><td style=\\"border: 1px solid black; padding: 8px; text-align: center;\\">$distanceRange meters</td><td style=\\"border: 1px solid black; padding: 8px; text-align: center;\\">$name</td><td style=\\"border: 1px solid black; padding: 8px;\\">$distance</td> <td style=\\"border: 1px solid black; padding: 8px;\\">$dHours</td> <td style=\\"border: 1px solid black; padding: 8px;\\">$website</td><td style=\\"border: 1px solid black; padding: 8px;\\">$phone</td><td style=\\"border: 1px solid black; padding: 8px;\\">$rating</td></tr>';
    index++;
  }
  html += "</table> </body></html>";
  return html;
}

String getNameFromEmail(String email) {
  // get the name from email address
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  // Split the email address by the "@" symbol
  List<String> parts = email.split("@");

  // If the email has the correct format
  if (parts.length == 2) {
    // Get the part before the "@" symbol
    String namePart = parts[0];

    // Split the name part by periods (.) and underscores (_)
    List<String> nameParts = namePart.split(RegExp("[._]"));

    if (nameParts.length >= 2) {
      // Capitalize the first letter of each name part
      List<String> capitalizedParts =
          nameParts.map((part) => capitalize(part)).toList();

      // Join the capitalized parts with spaces
      String fullName = capitalizedParts.join(" ");

      return fullName;
    }
  }

  // Return the original email if it doesn't match the expected format
  return email;
}

int toInt(String value) {
  // Convert a string to int and if double find ceil
  try {
    double doubleValue = double.parse(value);
    return doubleValue.ceil();
  } catch (e) {
    return 0;
  }
}

int listLength(List<dynamic> list) {
  return list.length;
}

String joinCoords(List<String> coordinates) {
  return coordinates.join('|');
}

List<String> sublist(
  int startIndex,
  int endIndex,
  List<String> list,
) {
  // get the sublist of a list
  return list.sublist(startIndex > list.length ? list.length : startIndex,
      endIndex > list.length ? list.length : endIndex);
}

List<String>? joinLists(
  List<String>? list1,
  List<String>? list2,
  List<String>? list3,
) {
  // join 3 lists to 1 with each adding to the end

  return [...?list1, ...?list2, ...?list3];
}

double distanceWithLocation(
  String centerCoordinate,
  double lat2,
  double lon2,
) {
  double _toRadians(double degrees) => degrees * math.pi / 180;
  double lat1 = 0;
  double lon1 = 0;

  num _haversin(double radians) => math.pow(math.sin(radians / 2), 2);

  const r = 6372.8; // Earth radius in kilometers

  final dLat = _toRadians(lat2 - lat1);
  final dLon = _toRadians(lon2 - lon1);
  final lat1Radians = _toRadians(lat1);
  final lat2Radians = _toRadians(lat2);

  final a = _haversin(dLat) +
      math.cos(lat1Radians) * math.cos(lat2Radians) * _haversin(dLon);
  final c = 2 * math.asin(math.sqrt(a));

  return r * c;
}

LatLng getLatLng(
  String lat,
  String lng,
) {
  // join lat and lng strings and return a LatLng

  return LatLng(double.parse(lat), double.parse(lng));
}

LatLng latLngFromLocation(String latLng) {
  var lCoord = latLng.split(",");
  String lat = lCoord.first;
  String lng = lCoord.last;
  return LatLng(double.parse(lat), double.parse(lng));
}

enum AnimationTrigger {
  onPageLoad,
  onActionTrigger,
}

class AnimationInfo {
  AnimationInfo({
    required this.trigger,
    required this.effects,
    this.loop = false,
    this.reverse = false,
    this.applyInitialState = true,
  });
  final AnimationTrigger trigger;
  final List<Effect<dynamic>> effects;
  final bool applyInitialState;
  final bool loop;
  final bool reverse;
  late AnimationController controller;
}

void createAnimation(AnimationInfo animation, TickerProvider vsync) {
  final newController = AnimationController(vsync: vsync);
  animation.controller = newController;
}

void setupAnimations(Iterable<AnimationInfo> animations, TickerProvider vsync) {
  animations.forEach((animation) => createAnimation(animation, vsync));
}

extension AnimatedWidgetExtension on Widget {
  Widget animateOnPageLoad(AnimationInfo animationInfo) => Animate(
      effects: animationInfo.effects,
      child: this,
      onPlay: (controller) => animationInfo.loop
          ? controller.repeat(reverse: animationInfo.reverse)
          : null,
      onComplete: (controller) => !animationInfo.loop && animationInfo.reverse
          ? controller.reverse()
          : null);

  Widget animateOnActionTrigger(
    AnimationInfo animationInfo, {
    bool hasBeenTriggered = false,
  }) =>
      hasBeenTriggered || animationInfo.applyInitialState
          ? Animate(
              controller: animationInfo.controller,
              autoPlay: false,
              effects: animationInfo.effects,
              child: this)
          : this;
}

class TiltEffect extends Effect<Offset> {
  const TiltEffect({
    Duration? delay,
    Duration? duration,
    Curve? curve,
    Offset? begin,
    Offset? end,
  }) : super(
          delay: delay,
          duration: duration,
          curve: curve,
          begin: begin ?? const Offset(0.0, 0.0),
          end: end ?? const Offset(0.0, 0.0),
        );

  @override
  Widget build(
    BuildContext context,
    Widget child,
    AnimationController controller,
    EffectEntry entry,
  ) {
    Animation<Offset> animation = buildAnimation(controller, entry);
    return getOptimizedBuilder<Offset>(
      animation: animation,
      builder: (_, __) => Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(animation.value.dx)
          ..rotateY(animation.value.dy),
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}

class FlutterFlowDropDown<T> extends StatefulWidget {
  const FlutterFlowDropDown({
    required this.controller,
    this.hintText,
    this.searchHintText,
    required this.options,
    this.optionLabels,
    this.onChanged,
    this.onChangedForMultiSelect,
    this.icon,
    this.width,
    this.height,
    this.fillColor,
    this.searchHintTextStyle,
    this.searchCursorColor,
    required this.textStyle,
    required this.elevation,
    required this.borderWidth,
    required this.borderRadius,
    required this.borderColor,
    required this.margin,
    this.hidesUnderline = false,
    this.disabled = false,
    this.isSearchable = false,
    this.isMultiSelect = false,
  });

  final FormFieldController<T> controller;
  final String? hintText;
  final String? searchHintText;
  final List<T> options;
  final List<String>? optionLabels;
  final Function(T?)? onChanged;
  final Function(List<T>?)? onChangedForMultiSelect;
  final Widget? icon;
  final double? width;
  final double? height;
  final Color? fillColor;
  final TextStyle? searchHintTextStyle;
  final Color? searchCursorColor;
  final TextStyle textStyle;
  final double elevation;
  final double borderWidth;
  final double borderRadius;
  final Color borderColor;
  final EdgeInsetsGeometry margin;
  final bool hidesUnderline;
  final bool disabled;
  final bool isSearchable;
  final bool isMultiSelect;

  @override
  State<FlutterFlowDropDown<T>> createState() => _FlutterFlowDropDownState<T>();
}

class _FlutterFlowDropDownState<T> extends State<FlutterFlowDropDown<T>> {
  final TextEditingController _textEditingController = TextEditingController();

  void Function() get listener => widget.isMultiSelect
      ? () {}
      : () => widget.onChanged!(widget.controller.value);

  @override
  void initState() {
    widget.controller.addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(listener);
    super.dispose();
  }

  List<T> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    final optionToDisplayValue = Map.fromEntries(
      widget.options.asMap().entries.map((option) => MapEntry(
          option.value,
          widget.optionLabels == null ||
                  widget.optionLabels!.length < option.key + 1
              ? option.value.toString()
              : widget.optionLabels![option.key])),
    );
    final value = widget.options.contains(widget.controller.value)
        ? widget.controller.value
        : null;
    final items = widget.options
        .map(
          (option) => DropdownMenuItem<T>(
            value: option,
            child: Text(
              optionToDisplayValue[option] ?? '',
              style: widget.textStyle,
            ),
          ),
        )
        .toList();
    final hintText = widget.hintText != null
        ? Text(widget.hintText!, style: widget.textStyle)
        : null;
    void Function(T?)? onChanged = widget.disabled || widget.isMultiSelect
        ? null
        : (value) => widget.controller.value = value;
    final dropdownWidget = widget.isMultiSelect
        ? _buildMultiSelectDropdown(
            hintText,
            optionToDisplayValue,
            widget.isSearchable,
            widget.onChangedForMultiSelect!,
            widget.disabled,
          )
        : widget.isSearchable
            ? _buildSearchableDropdown(
                value,
                items,
                onChanged,
                hintText,
                optionToDisplayValue,
              )
            : _buildNonSearchableDropdown(value, items, onChanged, hintText);
    final childWidget = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(
          color: widget.borderColor,
          width: widget.borderWidth,
        ),
        color: widget.fillColor,
      ),
      child: Padding(
        padding: widget.margin,
        child: widget.hidesUnderline
            ? DropdownButtonHideUnderline(child: dropdownWidget)
            : dropdownWidget,
      ),
    );
    if (widget.height != null || widget.width != null) {
      return Container(
        width: widget.width,
        height: widget.height,
        child: childWidget,
      );
    }
    return childWidget;
  }

  Widget _buildNonSearchableDropdown(
    T? value,
    List<DropdownMenuItem<T>>? items,
    void Function(T?)? onChanged,
    Text? hintText,
  ) {
    return DropdownButton<T>(
      value: value,
      hint: hintText,
      items: items,
      elevation: widget.elevation.toInt(),
      onChanged: onChanged,
      icon: widget.icon,
      isExpanded: true,
      dropdownColor: widget.fillColor,
      focusColor: Colors.transparent,
    );
  }

  Widget _buildSearchableDropdown(
    T? value,
    List<DropdownMenuItem<T>>? items,
    void Function(T?)? onChanged,
    Text? hintText,
    Map<T, String> optionLabels,
  ) {
    final overlayColor = MaterialStateProperty.resolveWith<Color?>((states) =>
        states.contains(MaterialState.focused) ? Colors.transparent : null);
    final iconStyleData = widget.icon != null
        ? IconStyleData(icon: widget.icon!)
        : const IconStyleData();
    return DropdownButton2<T>(
      value: value,
      hint: hintText,
      items: items,
      iconStyleData: iconStyleData,
      buttonStyleData: ButtonStyleData(
        elevation: widget.elevation.toInt(),
        overlayColor: overlayColor,
      ),
      menuItemStyleData: MenuItemStyleData(overlayColor: overlayColor),
      dropdownStyleData: DropdownStyleData(
        elevation: widget.elevation.toInt(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: widget.fillColor,
        ),
      ),
      onChanged: onChanged,
      isExpanded: true,
      dropdownSearchData: DropdownSearchData<T>(
        searchController: _textEditingController,
        searchInnerWidgetHeight: 50,
        searchInnerWidget: Container(
          height: 50,
          padding: const EdgeInsets.only(
            top: 8,
            bottom: 4,
            right: 8,
            left: 8,
          ),
          child: TextFormField(
            expands: true,
            maxLines: null,
            controller: _textEditingController,
            cursorColor: widget.searchCursorColor,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              hintText: widget.searchHintText,
              hintStyle: widget.searchHintTextStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        searchMatchFn: (item, searchValue) {
          return (optionLabels[item.value] ?? '')
              .toLowerCase()
              .contains(searchValue.toLowerCase());
        },
      ),

      // This to clear the search value when you close the menu
      onMenuStateChange: (isOpen) {
        if (!isOpen) {
          _textEditingController.clear();
        }
      },
    );
  }

  Widget _buildMultiSelectDropdown(
    Text? hintText,
    Map<T, String> optionLabels,
    bool isSearchable,
    Function(List<T>?) onChangedForMultiSelect,
    bool disabled,
  ) {
    final overlayColor = MaterialStateProperty.resolveWith<Color?>((states) =>
        states.contains(MaterialState.focused) ? Colors.transparent : null);
    final iconStyleData = widget.icon != null
        ? IconStyleData(icon: widget.icon!)
        : const IconStyleData();
    return DropdownButton2<T>(
      value: selectedItems.isEmpty ? null : selectedItems.last,
      hint: hintText,
      items: widget.options.map((item) {
        return DropdownMenuItem(
          value: item,
          // Disable default onTap to avoid closing menu when selecting an item
          enabled: false,
          child: StatefulBuilder(
            builder: (context, menuSetState) {
              final isSelected = selectedItems.contains(item);
              return InkWell(
                onTap: () {
                  isSelected
                      ? selectedItems.remove(item)
                      : selectedItems.add(item);
                  onChangedForMultiSelect(selectedItems);
                  //This rebuilds the StatefulWidget to update the button's text
                  setState(() {});
                  //This rebuilds the dropdownMenu Widget to update the check mark
                  menuSetState(() {});
                },
                child: Container(
                  height: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      if (isSelected)
                        const Icon(Icons.check_box_outlined)
                      else
                        const Icon(Icons.check_box_outline_blank),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          item as String,
                          style: widget.textStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }).toList(),
      iconStyleData: iconStyleData,
      buttonStyleData: ButtonStyleData(
        elevation: widget.elevation!.toInt(),
        overlayColor: overlayColor,
      ),
      menuItemStyleData: MenuItemStyleData(overlayColor: overlayColor),
      dropdownStyleData: DropdownStyleData(
        elevation: widget.elevation!.toInt(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: widget.fillColor,
        ),
      ),
      // onChanged is handled by the onChangedForMultiSelect function
      onChanged: disabled ? null : (val) {},
      isExpanded: true,
      selectedItemBuilder: (context) {
        return widget.options.map(
          (item) {
            return Container(
              alignment: AlignmentDirectional.center,
              child: Text(
                selectedItems.join(', '),
                style: const TextStyle(
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
            );
          },
        ).toList();
      },
      dropdownSearchData: isSearchable
          ? DropdownSearchData<T>(
              searchController: _textEditingController,
              searchInnerWidgetHeight: 50,
              searchInnerWidget: Container(
                height: 50,
                padding: const EdgeInsets.only(
                  top: 8,
                  bottom: 4,
                  right: 8,
                  left: 8,
                ),
                child: TextFormField(
                  expands: true,
                  maxLines: null,
                  controller: _textEditingController,
                  cursorColor: widget.searchCursorColor,
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    hintText: widget.searchHintText,
                    hintStyle: widget.searchHintTextStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              searchMatchFn: (item, searchValue) {
                return (optionLabels[item.value] ?? '')
                    .toLowerCase()
                    .contains(searchValue.toLowerCase());
              },
            )
          : null,
      // This to clear the search value when you close the menu
      onMenuStateChange: isSearchable
          ? (isOpen) {
              if (!isOpen) {
                _textEditingController.clear();
              }
            }
          : null,
    );
  }
}

enum GoogleMapStyle {
  standard,
  silver,
  retro,
  dark,
  night,
  aubergine,
}

enum GoogleMarkerColor {
  red,
  orange,
  yellow,
  green,
  cyan,
  azure,
  blue,
  violet,
  magenta,
  rose,
}

class FlutterFlowMarker {
  const FlutterFlowMarker(this.markerId, this.location, [this.onTap]);
  final String markerId;
  final LatLng location;
  final Future Function()? onTap;
}

class FlutterFlowGoogleMap extends StatefulWidget {
  const FlutterFlowGoogleMap({
    required this.controller,
    this.onCameraIdle,
    this.initialLocation,
    this.markers = const [],
    this.markerColor = GoogleMarkerColor.red,
    this.mapType = MapType.normal,
    this.style = GoogleMapStyle.standard,
    this.initialZoom = 12,
    this.allowInteraction = true,
    this.allowZoom = true,
    this.showZoomControls = true,
    this.showLocation = true,
    this.showCompass = false,
    this.showMapToolbar = false,
    this.showTraffic = false,
    this.centerMapOnMarkerTap = false,
    Key? key,
  }) : super(key: key);

  final Completer<GoogleMapController> controller;
  final Function(LatLng)? onCameraIdle;
  final LatLng? initialLocation;
  final Iterable<FlutterFlowMarker> markers;
  final GoogleMarkerColor markerColor;
  final MapType mapType;
  final GoogleMapStyle style;
  final double initialZoom;
  final bool allowInteraction;
  final bool allowZoom;
  final bool showZoomControls;
  final bool showLocation;
  final bool showCompass;
  final bool showMapToolbar;
  final bool showTraffic;
  final bool centerMapOnMarkerTap;

  @override
  State<StatefulWidget> createState() => _FlutterFlowGoogleMapState();
}

class _FlutterFlowGoogleMapState extends State<FlutterFlowGoogleMap> {
  double get initialZoom => max(double.minPositive, widget.initialZoom);
  LatLng get initialPosition =>
      widget.initialLocation?.toGoogleMaps() ?? const LatLng(0.0, 0.0);

  late Completer<GoogleMapController> _controller;
  late LatLng currentMapCenter;

  void onCameraIdle() => widget.onCameraIdle?.call(currentMapCenter.toLatLng());

  @override
  void initState() {
    super.initState();
    currentMapCenter = initialPosition;
    _controller = widget.controller;
  }

  @override
  Widget build(BuildContext context) => AbsorbPointer(
        absorbing: !widget.allowInteraction,
        child: GoogleMap(
          onMapCreated: (controller) async {
            _controller.complete(controller);
            await controller.setMapStyle(googleMapStyleStrings[widget.style]);
          },
          onCameraIdle: onCameraIdle,
          onCameraMove: (position) =>
              currentMapCenter = position.target as LatLng,
          initialCameraPosition: CameraPosition(
            target: initialPosition as gm.LatLng,
            zoom: initialZoom,
          ),
          mapType: widget.mapType,
          zoomGesturesEnabled: widget.allowZoom,
          zoomControlsEnabled: widget.showZoomControls,
          myLocationEnabled: widget.showLocation,
          compassEnabled: widget.showCompass,
          mapToolbarEnabled: widget.showMapToolbar,
          trafficEnabled: widget.showTraffic,
          markers: widget.markers
              .map(
                (m) => Marker(
                  markerId: MarkerId(m.markerId),
                  position:
                      gm.LatLng(m.location.latitude, m.location.longitude),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                      googleMarkerColorMap[widget.markerColor]!),
                  onTap: () async {
                    await m.onTap?.call();
                    if (widget.centerMapOnMarkerTap) {
                      final controller = await _controller.future;
                      await controller.animateCamera(
                        CameraUpdate.newLatLng(
                            m.location.toGoogleMaps() as gm.LatLng),
                      );
                      currentMapCenter = m.location.toGoogleMaps();
                      onCameraIdle();
                    }
                  },
                ),
              )
              .toSet(),
        ),
      );
}

extension ToGoogleMapsLatLng on LatLng {
  LatLng toGoogleMaps() => LatLng(latitude, longitude);
}

extension GoogleMapsToLatLng on LatLng {
  LatLng toLatLng() => LatLng(latitude, longitude);
}

Map<GoogleMapStyle, String> googleMapStyleStrings = {
  GoogleMapStyle.standard: '[]',
  GoogleMapStyle.silver:
      r'[{"elementType":"geometry","stylers":[{"color":"#f5f5f5"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#f5f5f5"}]},{"featureType":"administrative.land_parcel","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#ffffff"}]},{"featureType":"road.arterial","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#dadada"}]},{"featureType":"road.highway","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"transit.line","elementType":"geometry","stylers":[{"color":"#e5e5e5"}]},{"featureType":"transit.station","elementType":"geometry","stylers":[{"color":"#eeeeee"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#c9c9c9"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]}]',
  GoogleMapStyle.retro:
      r'[{"elementType":"geometry","stylers":[{"color":"#ebe3cd"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#523735"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#f5f1e6"}]},{"featureType":"administrative","elementType":"geometry.stroke","stylers":[{"color":"#c9b2a6"}]},{"featureType":"administrative.land_parcel","elementType":"geometry.stroke","stylers":[{"color":"#dcd2be"}]},{"featureType":"administrative.land_parcel","elementType":"labels.text.fill","stylers":[{"color":"#ae9e90"}]},{"featureType":"landscape.natural","elementType":"geometry","stylers":[{"color":"#dfd2ae"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#dfd2ae"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#93817c"}]},{"featureType":"poi.park","elementType":"geometry.fill","stylers":[{"color":"#a5b076"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#447530"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#f5f1e6"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#fdfcf8"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#f8c967"}]},{"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#e9bc62"}]},{"featureType":"road.highway.controlled_access","elementType":"geometry","stylers":[{"color":"#e98d58"}]},{"featureType":"road.highway.controlled_access","elementType":"geometry.stroke","stylers":[{"color":"#db8555"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#806b63"}]},{"featureType":"transit.line","elementType":"geometry","stylers":[{"color":"#dfd2ae"}]},{"featureType":"transit.line","elementType":"labels.text.fill","stylers":[{"color":"#8f7d77"}]},{"featureType":"transit.line","elementType":"labels.text.stroke","stylers":[{"color":"#ebe3cd"}]},{"featureType":"transit.station","elementType":"geometry","stylers":[{"color":"#dfd2ae"}]},{"featureType":"water","elementType":"geometry.fill","stylers":[{"color":"#b9d3c2"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#92998d"}]}]',
  GoogleMapStyle.dark:
      r'[{"elementType":"geometry","stylers":[{"color":"#212121"}]},{"elementType":"labels.icon","stylers":[{"visibility":"off"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#212121"}]},{"featureType":"administrative","elementType":"geometry","stylers":[{"color":"#757575"}]},{"featureType":"administrative.country","elementType":"labels.text.fill","stylers":[{"color":"#9e9e9e"}]},{"featureType":"administrative.land_parcel","stylers":[{"visibility":"off"}]},{"featureType":"administrative.locality","elementType":"labels.text.fill","stylers":[{"color":"#bdbdbd"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#181818"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"poi.park","elementType":"labels.text.stroke","stylers":[{"color":"#1b1b1b"}]},{"featureType":"road","elementType":"geometry.fill","stylers":[{"color":"#2c2c2c"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#8a8a8a"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#373737"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#3c3c3c"}]},{"featureType":"road.highway.controlled_access","elementType":"geometry","stylers":[{"color":"#4e4e4e"}]},{"featureType":"road.local","elementType":"labels.text.fill","stylers":[{"color":"#616161"}]},{"featureType":"transit","elementType":"labels.text.fill","stylers":[{"color":"#757575"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#000000"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#3d3d3d"}]}]',
  GoogleMapStyle.night:
      r'[{"elementType":"geometry","stylers":[{"color":"#242f3e"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#746855"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#242f3e"}]},{"featureType":"administrative.locality","elementType":"labels.text.fill","stylers":[{"color":"#d59563"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#d59563"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#263c3f"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#6b9a76"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#38414e"}]},{"featureType":"road","elementType":"geometry.stroke","stylers":[{"color":"#212a37"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#9ca5b3"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#746855"}]},{"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#1f2835"}]},{"featureType":"road.highway","elementType":"labels.text.fill","stylers":[{"color":"#f3d19c"}]},{"featureType":"transit","elementType":"geometry","stylers":[{"color":"#2f3948"}]},{"featureType":"transit.station","elementType":"labels.text.fill","stylers":[{"color":"#d59563"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#17263c"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#515c6d"}]},{"featureType":"water","elementType":"labels.text.stroke","stylers":[{"color":"#17263c"}]}]',
  GoogleMapStyle.aubergine:
      r'[{"elementType":"geometry","stylers":[{"color":"#1d2c4d"}]},{"elementType":"labels.text.fill","stylers":[{"color":"#8ec3b9"}]},{"elementType":"labels.text.stroke","stylers":[{"color":"#1a3646"}]},{"featureType":"administrative.country","elementType":"geometry.stroke","stylers":[{"color":"#4b6878"}]},{"featureType":"administrative.land_parcel","elementType":"labels.text.fill","stylers":[{"color":"#64779e"}]},{"featureType":"administrative.province","elementType":"geometry.stroke","stylers":[{"color":"#4b6878"}]},{"featureType":"landscape.man_made","elementType":"geometry.stroke","stylers":[{"color":"#334e87"}]},{"featureType":"landscape.natural","elementType":"geometry","stylers":[{"color":"#023e58"}]},{"featureType":"poi","elementType":"geometry","stylers":[{"color":"#283d6a"}]},{"featureType":"poi","elementType":"labels.text.fill","stylers":[{"color":"#6f9ba5"}]},{"featureType":"poi","elementType":"labels.text.stroke","stylers":[{"color":"#1d2c4d"}]},{"featureType":"poi.park","elementType":"geometry.fill","stylers":[{"color":"#023e58"}]},{"featureType":"poi.park","elementType":"labels.text.fill","stylers":[{"color":"#3C7680"}]},{"featureType":"road","elementType":"geometry","stylers":[{"color":"#304a7d"}]},{"featureType":"road","elementType":"labels.text.fill","stylers":[{"color":"#98a5be"}]},{"featureType":"road","elementType":"labels.text.stroke","stylers":[{"color":"#1d2c4d"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#2c6675"}]},{"featureType":"road.highway","elementType":"geometry.stroke","stylers":[{"color":"#255763"}]},{"featureType":"road.highway","elementType":"labels.text.fill","stylers":[{"color":"#b0d5ce"}]},{"featureType":"road.highway","elementType":"labels.text.stroke","stylers":[{"color":"#023e58"}]},{"featureType":"transit","elementType":"labels.text.fill","stylers":[{"color":"#98a5be"}]},{"featureType":"transit","elementType":"labels.text.stroke","stylers":[{"color":"#1d2c4d"}]},{"featureType":"transit.line","elementType":"geometry.fill","stylers":[{"color":"#283d6a"}]},{"featureType":"transit.station","elementType":"geometry","stylers":[{"color":"#3a4762"}]},{"featureType":"water","elementType":"geometry","stylers":[{"color":"#0e1626"}]},{"featureType":"water","elementType":"labels.text.fill","stylers":[{"color":"#4e6d70"}]}]',
};

Map<GoogleMarkerColor, double> googleMarkerColorMap = {
  GoogleMarkerColor.red: 0.0,
  GoogleMarkerColor.orange: 30.0,
  GoogleMarkerColor.yellow: 60.0,
  GoogleMarkerColor.green: 120.0,
  GoogleMarkerColor.cyan: 180.0,
  GoogleMarkerColor.azure: 210.0,
  GoogleMarkerColor.blue: 240.0,
  GoogleMarkerColor.violet: 270.0,
  GoogleMarkerColor.magenta: 300.0,
  GoogleMarkerColor.rose: 330.0,
};

class FlutterFlowIconButton extends StatefulWidget {
  const FlutterFlowIconButton({
    Key? key,
    required this.icon,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.buttonSize,
    this.fillColor,
    this.disabledColor,
    this.disabledIconColor,
    this.hoverColor,
    this.hoverIconColor,
    this.onPressed,
    this.showLoadingIndicator = false,
  }) : super(key: key);

  final Widget icon;
  final double? borderRadius;
  final double? buttonSize;
  final Color? fillColor;
  final Color? disabledColor;
  final Color? disabledIconColor;
  final Color? hoverColor;
  final Color? hoverIconColor;
  final Color? borderColor;
  final double? borderWidth;
  final bool showLoadingIndicator;
  final Function()? onPressed;

  @override
  State<FlutterFlowIconButton> createState() => _FlutterFlowIconButtonState();
}

class _FlutterFlowIconButtonState extends State<FlutterFlowIconButton> {
  bool loading = false;
  late double? iconSize;
  late Color? iconColor;
  late Widget effectiveIcon;

  @override
  void initState() {
    super.initState();
    _updateIcon();
  }

  @override
  void didUpdateWidget(FlutterFlowIconButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateIcon();
  }

  void _updateIcon() {
    final isFontAwesome = widget.icon is FaIcon;
    if (isFontAwesome) {
      FaIcon icon = widget.icon as FaIcon;
      effectiveIcon = FaIcon(
        icon.icon,
        size: icon.size,
      );
      iconSize = icon.size;
      iconColor = icon.color;
    } else {
      Icon icon = widget.icon as Icon;
      effectiveIcon = Icon(
        icon.icon,
        size: icon.size,
      );
      iconSize = icon.size;
      iconColor = icon.color;
    }
  }

  @override
  Widget build(BuildContext context) {
    ButtonStyle style = ButtonStyle(
      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
        (states) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
            side: BorderSide(
              color: widget.borderColor ?? Colors.transparent,
              width: widget.borderWidth ?? 0,
            ),
          );
        },
      ),
      iconColor: MaterialStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(MaterialState.disabled) &&
              widget.disabledIconColor != null) {
            return widget.disabledIconColor;
          }
          if (states.contains(MaterialState.hovered) &&
              widget.hoverIconColor != null) {
            return widget.hoverIconColor;
          }
          return iconColor;
        },
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(MaterialState.disabled) &&
              widget.disabledColor != null) {
            return widget.disabledColor;
          }
          if (states.contains(MaterialState.hovered) &&
              widget.hoverColor != null) {
            return widget.hoverColor;
          }

          return widget.fillColor;
        },
      ),
    );

    return SizedBox(
      width: widget.buttonSize,
      height: widget.buttonSize,
      child: Theme(
        data: Theme.of(context).copyWith(useMaterial3: true),
        child: IgnorePointer(
          ignoring: (widget.showLoadingIndicator && loading),
          child: IconButton(
            icon: (widget.showLoadingIndicator && loading)
                ? Container(
                    width: iconSize,
                    height: iconSize,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        iconColor ?? Colors.white,
                      ),
                    ),
                  )
                : effectiveIcon,
            onPressed: widget.onPressed == null
                ? null
                : () async {
                    if (loading) {
                      return;
                    }
                    setState(() => loading = true);
                    try {
                      await widget.onPressed!();
                    } finally {
                      if (mounted) {
                        setState(() => loading = false);
                      }
                    }
                  },
            splashRadius: widget.buttonSize,
            style: style,
          ),
        ),
      ),
    );
  }
}

Widget wrapWithModel<T extends FlutterFlowModel>({
  required T model,
  required Widget child,
  required VoidCallback updateCallback,
  bool updateOnChange = false,
}) {
  // Set the component to optionally update the page on updates.
  model.setOnUpdate(
    onUpdate: updateCallback,
    updateOnChange: updateOnChange,
  );
  // Models for components within a page will be disposed by the page's model,
  // so we don't want the component widget to dispose them until the page is
  // itself disposed.
  model.disposeOnWidgetDisposal = false;
  // Wrap in a Provider so that the model can be accessed by the component.
  return Provider<T>.value(
    value: model,
    child: child,
  );
}

T createModel<T extends FlutterFlowModel>(
  BuildContext context,
  T Function() defaultBuilder,
) {
  final model = context.read<T?>() ?? defaultBuilder();
  model._init(context);
  return model;
}

abstract class FlutterFlowModel {
  // Initialization methods
  bool _isInitialized = false;
  void initState(BuildContext context);
  void _init(BuildContext context) {
    if (!_isInitialized) {
      initState(context);
      _isInitialized = true;
    }
  }

  // Dispose methods
  // Whether to dispose this model when the corresponding widget is
  // disposed. By default this is true for pages and false for components,
  // as page/component models handle the disposal of their children.
  bool disposeOnWidgetDisposal = true;
  void dispose();
  void maybeDispose() {
    if (disposeOnWidgetDisposal) {
      dispose();
    }
  }

  // Whether to update the containing page / component on updates.
  bool updateOnChange = false;
  // Function to call when the model receives an update.
  VoidCallback _updateCallback = () {};
  void onUpdate() => updateOnChange ? _updateCallback() : () {};
  FlutterFlowModel setOnUpdate({
    bool updateOnChange = false,
    required VoidCallback onUpdate,
  }) =>
      this
        .._updateCallback = onUpdate
        ..updateOnChange = updateOnChange;
  // Update the containing page when this model received an update.
  void updatePage(VoidCallback callback) {
    callback();
    _updateCallback();
  }
}

class FlutterFlowDynamicModels<T extends FlutterFlowModel> {
  FlutterFlowDynamicModels(this.defaultBuilder);

  final T Function() defaultBuilder;
  final Map<String, T> _childrenModels = {};
  final Map<String, int> _childrenIndexes = {};
  Set<String>? _activeKeys;

  T getModel(String uniqueKey, int index) {
    _updateActiveKeys(uniqueKey);
    _childrenIndexes[uniqueKey] = index;
    return _childrenModels[uniqueKey] ??= defaultBuilder();
  }

  List<S> getValues<S>(S? Function(T) getValue) {
    return _childrenIndexes.entries
        // Sort keys by index.
        .sorted((a, b) => a.value.compareTo(b.value))
        .where((e) => _childrenModels[e.key] != null)
        // Map each model to the desired value and return as list. In order
        // to preserve index order, rather than removing null values we provide
        // default values (for types with reasonable defaults).
        .map((e) => getValue(_childrenModels[e.key]!) ?? _getDefaultValue<S>()!)
        .toList();
  }

  S? getValueAtIndex<S>(int index, S? Function(T) getValue) {
    final uniqueKey =
        _childrenIndexes.entries.firstWhereOrNull((e) => e.value == index)?.key;
    return getValueForKey(uniqueKey, getValue);
  }

  S? getValueForKey<S>(String? uniqueKey, S? Function(T) getValue) {
    final model = _childrenModels[uniqueKey];
    return model != null ? getValue(model) : null;
  }

  void dispose() => _childrenModels.values.forEach((model) => model.dispose());

  void _updateActiveKeys(String uniqueKey) {
    final shouldResetActiveKeys = _activeKeys == null;
    _activeKeys ??= {};
    _activeKeys!.add(uniqueKey);

    if (shouldResetActiveKeys) {
      // Add a post-frame callback to remove and dispose of unused models after
      // we're done building, then reset `_activeKeys` to null so we know to do
      // this again next build.
      SchedulerBinding.instance.addPostFrameCallback((_) {
        _childrenIndexes.removeWhere((k, _) => !_activeKeys!.contains(k));
        _childrenModels.keys
            .toSet()
            .difference(_activeKeys!)
            // Remove and dispose of unused models since they are  not being used
            // elsewhere and would not otherwise be disposed.
            .forEach((k) => _childrenModels.remove(k)?.dispose());
        _activeKeys = null;
      });
    }
  }
}

T? _getDefaultValue<T>() {
  switch (T) {
    case int:
      return 0 as T;
    case double:
      return 0.0 as T;
    case String:
      return '' as T;
    case bool:
      return false as T;
    default:
      return null as T;
  }
}

extension TextValidationExtensions on String? Function(BuildContext, String?)? {
  String? Function(String?)? asValidator(BuildContext context) =>
      this != null ? (val) => this!(context, val) : null;
}
// ignore_for_file: overridden_fields, annotate_overrides

abstract class FlutterFlowTheme {
  static FlutterFlowTheme of(BuildContext context) {
    return LightModeTheme();
  }

  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary;
  late Color secondary;
  late Color tertiary;
  late Color alternate;
  late Color primaryText;
  late Color secondaryText;
  late Color primaryBackground;
  late Color secondaryBackground;
  late Color accent1;
  late Color accent2;
  late Color accent3;
  late Color accent4;
  late Color success;
  late Color warning;
  late Color error;
  late Color info;

  late Color primaryBtnText;
  late Color lineColor;

  @Deprecated('Use displaySmallFamily instead')
  String get title1Family => displaySmallFamily;
  @Deprecated('Use displaySmall instead')
  TextStyle get title1 => typography.displaySmall;
  @Deprecated('Use headlineMediumFamily instead')
  String get title2Family => typography.headlineMediumFamily;
  @Deprecated('Use headlineMedium instead')
  TextStyle get title2 => typography.headlineMedium;
  @Deprecated('Use headlineSmallFamily instead')
  String get title3Family => typography.headlineSmallFamily;
  @Deprecated('Use headlineSmall instead')
  TextStyle get title3 => typography.headlineSmall;
  @Deprecated('Use titleMediumFamily instead')
  String get subtitle1Family => typography.titleMediumFamily;
  @Deprecated('Use titleMedium instead')
  TextStyle get subtitle1 => typography.titleMedium;
  @Deprecated('Use titleSmallFamily instead')
  String get subtitle2Family => typography.titleSmallFamily;
  @Deprecated('Use titleSmall instead')
  TextStyle get subtitle2 => typography.titleSmall;
  @Deprecated('Use bodyMediumFamily instead')
  String get bodyText1Family => typography.bodyMediumFamily;
  @Deprecated('Use bodyMedium instead')
  TextStyle get bodyText1 => typography.bodyMedium;
  @Deprecated('Use bodySmallFamily instead')
  String get bodyText2Family => typography.bodySmallFamily;
  @Deprecated('Use bodySmall instead')
  TextStyle get bodyText2 => typography.bodySmall;

  String get displayLargeFamily => typography.displayLargeFamily;
  TextStyle get displayLarge => typography.displayLarge;
  String get displayMediumFamily => typography.displayMediumFamily;
  TextStyle get displayMedium => typography.displayMedium;
  String get displaySmallFamily => typography.displaySmallFamily;
  TextStyle get displaySmall => typography.displaySmall;
  String get headlineLargeFamily => typography.headlineLargeFamily;
  TextStyle get headlineLarge => typography.headlineLarge;
  String get headlineMediumFamily => typography.headlineMediumFamily;
  TextStyle get headlineMedium => typography.headlineMedium;
  String get headlineSmallFamily => typography.headlineSmallFamily;
  TextStyle get headlineSmall => typography.headlineSmall;
  String get titleLargeFamily => typography.titleLargeFamily;
  TextStyle get titleLarge => typography.titleLarge;
  String get titleMediumFamily => typography.titleMediumFamily;
  TextStyle get titleMedium => typography.titleMedium;
  String get titleSmallFamily => typography.titleSmallFamily;
  TextStyle get titleSmall => typography.titleSmall;
  String get labelLargeFamily => typography.labelLargeFamily;
  TextStyle get labelLarge => typography.labelLarge;
  String get labelMediumFamily => typography.labelMediumFamily;
  TextStyle get labelMedium => typography.labelMedium;
  String get labelSmallFamily => typography.labelSmallFamily;
  TextStyle get labelSmall => typography.labelSmall;
  String get bodyLargeFamily => typography.bodyLargeFamily;
  TextStyle get bodyLarge => typography.bodyLarge;
  String get bodyMediumFamily => typography.bodyMediumFamily;
  TextStyle get bodyMedium => typography.bodyMedium;
  String get bodySmallFamily => typography.bodySmallFamily;
  TextStyle get bodySmall => typography.bodySmall;

  Typography get typography => ThemeTypography(this);
}

class LightModeTheme extends FlutterFlowTheme {
  @Deprecated('Use primary instead')
  Color get primaryColor => primary;
  @Deprecated('Use secondary instead')
  Color get secondaryColor => secondary;
  @Deprecated('Use tertiary instead')
  Color get tertiaryColor => tertiary;

  late Color primary = const Color(0xFF21633D);
  late Color secondary = const Color(0xFF3BB06C);
  late Color tertiary = const Color(0xFFEE8B60);
  late Color alternate = const Color(0xFFE0E3E7);
  late Color primaryText = const Color(0xFF101213);
  late Color secondaryText = const Color(0xFF8E8E8E);
  late Color primaryBackground = const Color(0xFFF1F4F8);
  late Color secondaryBackground = const Color(0xFFFFFFFF);
  late Color accent1 = const Color(0xFF616161);
  late Color accent2 = const Color(0xFF757575);
  late Color accent3 = const Color(0xFFE0E0E0);
  late Color accent4 = const Color(0xFFEEEEEE);
  late Color success = const Color(0xFF04A24C);
  late Color warning = const Color(0xFFFCDC0C);
  late Color error = const Color(0xFFE21C3D);
  late Color info = const Color(0xFF1C4494);

  late Color primaryBtnText = Color(0xFFFFFFFF);
  late Color lineColor = Color(0xFFE0E3E7);
}

abstract class Typography {
  String get displayLargeFamily;
  TextStyle get displayLarge;
  String get displayMediumFamily;
  TextStyle get displayMedium;
  String get displaySmallFamily;
  TextStyle get displaySmall;
  String get headlineLargeFamily;
  TextStyle get headlineLarge;
  String get headlineMediumFamily;
  TextStyle get headlineMedium;
  String get headlineSmallFamily;
  TextStyle get headlineSmall;
  String get titleLargeFamily;
  TextStyle get titleLarge;
  String get titleMediumFamily;
  TextStyle get titleMedium;
  String get titleSmallFamily;
  TextStyle get titleSmall;
  String get labelLargeFamily;
  TextStyle get labelLarge;
  String get labelMediumFamily;
  TextStyle get labelMedium;
  String get labelSmallFamily;
  TextStyle get labelSmall;
  String get bodyLargeFamily;
  TextStyle get bodyLarge;
  String get bodyMediumFamily;
  TextStyle get bodyMedium;
  String get bodySmallFamily;
  TextStyle get bodySmall;
}

class ThemeTypography extends Typography {
  ThemeTypography(this.theme);

  final FlutterFlowTheme theme;

  String get displayLargeFamily => 'Poppins';
  TextStyle get displayLarge => GoogleFonts.getFont(
        'Poppins',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 57.0,
      );
  String get displayMediumFamily => 'Poppins';
  TextStyle get displayMedium => GoogleFonts.getFont(
        'Poppins',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 45.0,
      );
  String get displaySmallFamily => 'Poppins';
  TextStyle get displaySmall => GoogleFonts.getFont(
        'Poppins',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 24.0,
      );
  String get headlineLargeFamily => 'Poppins';
  TextStyle get headlineLarge => GoogleFonts.getFont(
        'Poppins',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 32.0,
      );
  String get headlineMediumFamily => 'Poppins';
  TextStyle get headlineMedium => GoogleFonts.getFont(
        'Poppins',
        color: theme.secondaryText,
        fontWeight: FontWeight.w600,
        fontSize: 22.0,
      );
  String get headlineSmallFamily => 'Poppins';
  TextStyle get headlineSmall => GoogleFonts.getFont(
        'Poppins',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 20.0,
      );
  String get titleLargeFamily => 'Poppins';
  TextStyle get titleLarge => GoogleFonts.getFont(
        'Poppins',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 22.0,
      );
  String get titleMediumFamily => 'Poppins';
  TextStyle get titleMedium => GoogleFonts.getFont(
        'Poppins',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 18.0,
      );
  String get titleSmallFamily => 'Poppins';
  TextStyle get titleSmall => GoogleFonts.getFont(
        'Poppins',
        color: theme.secondaryText,
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
      );
  String get labelLargeFamily => 'Poppins';
  TextStyle get labelLarge => GoogleFonts.getFont(
        'Poppins',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 14.0,
      );
  String get labelMediumFamily => 'Poppins';
  TextStyle get labelMedium => GoogleFonts.getFont(
        'Poppins',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 12.0,
      );
  String get labelSmallFamily => 'Poppins';
  TextStyle get labelSmall => GoogleFonts.getFont(
        'Poppins',
        color: theme.primaryText,
        fontWeight: FontWeight.w500,
        fontSize: 11.0,
      );
  String get bodyLargeFamily => 'Poppins';
  TextStyle get bodyLarge => GoogleFonts.getFont(
        'Poppins',
        color: theme.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 16.0,
      );
  String get bodyMediumFamily => 'Poppins';
  TextStyle get bodyMedium => GoogleFonts.getFont(
        'Poppins',
        color: theme.primaryText,
        fontWeight: FontWeight.w600,
        fontSize: 14.0,
      );
  String get bodySmallFamily => 'Poppins';
  TextStyle get bodySmall => GoogleFonts.getFont(
        'Poppins',
        color: theme.secondaryText,
        fontWeight: FontWeight.w600,
        fontSize: 14.0,
      );
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String? fontFamily,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    double? letterSpacing,
    FontStyle? fontStyle,
    bool useGoogleFonts = true,
    TextDecoration? decoration,
    double? lineHeight,
  }) =>
      useGoogleFonts
          ? GoogleFonts.getFont(
              fontFamily!,
              color: color ?? this.color,
              fontSize: fontSize ?? this.fontSize,
              letterSpacing: letterSpacing ?? this.letterSpacing,
              fontWeight: fontWeight ?? this.fontWeight,
              fontStyle: fontStyle ?? this.fontStyle,
              decoration: decoration,
              height: lineHeight,
            )
          : copyWith(
              fontFamily: fontFamily,
              color: color,
              fontSize: fontSize,
              letterSpacing: letterSpacing,
              fontWeight: fontWeight,
              fontStyle: fontStyle,
              decoration: decoration,
              height: lineHeight,
            );
}

T valueOrDefault<T>(T? value, T defaultValue) =>
    (value is String && value.isEmpty) || value == null ? defaultValue : value;

void _setTimeagoLocales() {
  timeago.setLocaleMessages('en', timeago.EnMessages());
  timeago.setLocaleMessages('en_short', timeago.EnShortMessages());
}

String dateTimeFormat(String format, DateTime? dateTime, {String? locale}) {
  if (dateTime == null) {
    return '';
  }
  if (format == 'relative') {
    _setTimeagoLocales();
    return timeago.format(dateTime, locale: locale, allowFromNow: true);
  }
  return DateFormat(format, locale).format(dateTime);
}

Future launchURL(String url) async {
  var uri = Uri.parse(url).toString();
  try {
    await launch(uri);
  } catch (e) {
    throw 'Could not launch $uri: $e';
  }
}

Color colorFromCssString(String color, {Color? defaultColor}) {
  try {
    return fromCssColor(color);
  } catch (_) {}
  return defaultColor ?? Colors.black;
}

enum FormatType {
  decimal,
  percent,
  scientific,
  compact,
  compactLong,
  custom,
}

enum DecimalType {
  automatic,
  periodDecimal,
  commaDecimal,
}

String formatNumber(
  num? value, {
  required FormatType formatType,
  DecimalType? decimalType,
  String? currency,
  bool toLowerCase = false,
  String? format,
  String? locale,
}) {
  if (value == null) {
    return '';
  }
  var formattedValue = '';
  switch (formatType) {
    case FormatType.decimal:
      switch (decimalType!) {
        case DecimalType.automatic:
          formattedValue = NumberFormat.decimalPattern().format(value);
          break;
        case DecimalType.periodDecimal:
          formattedValue = NumberFormat.decimalPattern('en_US').format(value);
          break;
        case DecimalType.commaDecimal:
          formattedValue = NumberFormat.decimalPattern('es_PA').format(value);
          break;
      }
      break;
    case FormatType.percent:
      formattedValue = NumberFormat.percentPattern().format(value);
      break;
    case FormatType.scientific:
      formattedValue = NumberFormat.scientificPattern().format(value);
      if (toLowerCase) {
        formattedValue = formattedValue.toLowerCase();
      }
      break;
    case FormatType.compact:
      formattedValue = NumberFormat.compact().format(value);
      break;
    case FormatType.compactLong:
      formattedValue = NumberFormat.compactLong().format(value);
      break;
    case FormatType.custom:
      final hasLocale = locale != null && locale.isNotEmpty;
      formattedValue =
          NumberFormat(format, hasLocale ? locale : null).format(value);
  }

  if (formattedValue.isEmpty) {
    return value.toString();
  }

  if (currency != null) {
    final currencySymbol = currency.isNotEmpty
        ? currency
        : NumberFormat.simpleCurrency().format(0.0).substring(0, 1);
    formattedValue = '$currencySymbol$formattedValue';
  }

  return formattedValue;
}

DateTime get getCurrentTimestamp => DateTime.now();
DateTime dateTimeFromSecondsSinceEpoch(int seconds) {
  return DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
}

extension DateTimeConversionExtension on DateTime {
  int get secondsSinceEpoch => (millisecondsSinceEpoch / 1000).round();
}

extension DateTimeComparisonOperators on DateTime {
  bool operator <(DateTime other) => isBefore(other);
  bool operator >(DateTime other) => isAfter(other);
  bool operator <=(DateTime other) => this < other || isAtSameMomentAs(other);
  bool operator >=(DateTime other) => this > other || isAtSameMomentAs(other);
}

dynamic getJsonField(
  dynamic response,
  String jsonPath, [
  bool isForList = false,
]) {
  final field = JsonPath(jsonPath).read(response);
  if (field.isEmpty) {
    return null;
  }
  if (field.length > 1) {
    return field.map((f) => f.value).toList();
  }
  final value = field.first.value;
  return isForList && value is! Iterable ? [value] : value;
}

Rect? getWidgetBoundingBox(BuildContext context) {
  try {
    final renderBox = context.findRenderObject() as RenderBox?;
    return renderBox!.localToGlobal(Offset.zero) & renderBox.size;
  } catch (_) {
    return null;
  }
}

bool get isAndroid => !kIsWeb && Platform.isAndroid;
bool get isiOS => !kIsWeb && Platform.isIOS;
bool get isWeb => kIsWeb;

const kBreakpointSmall = 479.0;
const kBreakpointMedium = 767.0;
const kBreakpointLarge = 991.0;
bool isMobileWidth(BuildContext context) =>
    MediaQuery.sizeOf(context).width < kBreakpointSmall;
bool responsiveVisibility({
  required BuildContext context,
  bool phone = true,
  bool tablet = true,
  bool tabletLandscape = true,
  bool desktop = true,
}) {
  final width = MediaQuery.sizeOf(context).width;
  if (width < kBreakpointSmall) {
    return phone;
  } else if (width < kBreakpointMedium) {
    return tablet;
  } else if (width < kBreakpointLarge) {
    return tabletLandscape;
  } else {
    return desktop;
  }
}

const kTextValidatorUsernameRegex = r'^[a-zA-Z][a-zA-Z0-9_-]{2,16}$';
const kTextValidatorEmailRegex =
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
const kTextValidatorWebsiteRegex =
    r'(https?:\/\/)?(www\.)[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,10}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)|(https?:\/\/)?(www\.)?(?!ww)[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,10}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)';

extension FFTextEditingControllerExt on TextEditingController? {
  String get text => this == null ? '' : this!.text;
  set text(String newText) => this?.text = newText;
}

extension IterableExt<T> on Iterable<T> {
  List<S> mapIndexed<S>(S Function(int, T) func) => toList()
      .asMap()
      .map((index, value) => MapEntry(index, func(index, value)))
      .values
      .toList();
}

void setAppLanguage(BuildContext context, String language) =>
    MyApp.of(context).setLocale(language);

void setDarkModeSetting(BuildContext context, ThemeMode themeMode) =>
    MyApp.of(context).setThemeMode(themeMode);

void showSnackbar(
  BuildContext context,
  String message, {
  bool loading = false,
  int duration = 4,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          if (loading)
            Padding(
              padding: EdgeInsetsDirectional.only(end: 10.0),
              child: Container(
                height: 20,
                width: 20,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          Text(message),
        ],
      ),
      duration: Duration(seconds: duration),
    ),
  );
}

extension FFStringExt on String {
  String maybeHandleOverflow({int? maxChars, String replacement = ''}) =>
      maxChars != null && length > maxChars
          ? replaceRange(maxChars, null, replacement)
          : this;
}

extension ListFilterExt<T> on Iterable<T?> {
  List<T> get withoutNulls => where((s) => s != null).map((e) => e!).toList();
}

extension ListDivideExt<T extends Widget> on Iterable<T> {
  Iterable<MapEntry<int, Widget>> get enumerate => toList().asMap().entries;

  List<Widget> divide(Widget t) => isEmpty
      ? []
      : (enumerate.map((e) => [e.value, t]).expand((i) => i).toList()
        ..removeLast());

  List<Widget> around(Widget t) => addToStart(t).addToEnd(t);

  List<Widget> addToStart(Widget t) =>
      enumerate.map((e) => e.value).toList()..insert(0, t);

  List<Widget> addToEnd(Widget t) =>
      enumerate.map((e) => e.value).toList()..add(t);

  List<Padding> paddingTopEach(double val) =>
      map((w) => Padding(padding: EdgeInsets.only(top: val), child: w))
          .toList();
}

extension StatefulWidgetExtensions on State<StatefulWidget> {
  /// Check if the widget exist before safely setting state.
  void safeSetState(VoidCallback fn) {
    if (mounted) {
      // ignore: invalid_use_of_protected_member
      setState(fn);
    }
  }
}

class FFButtonOptions {
  const FFButtonOptions({
    this.textStyle,
    this.elevation,
    this.height,
    this.width,
    this.padding,
    this.color,
    this.disabledColor,
    this.disabledTextColor,
    this.splashColor,
    this.iconSize,
    this.iconColor,
    this.iconPadding,
    this.borderRadius,
    this.borderSide,
    this.hoverColor,
    this.hoverBorderSide,
    this.hoverTextColor,
    this.hoverElevation,
    this.maxLines,
  });

  final TextStyle? textStyle;
  final double? elevation;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? disabledColor;
  final Color? disabledTextColor;
  final int? maxLines;
  final Color? splashColor;
  final double? iconSize;
  final Color? iconColor;
  final EdgeInsetsGeometry? iconPadding;
  final BorderRadius? borderRadius;
  final BorderSide? borderSide;
  final Color? hoverColor;
  final BorderSide? hoverBorderSide;
  final Color? hoverTextColor;
  final double? hoverElevation;
}

class FFButtonWidget extends StatefulWidget {
  const FFButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.iconData,
    required this.options,
    this.showLoadingIndicator = true,
  }) : super(key: key);

  final String text;
  final Widget? icon;
  final IconData? iconData;
  final Function()? onPressed;
  final FFButtonOptions options;
  final bool showLoadingIndicator;

  @override
  State<FFButtonWidget> createState() => _FFButtonWidgetState();
}

class _FFButtonWidgetState extends State<FFButtonWidget> {
  bool loading = false;

  int get maxLines => widget.options.maxLines ?? 1;

  @override
  Widget build(BuildContext context) {
    Widget textWidget = loading
        ? Center(
            child: Container(
              width: 23,
              height: 23,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  widget.options.textStyle!.color ?? Colors.white,
                ),
              ),
            ),
          )
        : AutoSizeText(
            widget.text,
            style: widget.options.textStyle?.withoutColor(),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
          );

    final onPressed = widget.onPressed != null
        ? (widget.showLoadingIndicator
            ? () async {
                if (loading) {
                  return;
                }
                setState(() => loading = true);
                try {
                  await widget.onPressed!();
                } finally {
                  if (mounted) {
                    setState(() => loading = false);
                  }
                }
              }
            : () => widget.onPressed!())
        : null;

    ButtonStyle style = ButtonStyle(
      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
        (states) {
          if (states.contains(MaterialState.hovered) &&
              widget.options.hoverBorderSide != null) {
            return RoundedRectangleBorder(
              borderRadius:
                  widget.options.borderRadius ?? BorderRadius.circular(8),
              side: widget.options.hoverBorderSide!,
            );
          }
          return RoundedRectangleBorder(
            borderRadius:
                widget.options.borderRadius ?? BorderRadius.circular(8),
            side: widget.options.borderSide ?? BorderSide.none,
          );
        },
      ),
      foregroundColor: MaterialStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(MaterialState.disabled) &&
              widget.options.disabledTextColor != null) {
            return widget.options.disabledTextColor;
          }
          if (states.contains(MaterialState.hovered) &&
              widget.options.hoverTextColor != null) {
            return widget.options.hoverTextColor;
          }
          return widget.options.textStyle?.color;
        },
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
        (states) {
          if (states.contains(MaterialState.disabled) &&
              widget.options.disabledColor != null) {
            return widget.options.disabledColor;
          }
          if (states.contains(MaterialState.hovered) &&
              widget.options.hoverColor != null) {
            return widget.options.hoverColor;
          }
          return widget.options.color;
        },
      ),
      overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
        if (states.contains(MaterialState.pressed)) {
          return widget.options.splashColor;
        }
        return null;
      }),
      padding: MaterialStateProperty.all(widget.options.padding ??
          const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0)),
      elevation: MaterialStateProperty.resolveWith<double?>(
        (states) {
          if (states.contains(MaterialState.hovered) &&
              widget.options.hoverElevation != null) {
            return widget.options.hoverElevation!;
          }
          return widget.options.elevation;
        },
      ),
    );

    if ((widget.icon != null || widget.iconData != null) && !loading) {
      return Container(
        height: widget.options.height,
        width: widget.options.width,
        child: ElevatedButton.icon(
          icon: Padding(
            padding: widget.options.iconPadding ?? EdgeInsets.zero,
            child: widget.icon ??
                FaIcon(
                  widget.iconData,
                  size: widget.options.iconSize,
                  color: widget.options.iconColor ??
                      widget.options.textStyle!.color,
                ),
          ),
          label: textWidget,
          onPressed: onPressed,
          style: style,
        ),
      );
    }

    return Container(
      height: widget.options.height,
      width: widget.options.width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: style,
        child: textWidget,
      ),
    );
  }
}

extension _WithoutColorExtension on TextStyle {
  TextStyle withoutColor() => TextStyle(
        inherit: inherit,
        color: null,
        backgroundColor: backgroundColor,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        textBaseline: textBaseline,
        height: height,
        leadingDistribution: leadingDistribution,
        locale: locale,
        foreground: foreground,
        background: background,
        shadows: shadows,
        fontFeatures: fontFeatures,
        decoration: decoration,
        decorationColor: decorationColor,
        decorationStyle: decorationStyle,
        decorationThickness: decorationThickness,
        debugLabel: debugLabel,
        fontFamily: fontFamily,
        fontFamilyFallback: fontFamilyFallback,
        // The _package field is private so unfortunately we can't set it here,
        // but it's almost always unset anyway.
        // package: _package,
        overflow: overflow,
      );
}

class FormFieldController<T> extends ValueNotifier<T?> {
  FormFieldController(this.initialValue) : super(initialValue);

  final T? initialValue;

  void reset() => value = initialValue;
}

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
  }) =>
      [enText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap =
    <Map<String, Map<String, String>>>[].reduce((a, b) => a..addAll(b));

class LatLng {
  const LatLng(this.latitude, this.longitude);
  final double latitude;
  final double longitude;

  @override
  String toString() => 'LatLng(lat: $latitude, lng: $longitude)';

  String serialize() => '$latitude,$longitude';

  @override
  int get hashCode => latitude.hashCode + longitude.hashCode;

  @override
  bool operator ==(other) =>
      other is LatLng &&
      latitude == other.latitude &&
      longitude == other.longitude;
}

const kTransitionInfoKey = '__transition_info__';

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  bool showSplashImage = true;

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, state) => appStateNotifier.showSplashImage
          ? Builder(
              builder: (context) => Container(
                color: FlutterFlowTheme.of(context).secondary,
                child: Image.asset(
                  'assets/images/9267_[Converted]-01_1.png',
                  fit: BoxFit.cover,
                ),
              ),
            )
          : SplashscreenWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => appStateNotifier.showSplashImage
              ? Builder(
                  builder: (context) => Container(
                    color: FlutterFlowTheme.of(context).secondary,
                    child: Image.asset(
                      'assets/images/9267_[Converted]-01_1.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : SplashscreenWidget(),
          routes: [
            FFRoute(
              name: 'Splashscreen',
              path: 'splashscreen',
              builder: (context, params) => SplashscreenWidget(),
            ),
            FFRoute(
              name: 'NearbyLocations',
              path: 'nearbyLocations',
              builder: (context, params) => NearbyLocationsWidget(),
            ),
            FFRoute(
              name: 'LivingLabWebView',
              path: 'livingLabWebView',
              builder: (context, params) => LivingLabWebViewWidget(
                url: params.getParam('url', ParamType.String),
              ),
            )
          ].map((r) => r.toRoute(appStateNotifier)).toList(),
        ),
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.extraMap.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, [
    bool isList = false,
  ]) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        pageBuilder: (context, state) {
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder: PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).transitionsBuilder,
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

/// SERIALIZATION HELPERS

String dateTimeRangeToString(DateTimeRange dateTimeRange) {
  final startStr = dateTimeRange.start.millisecondsSinceEpoch.toString();
  final endStr = dateTimeRange.end.millisecondsSinceEpoch.toString();
  return '$startStr|$endStr';
}

String placeToString(FFPlace place) => jsonEncode({
      'latLng': place.latLng.serialize(),
      'name': place.name,
      'address': place.address,
      'city': place.city,
      'state': place.state,
      'country': place.country,
      'zipCode': place.zipCode,
    });

String uploadedFileToString(FFUploadedFile uploadedFile) =>
    uploadedFile.serialize();

String? serializeParam(
  dynamic param,
  ParamType paramType, [
  bool isList = false,
]) {
  try {
    if (param == null) {
      return null;
    }
    if (isList) {
      final serializedValues = (param as Iterable)
          .map((p) => serializeParam(p, paramType, false))
          .where((p) => p != null)
          .map((p) => p!)
          .toList();
      return json.encode(serializedValues);
    }
    switch (paramType) {
      case ParamType.int:
        return param.toString();
      case ParamType.double:
        return param.toString();
      case ParamType.String:
        return param;
      case ParamType.bool:
        return param ? 'true' : 'false';
      case ParamType.DateTime:
        return (param as DateTime).millisecondsSinceEpoch.toString();
      case ParamType.DateTimeRange:
        return dateTimeRangeToString(param as DateTimeRange);
      case ParamType.LatLng:
        return (param as LatLng).serialize();
      case ParamType.Color:
        return (param as Color).toCssString();
      case ParamType.FFPlace:
        return placeToString(param as FFPlace);
      case ParamType.FFUploadedFile:
        return uploadedFileToString(param as FFUploadedFile);
      case ParamType.JSON:
        return json.encode(param);

      default:
        return null;
    }
  } catch (e) {
    print('Error serializing parameter: $e');
    return null;
  }
}

/// END SERIALIZATION HELPERS

/// DESERIALIZATION HELPERS

DateTimeRange? dateTimeRangeFromString(String dateTimeRangeStr) {
  final pieces = dateTimeRangeStr.split('|');
  if (pieces.length != 2) {
    return null;
  }
  return DateTimeRange(
    start: DateTime.fromMillisecondsSinceEpoch(int.parse(pieces.first)),
    end: DateTime.fromMillisecondsSinceEpoch(int.parse(pieces.last)),
  );
}

LatLng? latLngFromString(String latLngStr) {
  final pieces = latLngStr.split(',');
  if (pieces.length != 2) {
    return null;
  }
  return LatLng(
    double.parse(pieces.first.trim()),
    double.parse(pieces.last.trim()),
  );
}

FFPlace placeFromString(String placeStr) {
  final serializedData = jsonDecode(placeStr) as Map<String, dynamic>;
  final data = {
    'latLng': serializedData.containsKey('latLng')
        ? latLngFromString(serializedData['latLng'] as String)
        : const LatLng(0.0, 0.0),
    'name': serializedData['name'] ?? '',
    'address': serializedData['address'] ?? '',
    'city': serializedData['city'] ?? '',
    'state': serializedData['state'] ?? '',
    'country': serializedData['country'] ?? '',
    'zipCode': serializedData['zipCode'] ?? '',
  };
  return FFPlace(
    latLng: data['latLng'] as LatLng,
    name: data['name'] as String,
    address: data['address'] as String,
    city: data['city'] as String,
    state: data['state'] as String,
    country: data['country'] as String,
    zipCode: data['zipCode'] as String,
  );
}

FFUploadedFile uploadedFileFromString(String uploadedFileStr) =>
    FFUploadedFile.deserialize(uploadedFileStr);

enum ParamType {
  int,
  double,
  String,
  bool,
  DateTime,
  DateTimeRange,
  LatLng,
  Color,
  FFPlace,
  FFUploadedFile,
  JSON,
}

dynamic deserializeParam<T>(
  String? param,
  ParamType paramType,
  bool isList,
) {
  try {
    if (param == null) {
      return null;
    }
    if (isList) {
      final paramValues = json.decode(param);
      if (paramValues is! Iterable || paramValues.isEmpty) {
        return null;
      }
      return paramValues
          .where((p) => p is String)
          .map((p) => p as String)
          .map((p) => deserializeParam<T>(p, paramType, false))
          .where((p) => p != null)
          .map((p) => p! as T)
          .toList();
    }
    switch (paramType) {
      case ParamType.int:
        return int.tryParse(param);
      case ParamType.double:
        return double.tryParse(param);
      case ParamType.String:
        return param;
      case ParamType.bool:
        return param == 'true';
      case ParamType.DateTime:
        final milliseconds = int.tryParse(param);
        return milliseconds != null
            ? DateTime.fromMillisecondsSinceEpoch(milliseconds)
            : null;
      case ParamType.DateTimeRange:
        return dateTimeRangeFromString(param);
      case ParamType.LatLng:
        return latLngFromString(param);
      case ParamType.Color:
        return fromCssColor(param);
      case ParamType.FFPlace:
        return placeFromString(param);
      case ParamType.FFUploadedFile:
        return uploadedFileFromString(param);
      case ParamType.JSON:
        return json.decode(param);

      default:
        return null;
    }
  } catch (e) {
    print('Error deserializing parameter: $e');
    return null;
  }
}

class FFPlace {
  const FFPlace({
    this.latLng = const LatLng(0.0, 0.0),
    this.name = '',
    this.address = '',
    this.city = '',
    this.state = '',
    this.country = '',
    this.zipCode = '',
  });

  final LatLng latLng;
  final String name;
  final String address;
  final String city;
  final String state;
  final String country;
  final String zipCode;

  @override
  String toString() => '''FFPlace(
        latLng: $latLng,
        name: $name,
        address: $address,
        city: $city,
        state: $state,
        country: $country,
        zipCode: $zipCode,
      )''';

  @override
  int get hashCode => latLng.hashCode;

  @override
  bool operator ==(other) =>
      other is FFPlace &&
      latLng == other.latLng &&
      name == other.name &&
      address == other.address &&
      city == other.city &&
      state == other.state &&
      country == other.country &&
      zipCode == other.zipCode;
}

class FFUploadedFile {
  const FFUploadedFile({
    this.name,
    this.bytes,
    this.height,
    this.width,
    this.blurHash,
  });

  final String? name;
  final Uint8List? bytes;
  final double? height;
  final double? width;
  final String? blurHash;

  @override
  String toString() =>
      'FFUploadedFile(name: $name, bytes: ${bytes?.length ?? 0}, height: $height, width: $width, blurHash: $blurHash,)';

  String serialize() => jsonEncode(
        {
          'name': name,
          'bytes': bytes,
          'height': height,
          'width': width,
          'blurHash': blurHash,
        },
      );

  static FFUploadedFile deserialize(String val) {
    final serializedData = jsonDecode(val) as Map<String, dynamic>;
    final data = {
      'name': serializedData['name'] ?? '',
      'bytes': serializedData['bytes'] ?? Uint8List.fromList([]),
      'height': serializedData['height'],
      'width': serializedData['width'],
      'blurHash': serializedData['blurHash'],
    };
    return FFUploadedFile(
      name: data['name'] as String,
      bytes: Uint8List.fromList(data['bytes'].cast<int>().toList()),
      height: data['height'] as double?,
      width: data['width'] as double?,
      blurHash: data['blurHash'] as String?,
    );
  }

  @override
  int get hashCode => Object.hash(
        name,
        bytes,
        height,
        width,
        blurHash,
      );

  @override
  bool operator ==(other) =>
      other is FFUploadedFile &&
      name == other.name &&
      bytes == other.bytes &&
      height == other.height &&
      width == other.width &&
      blurHash == other.blurHash;
}

// Export pages
// show NearbyLocationsWidget;
// show LivingLabWebViewWidget;

class LivingLabWebViewModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}

class LivingLabWebViewWidget extends StatefulWidget {
  const LivingLabWebViewWidget({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String? url;

  @override
  _LivingLabWebViewWidgetState createState() => _LivingLabWebViewWidgetState();
}

class _LivingLabWebViewWidgetState extends State<LivingLabWebViewWidget> {
  late LivingLabWebViewModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LivingLabWebViewModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: MediaQuery.sizeOf(context).height * 1.0,
                child: CustomWebViewPage(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: MediaQuery.sizeOf(context).height * 1.0,
                  url: widget.url!,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await initFirebase();

  final appState = FFAppState(); // Initialize FFAppState
  await appState.initializePersistedState();

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = ThemeMode.system;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  bool displaySplashImage = true;

  @override
  void initState() {
    super.initState();

    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);

    Future.delayed(Duration(milliseconds: 1000),
        () => setState(() => _appStateNotifier.stopShowingSplashImage()));
  }

  void setLocale(String language) {
    setState(() => _locale = createLocale(language));
  }

  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Search LivingLab Map',
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
      ],
      theme: ThemeData(
        brightness: Brightness.light,
        scrollbarTheme: ScrollbarThemeData(),
      ),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}

class NearbyLocationsModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  final formKey2 = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - API (CheckCredSys)] action in NearbyLocations widget.
  ApiCallResponse? creditsResults;
  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter1;
  final googleMapsController1 = Completer<GoogleMapController>();
  // State field(s) for sQueryDropdown widget.
  String? sQueryDropdownValue;
  FormFieldController<String>? sQueryDropdownValueController;
  // State field(s) for sLocationDropdown widget.
  String? sLocationDropdownValue;
  FormFieldController<String>? sLocationDropdownValueController;
  // State field(s) for sSliderRadius widget.
  double? sSliderRadiusValue;
  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter2;
  final googleMapsController2 = Completer<GoogleMapController>();
  // State field(s) for QueryDropdown widget.
  String? queryDropdownValue;
  FormFieldController<String>? queryDropdownValueController;
  // State field(s) for LocationDropdown widget.
  String? locationDropdownValue;
  FormFieldController<String>? locationDropdownValueController;
  // State field(s) for SliderRadius2 widget.
  double? sliderRadius2Value;
  // Stores action output result for [Backend Call - API (CalculateDistance)] action in IconButton widget.
  ApiCallResponse? lFirst25;
  // Stores action output result for [Backend Call - API (CalculateDistance)] action in IconButton widget.
  ApiCallResponse? lNext25;
  // Stores action output result for [Backend Call - API (CalculateDistance)] action in IconButton widget.
  ApiCallResponse? lLast25;
  // Stores action output result for [Backend Call - API (GetCoordinates)] action in IconButton widget.
  ApiCallResponse? coordinateResult;
  // Stores action output result for [Backend Call - API (GetNearbyLocationsId)] action in IconButton widget.
  ApiCallResponse? locationsIdResult;
  // Stores action output result for [Backend Call - API (GetNearbyLocations)] action in IconButton widget.
  ApiCallResponse? locationsResult;
  // Stores action output result for [Backend Call - API (CalculateDistance)] action in IconButton widget.
  ApiCallResponse? first25;
  // Stores action output result for [Backend Call - API (CalculateDistance)] action in IconButton widget.
  ApiCallResponse? next25;
  // Stores action output result for [Backend Call - API (CalculateDistance)] action in IconButton widget.
  ApiCallResponse? last5;
  // Stores action output result for [Backend Call - API (GetCoordinates)] action in IconButton widget.
  ApiCallResponse? locationCoordinateResult;
  // Stores action output result for [Backend Call - API (GetNearbyLocationsId)] action in IconButton widget.
  ApiCallResponse? placeIdsResult;
  // Stores action output result for [Backend Call - API (GetNearbyLocations)] action in IconButton widget.
  ApiCallResponse? nearbyLocationResult;
  // Stores action output result for [Backend Call - API (CalculateDistance)] action in Row widget.
  ApiCallResponse? lEmailFirst25;
  // Stores action output result for [Backend Call - API (CalculateDistance)] action in Row widget.
  ApiCallResponse? lEmailNext25;
  // Stores action output result for [Backend Call - API (CalculateDistance)] action in Row widget.
  ApiCallResponse? lEmailLast25;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}

class NearbyLocationsWidget extends StatefulWidget {
  const NearbyLocationsWidget({Key? key}) : super(key: key);

  @override
  _NearbyLocationsWidgetState createState() => _NearbyLocationsWidgetState();
}

class _NearbyLocationsWidgetState extends State<NearbyLocationsWidget> {
  late NearbyLocationsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NearbyLocationsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        FFAppState().refreshed = true;
      });
      _model.creditsResults = await CheckCredSysCall.call();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFF3BB06C),
        drawer: Container(
          width: 303.0,
          child: Drawer(
            elevation: 16.0,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: MediaQuery.sizeOf(context).height * 0.15,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional(0.00, -1.00),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FlutterFlowIconButton(
                            borderColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: 20.0,
                            buttonSize: 40.0,
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            icon: Icon(
                              Icons.close,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 24.0,
                            ),
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Builder(
                  builder: (context) => Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        if (((getJsonField(
                                      (_model.locationsResult?.jsonBody ?? ''),
                                      r'''$.succesful_results''',
                                    ) !=
                                    null) ||
                                (getJsonField(
                                      (_model.nearbyLocationResult?.jsonBody ??
                                          ''),
                                      r'''$.succesful_results''',
                                    ) !=
                                    null)) &&
                            (FFAppState().refreshed != true)) {
                          _model.lEmailFirst25 =
                              await CalculateDistanceCall.call(
                            origins: getJsonField(
                                      (_model.locationsIdResult?.jsonBody ??
                                          ''),
                                      r'''$.place_id_list''',
                                    ) !=
                                    null
                                ? GetNearbyLocationsIdCall.centerCoordinate(
                                    (_model.locationsIdResult?.jsonBody ?? ''),
                                  ).toString()
                                : GetNearbyLocationsIdCall.centerCoordinate(
                                    (_model.placeIdsResult?.jsonBody ?? ''),
                                  ).toString(),
                            destinations: joinCoords(getJsonField(
                                      (_model.locationsResult?.jsonBody ?? ''),
                                      r'''$.succesful_results''',
                                    ) !=
                                    null
                                ? (GetNearbyLocationsCall.locationList(
                                    (_model.locationsResult?.jsonBody ?? ''),
                                  ) as List)
                                    .map<String>((s) => s.toString())
                                    .toList()!
                                    .take(25)
                                    .toList()
                                    .map((e) => e.toString())
                                    .toList()
                                : (GetNearbyLocationsCall.coordinates(
                                    (_model.nearbyLocationResult?.jsonBody ??
                                        ''),
                                  ) as List)
                                    .map<String>((s) => s.toString())
                                    .toList()!
                                    .take(25)
                                    .toList()),
                          );
                          _model.lEmailNext25 =
                              await CalculateDistanceCall.call(
                            origins: getJsonField(
                                      (_model.locationsIdResult?.jsonBody ??
                                          ''),
                                      r'''$.place_id_list''',
                                    ) !=
                                    null
                                ? GetNearbyLocationsIdCall.centerCoordinate(
                                    (_model.locationsIdResult?.jsonBody ?? ''),
                                  ).toString()
                                : GetNearbyLocationsIdCall.centerCoordinate(
                                    (_model.placeIdsResult?.jsonBody ?? ''),
                                  ).toString(),
                            destinations: joinCoords(sublist(
                                    25,
                                    50,
                                    getJsonField(
                                              (_model.locationsResult
                                                      ?.jsonBody ??
                                                  ''),
                                              r'''$.succesful_results''',
                                            ) !=
                                            null
                                        ? (GetNearbyLocationsCall.coordinates(
                                            (_model.locationsResult?.jsonBody ??
                                                ''),
                                          ) as List)
                                            .map<String>((s) => s.toString())
                                            .toList()!
                                        : (GetNearbyLocationsCall.coordinates(
                                            (_model.nearbyLocationResult
                                                    ?.jsonBody ??
                                                ''),
                                          ) as List)
                                            .map<String>((s) => s.toString())
                                            .toList()!
                                            .toList())
                                .toList()),
                          );
                          _model.lEmailLast25 =
                              await CalculateDistanceCall.call(
                            origins: getJsonField(
                                      (_model.locationsIdResult?.jsonBody ??
                                          ''),
                                      r'''$.place_id_list''',
                                    ) !=
                                    null
                                ? GetNearbyLocationsIdCall.centerCoordinate(
                                    (_model.locationsIdResult?.jsonBody ?? ''),
                                  ).toString()
                                : GetNearbyLocationsIdCall.centerCoordinate(
                                    (_model.placeIdsResult?.jsonBody ?? ''),
                                  ).toString(),
                            destinations: joinCoords(sublist(
                                    50,
                                    75,
                                    getJsonField(
                                              (_model.locationsResult
                                                      ?.jsonBody ??
                                                  ''),
                                              r'''$.succesful_results''',
                                            ) !=
                                            null
                                        ? (GetNearbyLocationsCall.coordinates(
                                            (_model.locationsResult?.jsonBody ??
                                                ''),
                                          ) as List)
                                            .map<String>((s) => s.toString())
                                            .toList()!
                                        : (GetNearbyLocationsCall.coordinates(
                                            (_model.nearbyLocationResult
                                                    ?.jsonBody ??
                                                ''),
                                          ) as List)
                                            .map<String>((s) => s.toString())
                                            .toList()!
                                            .toList())
                                .toList()),
                          );
                          await showAlignedDialog(
                            context: context,
                            isGlobal: true,
                            avoidOverflow: false,
                            targetAnchor: AlignmentDirectional(0.0, 0.0)
                                .resolve(Directionality.of(context)),
                            followerAnchor: AlignmentDirectional(0.0, 0.0)
                                .resolve(Directionality.of(context)),
                            builder: (dialogContext) {
                              return Material(
                                color: Colors.transparent,
                                child: GestureDetector(
                                  onTap: () => FocusScope.of(context)
                                      .requestFocus(_model.unfocusNode),
                                  child: EmailWidget(
                                    locations: getJsonField(
                                              (_model.locationsResult
                                                      ?.jsonBody ??
                                                  ''),
                                              r'''$.succesful_results''',
                                            ) !=
                                            null
                                        ? GetNearbyLocationsCall.locationList(
                                            (_model.locationsResult?.jsonBody ??
                                                ''),
                                          )!
                                        : GetNearbyLocationsCall.locationList(
                                            (_model.nearbyLocationResult
                                                    ?.jsonBody ??
                                                ''),
                                          )!,
                                    query: _model.queryDropdownValue == null ||
                                            _model.queryDropdownValue == ''
                                        ? _model.sQueryDropdownValue
                                        : _model.queryDropdownValue,
                                    location: _model.locationDropdownValue ==
                                                null ||
                                            _model.locationDropdownValue == ''
                                        ? _model.sLocationDropdownValue!
                                        : _model.locationDropdownValue!,
                                    distances: joinLists(
                                        (CalculateDistanceCall.distance(
                                          (_model.lEmailFirst25?.jsonBody ??
                                              ''),
                                        ) as List)
                                            .map<String>((s) => s.toString())
                                            .toList()
                                            ?.toList(),
                                        (CalculateDistanceCall.distance(
                                          (_model.lEmailNext25?.jsonBody ?? ''),
                                        ) as List)
                                            .map<String>((s) => s.toString())
                                            .toList()
                                            ?.toList(),
                                        (CalculateDistanceCall.distance(
                                          (_model.lEmailLast25?.jsonBody ?? ''),
                                        ) as List)
                                            .map<String>((s) => s.toString())
                                            .toList()
                                            ?.toList())!,
                                    distance: _model.sSliderRadiusValue != null
                                        ? _model.sSliderRadiusValue!
                                        : _model.sliderRadius2Value!,
                                  ),
                                ),
                              );
                            },
                          ).then((value) => setState(() {}));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'No content to download, submit location query then try again.',
                                style: GoogleFonts.getFont(
                                  'Poppins',
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  fontSize: 16.0,
                                ),
                              ),
                              duration: Duration(milliseconds: 4000),
                              backgroundColor:
                                  FlutterFlowTheme.of(context).secondary,
                            ),
                          );
                        }

                        setState(() {});
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FlutterFlowIconButton(
                            borderColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: 20.0,
                            buttonSize: 40.0,
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            icon: Icon(
                              Icons.attach_email_outlined,
                              color: FlutterFlowTheme.of(context).accent1,
                              size: 20.0,
                            ),
                            showLoadingIndicator: true,
                            onPressed: () {
                              print('IconButton pressed ...');
                            },
                          ),
                          Text(
                            'Email',
                            style: GoogleFonts.getFont(
                              'Poppins',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FlutterFlowIconButton(
                        borderColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: 20.0,
                        buttonSize: 40.0,
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        icon: Icon(
                          Icons.cookie_outlined,
                          color: FlutterFlowTheme.of(context).accent1,
                          size: 20.0,
                        ),
                        showLoadingIndicator: true,
                        onPressed: () {
                          print('IconButton pressed ...');
                        },
                      ),
                      Text(
                        'Privacy Policy',
                        style: GoogleFonts.getFont(
                          'Poppins',
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      await openUrl(
                        ' https://uxlivinglab.com/en/',
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FlutterFlowIconButton(
                          borderColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: 20.0,
                          buttonSize: 40.0,
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          icon: Icon(
                            Icons.info_outlined,
                            color: FlutterFlowTheme.of(context).accent1,
                            size: 20.0,
                          ),
                          showLoadingIndicator: true,
                          onPressed: () {
                            print('IconButton pressed ...');
                          },
                        ),
                        Text(
                          'UX Living Lab',
                          style: GoogleFonts.getFont(
                            'Poppins',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(8.0, 8.0, 8.0, 8.0),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      Navigator.pop(context);
                      await exitApp();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FlutterFlowIconButton(
                          borderColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: 20.0,
                          buttonSize: 40.0,
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          icon: Icon(
                            Icons.logout_rounded,
                            color: FlutterFlowTheme.of(context).accent1,
                            size: 20.0,
                          ),
                          showLoadingIndicator: true,
                          onPressed: () {
                            print('IconButton pressed ...');
                          },
                        ),
                        Text(
                          'Exit',
                          style: GoogleFonts.getFont(
                            'Poppins',
                            color: FlutterFlowTheme.of(context).secondaryText,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          width: MediaQuery.sizeOf(context).width * 1.0,
          height: MediaQuery.sizeOf(context).height * 1.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondary,
          ),
          alignment: AlignmentDirectional(0.00, 1.00),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (responsiveVisibility(
                context: context,
                phone: false,
                tablet: false,
              ))
                Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: MediaQuery.sizeOf(context).height * 0.15,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondary,
                  ),
                  alignment: AlignmentDirectional(-1.00, 0.00),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      FlutterFlowIconButton(
                        borderColor: FlutterFlowTheme.of(context).secondary,
                        borderRadius: 8.0,
                        buttonSize: 60.0,
                        fillColor: FlutterFlowTheme.of(context).secondary,
                        icon: Icon(
                          Icons.menu_rounded,
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          size: 32.0,
                        ),
                        onPressed: () async {
                          scaffoldKey.currentState!.openDrawer();
                        },
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.85,
                        height: MediaQuery.sizeOf(context).height * 0.15,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondary,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (responsiveVisibility(
                              context: context,
                              phone: false,
                              tablet: false,
                            ))
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.asset(
                                      'assets/images/Group_1.png',
                                      height: 67.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      'Search in DoWell Living Lab',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.getFont(
                                        'Poppins',
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 40.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ]
                        .divide(SizedBox(width: 12.0))
                        .addToStart(SizedBox(width: 32.0)),
                  ),
                ),
              if (responsiveVisibility(
                context: context,
                tabletLandscape: false,
                desktop: false,
              ))
                Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: MediaQuery.sizeOf(context).height * 0.15,
                  decoration: BoxDecoration(
                    color: Color(0xFF3BB06C),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.asset(
                        'assets/images/Vector.png',
                      ).image,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FlutterFlowIconButton(
                        borderColor: FlutterFlowTheme.of(context).secondary,
                        borderRadius: 8.0,
                        buttonSize: 60.0,
                        fillColor: FlutterFlowTheme.of(context).secondary,
                        icon: Icon(
                          Icons.menu_rounded,
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          size: 32.0,
                        ),
                        onPressed: () async {
                          scaffoldKey.currentState!.openDrawer();
                        },
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'assets/images/Group_1.png',
                              width: 60.0,
                              height: 44.8,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            'Search in UX Living Lab',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.getFont(
                              'Poppins',
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 20.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              Align(
                alignment: AlignmentDirectional(0.00, -1.00),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: MediaQuery.sizeOf(context).width >= 767.0
                      ? (MediaQuery.sizeOf(context).height * 0.85)
                      : (MediaQuery.sizeOf(context).height * 0.77),
                  decoration: BoxDecoration(
                    color: Color(0xFFD4FFE6),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0),
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (responsiveVisibility(
                          context: context,
                          tabletLandscape: false,
                          desktop: false,
                        ))
                          SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      8.0, 32.0, 8.0, 0.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (responsiveVisibility(
                                        context: context,
                                        phone: false,
                                        tablet: false,
                                        tabletLandscape: false,
                                        desktop: false,
                                      ))
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  6.0, 0.0, 0.0, 12.0),
                                          child: Text(
                                            'How it works?',
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.0,
                                              height: 1.2,
                                            ),
                                          ),
                                        ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            6.0, 0.0, 6.0, 24.0),
                                        child: Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.96,
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.2,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondary,
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: Image.asset(
                                                'assets/images/9267_[Converted]-01_1.png',
                                              ).image,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          alignment:
                                              AlignmentDirectional(0.00, 0.00),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    1.0, 1.0, 1.0, 1.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Stack(
                                                  children: [
                                                    if (_model.sLocationDropdownValue ==
                                                            null ||
                                                        _model.sLocationDropdownValue ==
                                                            '')
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                0.00, 0.00),
                                                        child:
                                                            FlutterFlowIconButton(
                                                          borderColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondary,
                                                          borderRadius: 30.0,
                                                          borderWidth: 0.0,
                                                          buttonSize: 60.0,
                                                          fillColor: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          icon: Icon(
                                                            Icons.play_arrow,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondary,
                                                            size: 30.0,
                                                          ),
                                                          showLoadingIndicator:
                                                              true,
                                                          onPressed: () async {
                                                            await launchURLInWebView(
                                                              context,
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .secondaryBackground,
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primary,
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    if (_model.sLocationDropdownValue !=
                                                            null &&
                                                        _model.sLocationDropdownValue !=
                                                            '')
                                                      FutureBuilder<
                                                          ApiCallResponse>(
                                                        future:
                                                            GetCoordinatesCall
                                                                .call(
                                                          location: _model
                                                              .sLocationDropdownValue,
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          // Customize what your widget looks like when it's loading.
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                              child: SizedBox(
                                                                width: 50.0,
                                                                height: 50.0,
                                                                child:
                                                                    CircularProgressIndicator(
                                                                  valueColor:
                                                                      AlwaysStoppedAnimation<
                                                                          Color>(
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                          final googleMapGetCoordinatesResponse =
                                                              snapshot.data!;
                                                          return Builder(
                                                              builder:
                                                                  (context) {
                                                            final _googleMapMarker =
                                                                FFAppState()
                                                                    .location;
                                                            return FlutterFlowGoogleMap(
                                                              controller: _model
                                                                  .googleMapsController1,
                                                              onCameraIdle: (latLng) =>
                                                                  setState(() =>
                                                                      _model.googleMapsCenter1 =
                                                                          latLng),
                                                              initialLocation: _model
                                                                      .googleMapsCenter1 ??=
                                                                  getLatLng(
                                                                      formatLng(
                                                                          GetCoordinatesCall
                                                                              .lat(
                                                                        googleMapGetCoordinatesResponse
                                                                            .jsonBody,
                                                                      ).toString()),
                                                                      formatLng(GetCoordinatesCall.lng(
                                                                        googleMapGetCoordinatesResponse
                                                                            .jsonBody,
                                                                      ).toString())),
                                                              markers: [
                                                                if (_googleMapMarker !=
                                                                    null)
                                                                  FlutterFlowMarker(
                                                                    _googleMapMarker
                                                                        .serialize(),
                                                                    _googleMapMarker,
                                                                  ),
                                                              ],
                                                              markerColor:
                                                                  GoogleMarkerColor
                                                                      .green,
                                                              mapType: MapType
                                                                  .normal,
                                                              style:
                                                                  GoogleMapStyle
                                                                      .standard,
                                                              initialZoom: 14.0,
                                                              allowInteraction:
                                                                  true,
                                                              allowZoom: true,
                                                              showZoomControls:
                                                                  true,
                                                              showLocation:
                                                                  false,
                                                              showCompass:
                                                                  false,
                                                              showMapToolbar:
                                                                  false,
                                                              showTraffic:
                                                                  false,
                                                              centerMapOnMarkerTap:
                                                                  true,
                                                            );
                                                          });
                                                        },
                                                      ),
                                                    FutureBuilder<
                                                        ApiCallResponse>(
                                                      future: GetCoordinatesCall
                                                          .call(
                                                        location: _model
                                                            .locationDropdownValue,
                                                      ),
                                                      builder:
                                                          (context, snapshot) {
                                                        // Customize what your widget looks like when it's loading.
                                                        if (!snapshot.hasData) {
                                                          return Center(
                                                            child: SizedBox(
                                                              width: 50.0,
                                                              height: 50.0,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                valueColor:
                                                                    AlwaysStoppedAnimation<
                                                                        Color>(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                        final livingLabMapGetCoordinatesResponse =
                                                            snapshot.data!;
                                                        return Container(
                                                          width:
                                                              double.infinity,
                                                          height: 180.0,
                                                          child: LivingLabMap(
                                                            width:
                                                                double.infinity,
                                                            height: 180.0,
                                                            radius: _model
                                                                .sSliderRadiusValue!,
                                                            target: FFAppState()
                                                                        .location ==
                                                                    null
                                                                ? getLatLng(
                                                                    formatCoords(GetCoordinatesCall
                                                                            .lat(
                                                                      livingLabMapGetCoordinatesResponse
                                                                          .jsonBody,
                                                                    )
                                                                        .toString()),
                                                                    formatCoords(
                                                                        GetCoordinatesCall
                                                                            .lng(
                                                                      livingLabMapGetCoordinatesResponse
                                                                          .jsonBody,
                                                                    ).toString()))
                                                                : FFAppState().location!,
                                                            center: getLatLng(
                                                                formatCoords(
                                                                    GetCoordinatesCall
                                                                        .lat(
                                                                  livingLabMapGetCoordinatesResponse
                                                                      .jsonBody,
                                                                ).toString()),
                                                                formatCoords(
                                                                    GetCoordinatesCall
                                                                        .lng(
                                                                  livingLabMapGetCoordinatesResponse
                                                                      .jsonBody,
                                                                ).toString())),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 12.0, 0.0, 0.0),
                                        child: Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.96,
                                          child: Form(
                                            key: _model.formKey2,
                                            autovalidateMode:
                                                AutovalidateMode.disabled,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          6.0, 4.0, 6.0, 4.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Flexible(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      4.0,
                                                                      0.0),
                                                          child: FutureBuilder<
                                                              ApiCallResponse>(
                                                            future:
                                                                GetCategoriesCall
                                                                    .call(),
                                                            builder: (context,
                                                                snapshot) {
                                                              // Customize what your widget looks like when it's loading.
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.46,
                                                                  child:
                                                                      DropdownPlaceholderWidget(),
                                                                );
                                                              }
                                                              final sQueryDropdownGetCategoriesResponse =
                                                                  snapshot
                                                                      .data!;
                                                              return FlutterFlowDropDown<
                                                                  String>(
                                                                controller: _model
                                                                        .sQueryDropdownValueController ??=
                                                                    FormFieldController<
                                                                            String>(
                                                                        null),
                                                                options: (GetCategoriesCall
                                                                        .categories(
                                                                  sQueryDropdownGetCategoriesResponse
                                                                      .jsonBody,
                                                                ) as List)
                                                                    .map<String>(
                                                                        (s) => s
                                                                            .toString())
                                                                    .toList()!,
                                                                onChanged: (val) =>
                                                                    setState(() =>
                                                                        _model.sQueryDropdownValue =
                                                                            val),
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.48,
                                                                searchHintTextStyle:
                                                                    GoogleFonts
                                                                        .getFont(
                                                                  'Poppins',
                                                                  color: Color(
                                                                      0xFFB4B4B4),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      16.0,
                                                                  height: 1.2,
                                                                ),
                                                                textStyle:
                                                                    GoogleFonts
                                                                        .getFont(
                                                                  'Poppins',
                                                                  color: Color(
                                                                      0xFF3BB06C),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize:
                                                                      16.0,
                                                                ),
                                                                hintText:
                                                                    'Searching for',
                                                                searchHintText:
                                                                    'Search for',
                                                                searchCursorColor:
                                                                    Colors
                                                                        .black,
                                                                icon: Icon(
                                                                  Icons
                                                                      .keyboard_arrow_down_rounded,
                                                                  color: Color(
                                                                      0xFF57636C),
                                                                  size: 24.0,
                                                                ),
                                                                fillColor:
                                                                    Colors
                                                                        .white,
                                                                elevation: 8.0,
                                                                borderColor: Color(
                                                                    0xFFB4B4B4),
                                                                borderWidth:
                                                                    1.0,
                                                                borderRadius:
                                                                    8.0,
                                                                margin:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                hidesUnderline:
                                                                    true,
                                                                isSearchable:
                                                                    true,
                                                                isMultiSelect:
                                                                    false,
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      Flexible(
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      4.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: FutureBuilder<
                                                              ApiCallResponse>(
                                                            future:
                                                                GetCitiesCall
                                                                    .call(),
                                                            builder: (context,
                                                                snapshot) {
                                                              // Customize what your widget looks like when it's loading.
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.43,
                                                                  child:
                                                                      DropdownPlaceholderWidget(),
                                                                );
                                                              }
                                                              final sLocationDropdownGetCitiesResponse =
                                                                  snapshot
                                                                      .data!;
                                                              return FlutterFlowDropDown<
                                                                  String>(
                                                                controller: _model
                                                                        .sLocationDropdownValueController ??=
                                                                    FormFieldController<
                                                                            String>(
                                                                        null),
                                                                options: (GetCitiesCall
                                                                        .citiesName(
                                                                  sLocationDropdownGetCitiesResponse
                                                                      .jsonBody,
                                                                ) as List)
                                                                    .map<String>(
                                                                        (s) => s
                                                                            .toString())
                                                                    .toList()!,
                                                                onChanged:
                                                                    (val) async {
                                                                  setState(() =>
                                                                      _model.sLocationDropdownValue =
                                                                          val);
                                                                  setState(() {
                                                                    FFAppState()
                                                                            .locationName =
                                                                        _model
                                                                            .sLocationDropdownValue!;
                                                                  });
                                                                },
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.43,
                                                                searchHintTextStyle:
                                                                    GoogleFonts
                                                                        .getFont(
                                                                  'Poppins',
                                                                  color: Color(
                                                                      0xFFB4B4B4),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize:
                                                                      16.0,
                                                                  height: 1.2,
                                                                ),
                                                                textStyle:
                                                                    GoogleFonts
                                                                        .getFont(
                                                                  'Poppins',
                                                                  color: Color(
                                                                      0xFF3BB06C),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize:
                                                                      16.0,
                                                                ),
                                                                hintText:
                                                                    'Select a city',
                                                                searchHintText:
                                                                    'Search for a city',
                                                                searchCursorColor:
                                                                    Colors
                                                                        .black,
                                                                icon: Icon(
                                                                  Icons
                                                                      .keyboard_arrow_down_rounded,
                                                                  color: Color(
                                                                      0xFF57636C),
                                                                  size: 24.0,
                                                                ),
                                                                fillColor:
                                                                    Colors
                                                                        .white,
                                                                elevation: 8.0,
                                                                borderColor: Color(
                                                                    0xFFB4B4B4),
                                                                borderWidth:
                                                                    1.0,
                                                                borderRadius:
                                                                    8.0,
                                                                margin:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                hidesUnderline:
                                                                    true,
                                                                isSearchable:
                                                                    true,
                                                                isMultiSelect:
                                                                    false,
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  8.0,
                                                                  16.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Text(
                                                        'Distance from city centre in meters',
                                                        textAlign:
                                                            TextAlign.start,
                                                        style:
                                                            GoogleFonts.getFont(
                                                          'Poppins',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16.0,
                                                          height: 1.2,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  8.0,
                                                                  16.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Text(
                                                        formatNumber(
                                                          _model
                                                              .sSliderRadiusValue,
                                                          formatType:
                                                              FormatType.custom,
                                                          format: '0',
                                                          locale: 'en_US',
                                                        ),
                                                        textAlign:
                                                            TextAlign.start,
                                                        style:
                                                            GoogleFonts.getFont(
                                                          'Poppins',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16.0,
                                                          height: 1.2,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  child: Slider.adaptive(
                                                    activeColor:
                                                        Color(0xFF21633D),
                                                    inactiveColor: Colors.white,
                                                    min: 0.0,
                                                    max: 10000.0,
                                                    value: _model
                                                            .sSliderRadiusValue ??=
                                                        0.0,
                                                    label: _model
                                                        .sSliderRadiusValue
                                                        .toString(),
                                                    divisions: 10000,
                                                    onChanged: (newValue) {
                                                      newValue = double.parse(
                                                          newValue
                                                              .toStringAsFixed(
                                                                  0));
                                                      setState(() => _model
                                                              .sSliderRadiusValue =
                                                          newValue);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if ((getJsonField(
                                          (_model.nearbyLocationResult
                                                  ?.jsonBody ??
                                              ''),
                                          r'''$.succesful_results''',
                                        ) !=
                                        null) &&
                                    (FFAppState().refreshed != true))
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 8.0, 0.0, 8.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8.0, 0.0, 0.0, 0.0),
                                          child: Text(
                                            '${listLength(GetNearbyLocationsCall.locationList(
                                              (_model.nearbyLocationResult
                                                      ?.jsonBody ??
                                                  ''),
                                            )!.toList()).toString()} Results',
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                if ((getJsonField(
                                          (_model.nearbyLocationResult
                                                  ?.jsonBody ??
                                              ''),
                                          r'''$.succesful_results''',
                                        ) !=
                                        null) &&
                                    (FFAppState().refreshed != true))
                                  Container(
                                    width: MediaQuery.sizeOf(context).width *
                                        0.965,
                                    height: 335.0,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFD4FFE6),
                                    ),
                                    child: Builder(
                                      builder: (context) {
                                        final locationResults =
                                            GetNearbyLocationsCall.locationList(
                                                  (_model.nearbyLocationResult
                                                          ?.jsonBody ??
                                                      ''),
                                                )?.toList() ??
                                                [];
                                        return ListView.builder(
                                          padding: EdgeInsets.zero,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: locationResults.length,
                                          itemBuilder:
                                              (context, locationResultsIndex) {
                                            final locationResultsItem =
                                                locationResults[
                                                    locationResultsIndex];
                                            return Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(8.0, 8.0, 8.0, 8.0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  setState(() {
                                                    FFAppState().location =
                                                        latLngFromLocation(
                                                            getJsonField(
                                                      locationResultsItem,
                                                      r'''$.location_coord''',
                                                    ).toString());
                                                  });
                                                },
                                                child: Material(
                                                  color: Colors.transparent,
                                                  elevation: 4.0,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  child: Container(
                                                    width: 358.0,
                                                    height: 331.0,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            width: 358.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        0.0),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        0.0),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        8.0),
                                                                topRight: Radius
                                                                    .circular(
                                                                        8.0),
                                                              ),
                                                            ),
                                                            child: Stack(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      0.0, 0.0),
                                                              children: [
                                                                if (getJsonField(
                                                                      locationResultsItem,
                                                                      r'''$.photo_reference''',
                                                                    ) ==
                                                                    'None')
                                                                  Icon(
                                                                    Icons
                                                                        .image_outlined,
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .accent1,
                                                                    size: 150.0,
                                                                  ),
                                                                if (getJsonField(
                                                                      locationResultsItem,
                                                                      r'''$.photo_reference''',
                                                                    ) !=
                                                                    'None')
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              0.0),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              0.0),
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              8.0),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              8.0),
                                                                    ),
                                                                    child:
                                                                        CachedNetworkImage(
                                                                      fadeInDuration:
                                                                          Duration(
                                                                              milliseconds: 700),
                                                                      fadeOutDuration:
                                                                          Duration(
                                                                              milliseconds: 700),
                                                                      imageUrl:
                                                                          'https://maps.googleapis.com/maps/api/place/photo?maxwidth=358&photo_reference=${getJsonField(
                                                                        locationResultsItem,
                                                                        r'''$.photo_reference''',
                                                                      ).toString()}&key=AIzaSyAsH8omDk8y0lSGLTW9YtZiiQ2MkmsF-uQ',
                                                                      width:
                                                                          358.0,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      4.0,
                                                                      4.0,
                                                                      4.0,
                                                                      4.0),
                                                          child: Text(
                                                            getJsonField(
                                                              locationResultsItem,
                                                              r'''$.place_name''',
                                                            )
                                                                .toString()
                                                                .maybeHandleOverflow(
                                                                  maxChars: 30,
                                                                  replacement:
                                                                      '…',
                                                                ),
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: GoogleFonts
                                                                .getFont(
                                                              'Poppins',
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primaryText,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 20.0,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      4.0,
                                                                      0.0,
                                                                      4.0,
                                                                      4.0),
                                                          child: FutureBuilder<
                                                              ApiCallResponse>(
                                                            future:
                                                                CalculateDistanceCall
                                                                    .call(
                                                              origins:
                                                                  GetNearbyLocationsIdCall
                                                                      .centerCoordinate(
                                                                (_model.placeIdsResult
                                                                        ?.jsonBody ??
                                                                    ''),
                                                              ).toString(),
                                                              destinations:
                                                                  getJsonField(
                                                                locationResultsItem,
                                                                r'''$.location_coord''',
                                                              ).toString(),
                                                            ),
                                                            builder: (context,
                                                                snapshot) {
                                                              // Customize what your widget looks like when it's loading.
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return DistancePlaceholderWidget();
                                                              }
                                                              final nameCalculateDistanceResponse =
                                                                  snapshot
                                                                      .data!;
                                                              return Text(
                                                                'Driving distance ${valueOrDefault<String>(
                                                                  getJsonField(
                                                                    nameCalculateDistanceResponse
                                                                        .jsonBody,
                                                                    r'''$.rows[:].elements[:].distance.text''',
                                                                  ).toString(),
                                                                  'N/A',
                                                                )}'
                                                                    .maybeHandleOverflow(
                                                                  maxChars: 30,
                                                                  replacement:
                                                                      '…',
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                style:
                                                                    GoogleFonts
                                                                        .getFont(
                                                                  'Poppins',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontSize:
                                                                      16.0,
                                                                ),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      4.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            4.0,
                                                                            0.0),
                                                                child: Icon(
                                                                  Icons
                                                                      .location_on_sharp,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                                  size: 20.0,
                                                                ),
                                                              ),
                                                              Text(
                                                                getJsonField(
                                                                  locationResultsItem,
                                                                  r'''$.address''',
                                                                )
                                                                    .toString()
                                                                    .maybeHandleOverflow(
                                                                      maxChars:
                                                                          26,
                                                                      replacement:
                                                                          '…',
                                                                    ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .start,
                                                                maxLines: 2,
                                                                style:
                                                                    GoogleFonts
                                                                        .getFont(
                                                                  'Poppins',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      16.0,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      4.0,
                                                                      0.0,
                                                                      0.0,
                                                                      0.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            4.0,
                                                                            0.0),
                                                                child: FaIcon(
                                                                  FontAwesomeIcons
                                                                      .globe,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                                  size: 20.0,
                                                                ),
                                                              ),
                                                              Text(
                                                                getJsonField(
                                                                  locationResultsItem,
                                                                  r'''$.website''',
                                                                )
                                                                    .toString()
                                                                    .maybeHandleOverflow(
                                                                      maxChars:
                                                                          26,
                                                                      replacement:
                                                                          '…',
                                                                    ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    GoogleFonts
                                                                        .getFont(
                                                                  'Poppins',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      16.0,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      4.0,
                                                                      0.0,
                                                                      0.0,
                                                                      8.0),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            4.0,
                                                                            0.0),
                                                                child: Icon(
                                                                  Icons
                                                                      .phone_sharp,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                                  size: 20.0,
                                                                ),
                                                              ),
                                                              Text(
                                                                getJsonField(
                                                                  locationResultsItem,
                                                                  r'''$.phone''',
                                                                )
                                                                    .toString()
                                                                    .maybeHandleOverflow(
                                                                      maxChars:
                                                                          26,
                                                                      replacement:
                                                                          '…',
                                                                    ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style:
                                                                    GoogleFonts
                                                                        .getFont(
                                                                  'Poppins',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize:
                                                                      16.0,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        if (responsiveVisibility(
                          context: context,
                          phone: false,
                          tablet: false,
                        ))
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            8.0, 32.0, 8.0, 24.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            if (responsiveVisibility(
                                              context: context,
                                              phone: false,
                                              tablet: false,
                                              tabletLandscape: false,
                                              desktop: false,
                                            ))
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 12.0),
                                                child: Text(
                                                  'How it works?',
                                                  textAlign: TextAlign.start,
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 24.0,
                                                    height: 1.2,
                                                  ),
                                                ),
                                              ),
                                            Align(
                                              alignment: AlignmentDirectional(
                                                  0.00, -1.00),
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        1.0,
                                                decoration: BoxDecoration(),
                                                alignment: AlignmentDirectional(
                                                    0.00, 0.00),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          16.0, 0.0, 0.0, 0.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1.00, 0.00),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      6.0,
                                                                      0.0,
                                                                      6.0,
                                                                      0.0),
                                                          child: Container(
                                                            width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width <
                                                                    1280.0
                                                                ? (MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.48)
                                                                : (MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.48),
                                                            height: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width <
                                                                    1279.0
                                                                ? (MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    0.2)
                                                                : 290.0,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondary,
                                                              image:
                                                                  DecorationImage(
                                                                fit: BoxFit
                                                                    .cover,
                                                                image:
                                                                    Image.asset(
                                                                  'assets/images/9267_[Converted]-01_1.png',
                                                                ).image,
                                                              ),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                            ),
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    -1.00,
                                                                    0.00),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          1.0,
                                                                          1.0,
                                                                          1.0,
                                                                          1.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                        Stack(
                                                                      children: [
                                                                        if ((_model.locationDropdownValue != null &&
                                                                                _model.locationDropdownValue != '') &&
                                                                            responsiveVisibility(
                                                                              context: context,
                                                                              phone: false,
                                                                              tablet: false,
                                                                              tabletLandscape: false,
                                                                              desktop: false,
                                                                            ))
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0.00, 0.00),
                                                                            child:
                                                                                FutureBuilder<ApiCallResponse>(
                                                                              future: GetCoordinatesCall.call(
                                                                                location: _model.locationDropdownValue,
                                                                              ),
                                                                              builder: (context, snapshot) {
                                                                                // Customize what your widget looks like when it's loading.
                                                                                if (!snapshot.hasData) {
                                                                                  return Center(
                                                                                    child: SizedBox(
                                                                                      width: 50.0,
                                                                                      height: 50.0,
                                                                                      child: CircularProgressIndicator(
                                                                                        valueColor: AlwaysStoppedAnimation<Color>(
                                                                                          FlutterFlowTheme.of(context).primary,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                }
                                                                                final googleMapGetCoordinatesResponse = snapshot.data!;
                                                                                return Builder(builder: (context) {
                                                                                  final _googleMapMarker = FFAppState().location;
                                                                                  return FlutterFlowGoogleMap(
                                                                                    controller: _model.googleMapsController2,
                                                                                    onCameraIdle: (latLng) => setState(() => _model.googleMapsCenter2 = latLng),
                                                                                    initialLocation: _model.googleMapsCenter2 ??= getLatLng(
                                                                                        formatLng(GetCoordinatesCall.lat(
                                                                                          googleMapGetCoordinatesResponse.jsonBody,
                                                                                        ).toString()),
                                                                                        formatLng(GetCoordinatesCall.lng(
                                                                                          googleMapGetCoordinatesResponse.jsonBody,
                                                                                        ).toString())),
                                                                                    markers: [
                                                                                      if (_googleMapMarker != null)
                                                                                        FlutterFlowMarker(
                                                                                          _googleMapMarker.serialize(),
                                                                                          _googleMapMarker,
                                                                                        ),
                                                                                    ],
                                                                                    markerColor: GoogleMarkerColor.green,
                                                                                    mapType: MapType.normal,
                                                                                    style: GoogleMapStyle.standard,
                                                                                    initialZoom: 12.0,
                                                                                    allowInteraction: true,
                                                                                    allowZoom: true,
                                                                                    showZoomControls: true,
                                                                                    showLocation: false,
                                                                                    showCompass: false,
                                                                                    showMapToolbar: false,
                                                                                    showTraffic: false,
                                                                                    centerMapOnMarkerTap: true,
                                                                                  );
                                                                                });
                                                                              },
                                                                            ),
                                                                          ),
                                                                        if (_model.locationDropdownValue ==
                                                                                null ||
                                                                            _model.locationDropdownValue ==
                                                                                '')
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0.00, 0.00),
                                                                            child:
                                                                                FlutterFlowIconButton(
                                                                              borderColor: FlutterFlowTheme.of(context).secondary,
                                                                              borderRadius: 30.0,
                                                                              borderWidth: 0.0,
                                                                              buttonSize: 60.0,
                                                                              fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              icon: Icon(
                                                                                Icons.play_arrow,
                                                                                color: FlutterFlowTheme.of(context).secondary,
                                                                                size: 30.0,
                                                                              ),
                                                                              showLoadingIndicator: true,
                                                                              onPressed: () async {
                                                                                await launchURLInWebView(
                                                                                  context,
                                                                                  FlutterFlowTheme.of(context).secondaryBackground,
                                                                                  FlutterFlowTheme.of(context).primary,
                                                                                );
                                                                              },
                                                                            ),
                                                                          ),
                                                                        if ((_model.locationDropdownValue != null && _model.locationDropdownValue != '') &&
                                                                            (_model.sliderRadius2Value !=
                                                                                null))
                                                                          FutureBuilder<
                                                                              ApiCallResponse>(
                                                                            future:
                                                                                GetCoordinatesCall.call(
                                                                              location: _model.locationDropdownValue,
                                                                            ),
                                                                            builder:
                                                                                (context, snapshot) {
                                                                              // Customize what your widget looks like when it's loading.
                                                                              if (!snapshot.hasData) {
                                                                                return Center(
                                                                                  child: SizedBox(
                                                                                    width: 50.0,
                                                                                    height: 50.0,
                                                                                    child: CircularProgressIndicator(
                                                                                      valueColor: AlwaysStoppedAnimation<Color>(
                                                                                        FlutterFlowTheme.of(context).primary,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                );
                                                                              }
                                                                              final livingLabMapGetCoordinatesResponse = snapshot.data!;
                                                                              return Container(
                                                                                width: double.infinity,
                                                                                height: double.infinity,
                                                                                child: LivingLabMap(
                                                                                  width: double.infinity,
                                                                                  height: double.infinity,
                                                                                  radius: _model.sliderRadius2Value!,
                                                                                  target: FFAppState().location == null
                                                                                      ? getLatLng(
                                                                                          formatCoords(GetCoordinatesCall.lat(
                                                                                            livingLabMapGetCoordinatesResponse.jsonBody,
                                                                                          ).toString()),
                                                                                          formatCoords(GetCoordinatesCall.lng(
                                                                                            livingLabMapGetCoordinatesResponse.jsonBody,
                                                                                          ).toString()))
                                                                                      : FFAppState().location!,
                                                                                  center: getLatLng(
                                                                                      formatCoords(GetCoordinatesCall.lat(
                                                                                        livingLabMapGetCoordinatesResponse.jsonBody,
                                                                                      ).toString()),
                                                                                      formatCoords(GetCoordinatesCall.lng(
                                                                                        livingLabMapGetCoordinatesResponse.jsonBody,
                                                                                      ).toString())),
                                                                                ),
                                                                              );
                                                                            },
                                                                          ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: MediaQuery.sizeOf(
                                                                        context)
                                                                    .width <
                                                                1280.0
                                                            ? (MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.48)
                                                            : (MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.48),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFD4FFE6),
                                                        ),
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1.00, 0.00),
                                                        child: Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.47,
                                                          child: Form(
                                                            key:
                                                                _model.formKey1,
                                                            autovalidateMode:
                                                                AutovalidateMode
                                                                    .always,
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  height: 56.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xFFD4FFE6),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            4.0,
                                                                            0.0),
                                                                    child: FutureBuilder<
                                                                        ApiCallResponse>(
                                                                      future: GetCategoriesCall
                                                                          .call(),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        // Customize what your widget looks like when it's loading.
                                                                        if (!snapshot
                                                                            .hasData) {
                                                                          return Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.46,
                                                                            height:
                                                                                56.0,
                                                                            child:
                                                                                DropdownPlaceholderWidget(),
                                                                          );
                                                                        }
                                                                        final queryDropdownGetCategoriesResponse =
                                                                            snapshot.data!;
                                                                        return FlutterFlowDropDown<
                                                                            String>(
                                                                          controller: _model.queryDropdownValueController ??=
                                                                              FormFieldController<String>(null),
                                                                          options: (GetCategoriesCall.categories(
                                                                            queryDropdownGetCategoriesResponse.jsonBody,
                                                                          ) as List)
                                                                              .map<String>((s) => s.toString())
                                                                              .toList()!,
                                                                          onChanged: (val) =>
                                                                              setState(() => _model.queryDropdownValue = val),
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 0.46,
                                                                          height:
                                                                              56.0,
                                                                          searchHintTextStyle:
                                                                              GoogleFonts.getFont(
                                                                            'Poppins',
                                                                            color:
                                                                                Color(0xFFB4B4B4),
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontSize:
                                                                                16.0,
                                                                            height:
                                                                                1.2,
                                                                          ),
                                                                          textStyle:
                                                                              GoogleFonts.getFont(
                                                                            'Poppins',
                                                                            color:
                                                                                Color(0xFF3BB06C),
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            fontSize:
                                                                                16.0,
                                                                          ),
                                                                          hintText:
                                                                              'Searching for',
                                                                          searchHintText:
                                                                              'Search for',
                                                                          searchCursorColor:
                                                                              Colors.black,
                                                                          icon:
                                                                              Icon(
                                                                            Icons.keyboard_arrow_down_rounded,
                                                                            color:
                                                                                Color(0xFF57636C),
                                                                            size:
                                                                                24.0,
                                                                          ),
                                                                          fillColor:
                                                                              Colors.white,
                                                                          elevation:
                                                                              8.0,
                                                                          borderColor:
                                                                              Color(0xFFB4B4B4),
                                                                          borderWidth:
                                                                              1.0,
                                                                          borderRadius:
                                                                              8.0,
                                                                          margin: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          hidesUnderline:
                                                                              true,
                                                                          isSearchable:
                                                                              true,
                                                                          isMultiSelect:
                                                                              false,
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          16.0,
                                                                          0.0,
                                                                          0.0),
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        56.0,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child: FutureBuilder<
                                                                        ApiCallResponse>(
                                                                      future: GetCitiesCall
                                                                          .call(),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        // Customize what your widget looks like when it's loading.
                                                                        if (!snapshot
                                                                            .hasData) {
                                                                          return Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.46,
                                                                            height:
                                                                                56.0,
                                                                            child:
                                                                                DropdownPlaceholderWidget(),
                                                                          );
                                                                        }
                                                                        final locationDropdownGetCitiesResponse =
                                                                            snapshot.data!;
                                                                        return FlutterFlowDropDown<
                                                                            String>(
                                                                          controller: _model.locationDropdownValueController ??=
                                                                              FormFieldController<String>(null),
                                                                          options: (GetCitiesCall.citiesName(
                                                                            locationDropdownGetCitiesResponse.jsonBody,
                                                                          ) as List)
                                                                              .map<String>((s) => s.toString())
                                                                              .toList()!,
                                                                          onChanged:
                                                                              (val) async {
                                                                            setState(() =>
                                                                                _model.locationDropdownValue = val);
                                                                            setState(() {
                                                                              FFAppState().locationName = _model.locationDropdownValue!;
                                                                            });
                                                                          },
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 0.46,
                                                                          height:
                                                                              56.0,
                                                                          searchHintTextStyle:
                                                                              GoogleFonts.getFont(
                                                                            'Poppins',
                                                                            color:
                                                                                Color(0xFFB4B4B4),
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            fontSize:
                                                                                16.0,
                                                                            height:
                                                                                1.2,
                                                                          ),
                                                                          textStyle:
                                                                              GoogleFonts.getFont(
                                                                            'Poppins',
                                                                            color:
                                                                                Color(0xFF3BB06C),
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            fontSize:
                                                                                16.0,
                                                                          ),
                                                                          hintText:
                                                                              'Select a city',
                                                                          searchHintText:
                                                                              'Search for a city',
                                                                          searchCursorColor:
                                                                              Colors.black,
                                                                          icon:
                                                                              Icon(
                                                                            Icons.keyboard_arrow_down_rounded,
                                                                            color:
                                                                                Color(0xFF57636C),
                                                                            size:
                                                                                24.0,
                                                                          ),
                                                                          fillColor:
                                                                              Colors.white,
                                                                          elevation:
                                                                              8.0,
                                                                          borderColor:
                                                                              Color(0xFFB4B4B4),
                                                                          borderWidth:
                                                                              1.0,
                                                                          borderRadius:
                                                                              8.0,
                                                                          margin: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              0.0),
                                                                          hidesUnderline:
                                                                              true,
                                                                          isSearchable:
                                                                              true,
                                                                          isMultiSelect:
                                                                              false,
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          16.0,
                                                                          0.0,
                                                                          0.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.end,
                                                                        children: [
                                                                          Text(
                                                                            'Distance from city centre in meters',
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style:
                                                                                GoogleFonts.getFont(
                                                                              'Poppins',
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              fontWeight: FontWeight.w500,
                                                                              fontSize: 16.0,
                                                                              height: 1.2,
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                8.0,
                                                                                0.0,
                                                                                0.0,
                                                                                0.0),
                                                                            child:
                                                                                Text(
                                                                              formatNumber(
                                                                                _model.sliderRadius2Value,
                                                                                formatType: FormatType.custom,
                                                                                format: '0',
                                                                                locale: 'en_US',
                                                                              ),
                                                                              textAlign: TextAlign.start,
                                                                              style: GoogleFonts.getFont(
                                                                                'Poppins',
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                fontWeight: FontWeight.w600,
                                                                                fontSize: 16.0,
                                                                                height: 1.2,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width: double
                                                                          .infinity,
                                                                      child: Slider
                                                                          .adaptive(
                                                                        activeColor:
                                                                            Color(0xFF21633D),
                                                                        inactiveColor:
                                                                            Colors.white,
                                                                        min:
                                                                            0.0,
                                                                        max:
                                                                            10000.0,
                                                                        value: _model.sliderRadius2Value ??=
                                                                            0.0,
                                                                        label: _model
                                                                            .sliderRadius2Value
                                                                            .toString(),
                                                                        divisions:
                                                                            10000,
                                                                        onChanged:
                                                                            (newValue) {
                                                                          newValue =
                                                                              double.parse(newValue.toStringAsFixed(0));
                                                                          setState(() =>
                                                                              _model.sliderRadius2Value = newValue);
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                if (responsiveVisibility(
                                                                  context:
                                                                      context,
                                                                  phone: false,
                                                                  tablet: false,
                                                                ))
                                                                  Container(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        1.0,
                                                                    height: MediaQuery.sizeOf(context)
                                                                            .height *
                                                                        0.08,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children:
                                                                          [
                                                                        if (FFAppState().refreshed !=
                                                                            true)
                                                                          Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            children:
                                                                                [
                                                                              Builder(
                                                                                builder: (context) => FlutterFlowIconButton(
                                                                                  borderColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                  borderRadius: 8.0,
                                                                                  buttonSize: 40.0,
                                                                                  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                  icon: Icon(
                                                                                    Icons.file_download_outlined,
                                                                                    color: FlutterFlowTheme.of(context).primaryText,
                                                                                    size: 20.0,
                                                                                  ),
                                                                                  showLoadingIndicator: true,
                                                                                  onPressed: () async {
                                                                                    var _shouldSetState = false;
                                                                                    if ((getJsonField(
                                                                                              (_model.locationsResult?.jsonBody ?? ''),
                                                                                              r'''$.succesful_results''',
                                                                                            ) !=
                                                                                            null) &&
                                                                                        (FFAppState().refreshed != true)) {
                                                                                      _model.lFirst25 = await CalculateDistanceCall.call(
                                                                                        origins: GetNearbyLocationsIdCall.centerCoordinate(
                                                                                          (_model.locationsIdResult?.jsonBody ?? ''),
                                                                                        ).toString(),
                                                                                        destinations: joinCoords((GetNearbyLocationsCall.coordinates(
                                                                                          (_model.locationsResult?.jsonBody ?? ''),
                                                                                        ) as List)
                                                                                            .map<String>((s) => s.toString())
                                                                                            .toList()!
                                                                                            .take(25)
                                                                                            .toList()),
                                                                                      );
                                                                                      _shouldSetState = true;
                                                                                      _model.lNext25 = await CalculateDistanceCall.call(
                                                                                        origins: GetNearbyLocationsIdCall.centerCoordinate(
                                                                                          (_model.locationsIdResult?.jsonBody ?? ''),
                                                                                        ).toString(),
                                                                                        destinations: joinCoords(sublist(
                                                                                                25,
                                                                                                50,
                                                                                                (GetNearbyLocationsCall.coordinates(
                                                                                                  (_model.locationsResult?.jsonBody ?? ''),
                                                                                                ) as List)
                                                                                                    .map<String>((s) => s.toString())
                                                                                                    .toList()!
                                                                                                    .toList())
                                                                                            .toList()),
                                                                                      );
                                                                                      _shouldSetState = true;
                                                                                      _model.lLast25 = await CalculateDistanceCall.call(
                                                                                        origins: GetNearbyLocationsIdCall.centerCoordinate(
                                                                                          (_model.locationsIdResult?.jsonBody ?? ''),
                                                                                        ).toString(),
                                                                                        destinations: joinCoords(sublist(
                                                                                                50,
                                                                                                75,
                                                                                                (GetNearbyLocationsCall.coordinates(
                                                                                                  (_model.locationsResult?.jsonBody ?? ''),
                                                                                                ) as List)
                                                                                                    .map<String>((s) => s.toString())
                                                                                                    .toList()!
                                                                                                    .toList())
                                                                                            .toList()),
                                                                                      );
                                                                                      _shouldSetState = true;
                                                                                      await showAlignedDialog(
                                                                                        context: context,
                                                                                        isGlobal: true,
                                                                                        avoidOverflow: false,
                                                                                        targetAnchor: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                                        followerAnchor: AlignmentDirectional(0.0, 0.0).resolve(Directionality.of(context)),
                                                                                        builder: (dialogContext) {
                                                                                          return Material(
                                                                                            color: Colors.transparent,
                                                                                            child: GestureDetector(
                                                                                              onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
                                                                                              child: EmailWidget(
                                                                                                locations: GetNearbyLocationsCall.locationList(
                                                                                                  (_model.locationsResult?.jsonBody ?? ''),
                                                                                                )!,
                                                                                                query: _model.queryDropdownValue,
                                                                                                location: _model.locationDropdownValue!,
                                                                                                distances: joinLists(
                                                                                                    (CalculateDistanceCall.distance(
                                                                                                      (_model.lFirst25?.jsonBody ?? ''),
                                                                                                    ) as List)
                                                                                                        .map<String>((s) => s.toString())
                                                                                                        .toList()
                                                                                                        ?.toList(),
                                                                                                    (CalculateDistanceCall.distance(
                                                                                                      (_model.lNext25?.jsonBody ?? ''),
                                                                                                    ) as List)
                                                                                                        .map<String>((s) => s.toString())
                                                                                                        .toList()
                                                                                                        ?.toList(),
                                                                                                    (CalculateDistanceCall.distance(
                                                                                                      (_model.lLast25?.jsonBody ?? ''),
                                                                                                    ) as List)
                                                                                                        .map<String>((s) => s.toString())
                                                                                                        .toList()
                                                                                                        ?.toList())!,
                                                                                                distance: _model.sliderRadius2Value!,
                                                                                              ),
                                                                                            ),
                                                                                          );
                                                                                        },
                                                                                      ).then((value) => setState(() {}));

                                                                                      if (_shouldSetState) setState(() {});
                                                                                      return;
                                                                                    } else {
                                                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                                                        SnackBar(
                                                                                          content: Text(
                                                                                            'No content to download, submit location query then try again.',
                                                                                            style: GoogleFonts.getFont(
                                                                                              'Poppins',
                                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                                              fontSize: 16.0,
                                                                                            ),
                                                                                          ),
                                                                                          duration: Duration(milliseconds: 4000),
                                                                                          backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                        ),
                                                                                      );
                                                                                      if (_shouldSetState) setState(() {});
                                                                                      return;
                                                                                    }

                                                                                    if (_shouldSetState) setState(() {});
                                                                                  },
                                                                                ),
                                                                              ),
                                                                              Text(
                                                                                'Download',
                                                                                style: GoogleFonts.getFont(
                                                                                  'Poppins',
                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontSize: 16.0,
                                                                                ),
                                                                              ),
                                                                            ].divide(SizedBox(height: 4.0)),
                                                                          ),
                                                                        Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          children:
                                                                              [
                                                                            FlutterFlowIconButton(
                                                                              borderColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              borderRadius: 8.0,
                                                                              buttonSize: 40.0,
                                                                              fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              icon: Icon(
                                                                                Icons.search,
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                size: 20.0,
                                                                              ),
                                                                              showLoadingIndicator: true,
                                                                              onPressed: () async {
                                                                                var _shouldSetState = false;
                                                                                // Validate Form 1
                                                                                if (_model.formKey1.currentState == null || !_model.formKey1.currentState!.validate()) {
                                                                                  return;
                                                                                }
                                                                                if (_model.queryDropdownValue == null) {
                                                                                  return;
                                                                                }
                                                                                if (_model.locationDropdownValue == null) {
                                                                                  return;
                                                                                }
                                                                                _model.coordinateResult = await GetCoordinatesCall.call(
                                                                                  location: _model.locationDropdownValue,
                                                                                );
                                                                                _shouldSetState = true;
                                                                                if (getJsonField(
                                                                                      (_model.coordinateResult?.jsonBody ?? ''),
                                                                                      r'''$.data''',
                                                                                    ) !=
                                                                                    null) {
                                                                                  _model.locationsIdResult = await GetNearbyLocationsIdCall.call(
                                                                                    radius1: 0,
                                                                                    radius2: toInt(_model.sliderRadius2Value!.toString()),
                                                                                    centerLon: formatCoords(GetCoordinatesCall.lng(
                                                                                      (_model.coordinateResult?.jsonBody ?? ''),
                                                                                    ).toString()),
                                                                                    queryString: _model.queryDropdownValue,
                                                                                    centerLat: formatCoords(GetCoordinatesCall.lat(
                                                                                      (_model.coordinateResult?.jsonBody ?? ''),
                                                                                    ).toString()),
                                                                                  );
                                                                                  _shouldSetState = true;
                                                                                  if ((_model.locationsIdResult?.succeeded ?? true)) {
                                                                                    _model.locationsResult = await GetNearbyLocationsCall.call(
                                                                                      placeIdsList: (GetNearbyLocationsIdCall.iDsList(
                                                                                        (_model.locationsIdResult?.jsonBody ?? ''),
                                                                                      ) as List)
                                                                                          .map<String>((s) => s.toString())
                                                                                          .toList(),
                                                                                      centerCoord: GetNearbyLocationsIdCall.centerCoordinate(
                                                                                        (_model.locationsIdResult?.jsonBody ?? ''),
                                                                                      ).toString(),
                                                                                    );
                                                                                    _shouldSetState = true;
                                                                                    if ((_model.locationsResult?.succeeded ?? true)) {
                                                                                      if (!isListEmpty(GetNearbyLocationsCall.locationList(
                                                                                        (_model.locationsResult?.jsonBody ?? ''),
                                                                                      )!
                                                                                          .toList())) {
                                                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                                                          SnackBar(
                                                                                            content: Text(
                                                                                              'Items ready for download!',
                                                                                              style: GoogleFonts.getFont(
                                                                                                'Poppins',
                                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                                fontSize: 16.0,
                                                                                              ),
                                                                                            ),
                                                                                            duration: Duration(milliseconds: 4000),
                                                                                            backgroundColor: FlutterFlowTheme.of(context).secondary,
                                                                                          ),
                                                                                        );
                                                                                      }
                                                                                      setState(() {
                                                                                        FFAppState().refreshed = false;
                                                                                      });
                                                                                      if (_shouldSetState) setState(() {});
                                                                                      return;
                                                                                    } else {
                                                                                      await showDialog(
                                                                                        context: context,
                                                                                        builder: (alertDialogContext) {
                                                                                          return AlertDialog(
                                                                                            title: Text('Nearby Locations Failed'),
                                                                                            content: Text('Failed to get nearby locations,try again.'),
                                                                                            actions: [
                                                                                              TextButton(
                                                                                                onPressed: () => Navigator.pop(alertDialogContext),
                                                                                                child: Text('Dismiss'),
                                                                                              ),
                                                                                            ],
                                                                                          );
                                                                                        },
                                                                                      );
                                                                                      if (_shouldSetState) setState(() {});
                                                                                      return;
                                                                                    }
                                                                                  } else {
                                                                                    if (_shouldSetState) setState(() {});
                                                                                    return;
                                                                                  }
                                                                                } else {
                                                                                  await showDialog(
                                                                                    context: context,
                                                                                    builder: (alertDialogContext) {
                                                                                      return AlertDialog(
                                                                                        title: Text('Failed'),
                                                                                        content: Text('Could not get location coordinates, try again'),
                                                                                        actions: [
                                                                                          TextButton(
                                                                                            onPressed: () => Navigator.pop(alertDialogContext),
                                                                                            child: Text('Ok'),
                                                                                          ),
                                                                                        ],
                                                                                      );
                                                                                    },
                                                                                  );
                                                                                  if (_shouldSetState) setState(() {});
                                                                                  return;
                                                                                }

                                                                                if (_shouldSetState) setState(() {});
                                                                              },
                                                                            ),
                                                                            Text(
                                                                              'Search',
                                                                              style: GoogleFonts.getFont(
                                                                                'Poppins',
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontSize: 16.0,
                                                                              ),
                                                                            ),
                                                                          ].divide(SizedBox(height: 4.0)),
                                                                        ),
                                                                        Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          children:
                                                                              [
                                                                            FlutterFlowIconButton(
                                                                              borderColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              borderRadius: 8.0,
                                                                              buttonSize: 40.0,
                                                                              fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              icon: Icon(
                                                                                Icons.refresh,
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                size: 20.0,
                                                                              ),
                                                                              showLoadingIndicator: true,
                                                                              onPressed: () async {
                                                                                setState(() {
                                                                                  _model.queryDropdownValueController?.reset();
                                                                                  _model.locationDropdownValueController?.reset();
                                                                                });
                                                                                setState(() {
                                                                                  _model.sliderRadius2Value = 0.0;
                                                                                });
                                                                                setState(() {
                                                                                  FFAppState().refreshed = true;
                                                                                });
                                                                              },
                                                                            ),
                                                                            Text(
                                                                              'Refresh',
                                                                              style: GoogleFonts.getFont(
                                                                                'Poppins',
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontSize: 16.0,
                                                                              ),
                                                                            ),
                                                                          ].divide(SizedBox(height: 4.0)),
                                                                        ),
                                                                      ].divide(SizedBox(width: 8.0)).around(
                                                                              SizedBox(width: 8.0)),
                                                                    ),
                                                                  ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 16.0)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if ((getJsonField(
                                                (_model.locationsResult
                                                        ?.jsonBody ??
                                                    ''),
                                                r'''$.succesful_results''',
                                              ) !=
                                              null) &&
                                          (FFAppState().refreshed != true))
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 12.0, 0.0, 12.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              if (!FFAppState().refreshed)
                                                Text(
                                                  '${listLength(GetNearbyLocationsCall.locationList(
                                                    (_model.locationsResult
                                                            ?.jsonBody ??
                                                        ''),
                                                  )!.toList()).toString()} Results',
                                                  style: GoogleFonts.getFont(
                                                    'Poppins',
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                            ].addToStart(SizedBox(width: 12.0)),
                                          ),
                                        ),
                                      if ((getJsonField(
                                                (_model.locationsResult
                                                        ?.jsonBody ??
                                                    ''),
                                                r'''$.succesful_results''',
                                              ) !=
                                              null) &&
                                          (FFAppState().refreshed != true))
                                        Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.96,
                                          height: 335.0,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFD4FFE6),
                                          ),
                                          child: Builder(
                                            builder: (context) {
                                              final nearbyLocation =
                                                  GetNearbyLocationsCall
                                                          .locationList(
                                                        (_model.locationsResult
                                                                ?.jsonBody ??
                                                            ''),
                                                      )?.toList() ??
                                                      [];
                                              return ListView.builder(
                                                padding: EdgeInsets.zero,
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    nearbyLocation.length,
                                                itemBuilder: (context,
                                                    nearbyLocationIndex) {
                                                  final nearbyLocationItem =
                                                      nearbyLocation[
                                                          nearbyLocationIndex];
                                                  return Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(8.0, 8.0,
                                                                8.0, 8.0),
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        setState(() {
                                                          FFAppState()
                                                                  .location =
                                                              latLngFromLocation(
                                                                  getJsonField(
                                                            nearbyLocationItem,
                                                            r'''$.location_coord''',
                                                          ).toString());
                                                        });
                                                      },
                                                      child: Material(
                                                        color:
                                                            Colors.transparent,
                                                        elevation: 4.0,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        child: Container(
                                                          width: 358.0,
                                                          height: 331.0,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  width: 358.0,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              0.0),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              0.0),
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              8.0),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              8.0),
                                                                    ),
                                                                  ),
                                                                  child: Stack(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            0.0),
                                                                    children: [
                                                                      if (getJsonField(
                                                                            nearbyLocationItem,
                                                                            r'''$.photo_reference''',
                                                                          ) ==
                                                                          'None')
                                                                        Icon(
                                                                          Icons
                                                                              .image_outlined,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).accent1,
                                                                          size:
                                                                              150.0,
                                                                        ),
                                                                      if (getJsonField(
                                                                            nearbyLocationItem,
                                                                            r'''$.photo_reference''',
                                                                          ) !=
                                                                          'None')
                                                                        ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            bottomLeft:
                                                                                Radius.circular(0.0),
                                                                            bottomRight:
                                                                                Radius.circular(0.0),
                                                                            topLeft:
                                                                                Radius.circular(8.0),
                                                                            topRight:
                                                                                Radius.circular(8.0),
                                                                          ),
                                                                          child:
                                                                              CachedNetworkImage(
                                                                            fadeInDuration:
                                                                                Duration(milliseconds: 700),
                                                                            fadeOutDuration:
                                                                                Duration(milliseconds: 700),
                                                                            imageUrl:
                                                                                'https://maps.googleapis.com/maps/api/place/photo?maxwidth=358&photo_reference=${getJsonField(
                                                                              nearbyLocationItem,
                                                                              r'''$.photo_reference''',
                                                                            ).toString()}&key=AIzaSyAsH8omDk8y0lSGLTW9YtZiiQ2MkmsF-uQ',
                                                                            width:
                                                                                358.0,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            4.0,
                                                                            4.0,
                                                                            4.0,
                                                                            4.0),
                                                                child: Text(
                                                                  getJsonField(
                                                                    nearbyLocationItem,
                                                                    r'''$.place_name''',
                                                                  )
                                                                      .toString()
                                                                      .maybeHandleOverflow(
                                                                        maxChars:
                                                                            30,
                                                                        replacement:
                                                                            '…',
                                                                      ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                  style: GoogleFonts
                                                                      .getFont(
                                                                    'Poppins',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        20.0,
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            4.0,
                                                                            4.0,
                                                                            4.0,
                                                                            4.0),
                                                                child: FutureBuilder<
                                                                    ApiCallResponse>(
                                                                  future:
                                                                      CalculateDistanceCall
                                                                          .call(
                                                                    origins:
                                                                        GetNearbyLocationsIdCall
                                                                            .centerCoordinate(
                                                                      (_model.locationsIdResult
                                                                              ?.jsonBody ??
                                                                          ''),
                                                                    ).toString(),
                                                                    destinations:
                                                                        getJsonField(
                                                                      nearbyLocationItem,
                                                                      r'''$.location_coord''',
                                                                    ).toString(),
                                                                  ),
                                                                  builder: (context,
                                                                      snapshot) {
                                                                    // Customize what your widget looks like when it's loading.
                                                                    if (!snapshot
                                                                        .hasData) {
                                                                      return DistancePlaceholderWidget();
                                                                    }
                                                                    final distanceCalculateDistanceResponse =
                                                                        snapshot
                                                                            .data!;
                                                                    return Text(
                                                                      'Driving Distance ${valueOrDefault<String>(
                                                                        getJsonField(
                                                                          distanceCalculateDistanceResponse
                                                                              .jsonBody,
                                                                          r'''$.rows[:].elements[:].distance.text''',
                                                                        ).toString(),
                                                                        'N/A',
                                                                      )}'
                                                                          .maybeHandleOverflow(
                                                                        maxChars:
                                                                            30,
                                                                        replacement:
                                                                            '…',
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      style: GoogleFonts
                                                                          .getFont(
                                                                        'Poppins',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontSize:
                                                                            16.0,
                                                                      ),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            4.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          4.0,
                                                                          0.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .location_on_sharp,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondary,
                                                                        size:
                                                                            20.0,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      getJsonField(
                                                                        nearbyLocationItem,
                                                                        r'''$.address''',
                                                                      )
                                                                          .toString()
                                                                          .maybeHandleOverflow(
                                                                            maxChars:
                                                                                26,
                                                                            replacement:
                                                                                '…',
                                                                          ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start,
                                                                      maxLines:
                                                                          2,
                                                                      style: GoogleFonts
                                                                          .getFont(
                                                                        'Poppins',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontSize:
                                                                            16.0,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            4.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          4.0,
                                                                          0.0),
                                                                      child:
                                                                          FaIcon(
                                                                        FontAwesomeIcons
                                                                            .globe,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondary,
                                                                        size:
                                                                            20.0,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      getJsonField(
                                                                        nearbyLocationItem,
                                                                        r'''$.website''',
                                                                      )
                                                                          .toString()
                                                                          .maybeHandleOverflow(
                                                                            maxChars:
                                                                                26,
                                                                            replacement:
                                                                                '…',
                                                                          ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: GoogleFonts
                                                                          .getFont(
                                                                        'Poppins',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontSize:
                                                                            16.0,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            4.0,
                                                                            0.0,
                                                                            0.0,
                                                                            8.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          4.0,
                                                                          0.0),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .phone_sharp,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondary,
                                                                        size:
                                                                            20.0,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      getJsonField(
                                                                        nearbyLocationItem,
                                                                        r'''$.phone''',
                                                                      )
                                                                          .toString()
                                                                          .maybeHandleOverflow(
                                                                            maxChars:
                                                                                26,
                                                                            replacement:
                                                                                '…',
                                                                          ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: GoogleFonts
                                                                          .getFont(
                                                                        'Poppins',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        fontSize:
                                                                            16.0,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              if (responsiveVisibility(
                context: context,
                tabletLandscape: false,
                desktop: false,
              ))
                Container(
                  width: MediaQuery.sizeOf(context).width * 1.0,
                  height: MediaQuery.sizeOf(context).height * 0.08,
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (FFAppState().refreshed != true)
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Builder(
                              builder: (context) => FlutterFlowIconButton(
                                borderColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                buttonSize: 40.0,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                icon: Icon(
                                  Icons.file_download_outlined,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 20.0,
                                ),
                                showLoadingIndicator: true,
                                onPressed: () async {
                                  if ((getJsonField(
                                            (_model.nearbyLocationResult
                                                    ?.jsonBody ??
                                                ''),
                                            r'''$.succesful_results''',
                                          ) !=
                                          null) &&
                                      (FFAppState().refreshed != true)) {
                                    _model.first25 =
                                        await CalculateDistanceCall.call(
                                      origins: GetNearbyLocationsIdCall
                                          .centerCoordinate(
                                        (_model.placeIdsResult?.jsonBody ?? ''),
                                      ).toString(),
                                      destinations: joinCoords(
                                          (GetNearbyLocationsCall.coordinates(
                                        (_model.nearbyLocationResult
                                                ?.jsonBody ??
                                            ''),
                                      ) as List)
                                              .map<String>((s) => s.toString())
                                              .toList()!
                                              .take(25)
                                              .toList()),
                                    );
                                    _model.next25 =
                                        await CalculateDistanceCall.call(
                                      origins: GetNearbyLocationsIdCall
                                          .centerCoordinate(
                                        (_model.placeIdsResult?.jsonBody ?? ''),
                                      ).toString(),
                                      destinations: joinCoords(sublist(
                                              25,
                                              50,
                                              (GetNearbyLocationsCall
                                                      .coordinates(
                                                (_model.nearbyLocationResult
                                                        ?.jsonBody ??
                                                    ''),
                                              ) as List)
                                                  .map<String>(
                                                      (s) => s.toString())
                                                  .toList()!
                                                  .toList())
                                          .toList()),
                                    );
                                    _model.last5 =
                                        await CalculateDistanceCall.call(
                                      origins: GetNearbyLocationsIdCall
                                          .centerCoordinate(
                                        (_model.placeIdsResult?.jsonBody ?? ''),
                                      ).toString(),
                                      destinations: joinCoords(sublist(
                                              50,
                                              75,
                                              (GetNearbyLocationsCall
                                                      .coordinates(
                                                (_model.nearbyLocationResult
                                                        ?.jsonBody ??
                                                    ''),
                                              ) as List)
                                                  .map<String>(
                                                      (s) => s.toString())
                                                  .toList()!
                                                  .toList())
                                          .toList()),
                                    );
                                    await showAlignedDialog(
                                      context: context,
                                      isGlobal: true,
                                      avoidOverflow: false,
                                      targetAnchor: AlignmentDirectional(
                                              0.0, 0.0)
                                          .resolve(Directionality.of(context)),
                                      followerAnchor: AlignmentDirectional(
                                              0.0, 0.0)
                                          .resolve(Directionality.of(context)),
                                      builder: (dialogContext) {
                                        return Material(
                                          color: Colors.transparent,
                                          child: GestureDetector(
                                            onTap: () => FocusScope.of(context)
                                                .requestFocus(
                                                    _model.unfocusNode),
                                            child: EmailWidget(
                                              locations: GetNearbyLocationsCall
                                                  .locationList(
                                                (_model.nearbyLocationResult
                                                        ?.jsonBody ??
                                                    ''),
                                              )!,
                                              query: _model.sQueryDropdownValue,
                                              location: _model
                                                  .sLocationDropdownValue!,
                                              distances: joinLists(
                                                  (CalculateDistanceCall
                                                          .distance(
                                                    (_model.first25?.jsonBody ??
                                                        ''),
                                                  ) as List)
                                                      .map<String>(
                                                          (s) => s.toString())
                                                      .toList()
                                                      ?.toList(),
                                                  (CalculateDistanceCall
                                                          .distance(
                                                    (_model.next25?.jsonBody ??
                                                        ''),
                                                  ) as List)
                                                      .map<String>(
                                                          (s) => s.toString())
                                                      .toList()
                                                      ?.toList(),
                                                  (CalculateDistanceCall
                                                          .distance(
                                                    (_model.last5?.jsonBody ??
                                                        ''),
                                                  ) as List)
                                                      .map<String>(
                                                          (s) => s.toString())
                                                      .toList()
                                                      ?.toList())!,
                                              distance:
                                                  _model.sSliderRadiusValue!,
                                            ),
                                          ),
                                        );
                                      },
                                    ).then((value) => setState(() {}));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'No content to download, submit location query then try again.',
                                          style: GoogleFonts.getFont(
                                            'Poppins',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        duration: Duration(milliseconds: 4000),
                                        backgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                      ),
                                    );
                                  }

                                  setState(() {});
                                },
                              ),
                            ),
                            Text(
                              'Download',
                              style: GoogleFonts.getFont(
                                'Poppins',
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                fontWeight: FontWeight.w500,
                                fontSize: 13.0,
                              ),
                            ),
                          ],
                        ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FlutterFlowIconButton(
                            borderColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: 30.0,
                            buttonSize: 40.0,
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            icon: Icon(
                              Icons.refresh_outlined,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 20.0,
                            ),
                            onPressed: () async {
                              setState(() {
                                _model.sQueryDropdownValueController?.reset();
                                _model.sLocationDropdownValueController
                                    ?.reset();
                              });
                              setState(() {
                                _model.sSliderRadiusValue = 0.0;
                              });
                              setState(() {
                                FFAppState().refreshed = true;
                                FFAppState().location = null;
                              });
                            },
                          ),
                          Text(
                            'Refresh',
                            style: GoogleFonts.getFont(
                              'Poppins',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FlutterFlowIconButton(
                            borderColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: 20.0,
                            borderWidth: 0.0,
                            buttonSize: 40.0,
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            icon: Icon(
                              Icons.search_sharp,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 20.0,
                            ),
                            showLoadingIndicator: true,
                            onPressed: () async {
                              // Validate Form 1
                              if (_model.formKey2.currentState == null ||
                                  !_model.formKey2.currentState!.validate()) {
                                return;
                              }
                              if (_model.sQueryDropdownValue == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Select the query to proceed',
                                      style: GoogleFonts.getFont(
                                        'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).secondary,
                                  ),
                                );
                                return;
                              }
                              if (_model.sLocationDropdownValue == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Choose the location to proceed',
                                      style: GoogleFonts.getFont(
                                        'Poppins',
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context).secondary,
                                  ),
                                );
                                return;
                              }
                              _model.locationCoordinateResult =
                                  await GetCoordinatesCall.call(
                                location: _model.sLocationDropdownValue,
                              );
                              if (getJsonField(
                                    (_model.locationCoordinateResult
                                            ?.jsonBody ??
                                        ''),
                                    r'''$.data''',
                                  ) !=
                                  null) {
                                _model.placeIdsResult =
                                    await GetNearbyLocationsIdCall.call(
                                  radius1: 0,
                                  radius2: toInt(
                                      _model.sSliderRadiusValue!.toString()),
                                  centerLon: formatLng(GetCoordinatesCall.lng(
                                    (_model.locationCoordinateResult
                                            ?.jsonBody ??
                                        ''),
                                  ).toString()),
                                  queryString: _model.sQueryDropdownValue,
                                  centerLat:
                                      formatCoords(GetCoordinatesCall.lat(
                                    (_model.locationCoordinateResult
                                            ?.jsonBody ??
                                        ''),
                                  ).toString()),
                                );
                                if ((_model.placeIdsResult?.succeeded ??
                                    true)) {
                                  _model.nearbyLocationResult =
                                      await GetNearbyLocationsCall.call(
                                    placeIdsList:
                                        (GetNearbyLocationsIdCall.iDsList(
                                      (_model.placeIdsResult?.jsonBody ?? ''),
                                    ) as List)
                                            .map<String>((s) => s.toString())
                                            .toList(),
                                    centerCoord: GetNearbyLocationsIdCall
                                        .centerCoordinate(
                                      (_model.placeIdsResult?.jsonBody ?? ''),
                                    ).toString(),
                                  );
                                  if ((_model.nearbyLocationResult?.succeeded ??
                                      true)) {
                                    if (!isListEmpty(
                                        GetNearbyLocationsCall.locationList(
                                      (_model.nearbyLocationResult?.jsonBody ??
                                          ''),
                                    )!
                                            .toList())) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Items ready for download!',
                                            style: GoogleFonts.getFont(
                                              'Poppins',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                          duration:
                                              Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondary,
                                        ),
                                      );
                                    }
                                    setState(() {
                                      FFAppState().refreshed = false;
                                    });
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'No',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 4000),
                                      backgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .secondary,
                                    ),
                                  );
                                }
                              } else {
                                await showDialog(
                                  context: context,
                                  builder: (alertDialogContext) {
                                    return AlertDialog(
                                      title: Text('Failed'),
                                      content: Text(
                                          'Could not get location coordinates, try again'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(alertDialogContext),
                                          child: Text('Ok'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }

                              setState(() {});
                            },
                          ),
                          Text(
                            'Search',
                            style: GoogleFonts.getFont(
                              'Poppins',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              fontWeight: FontWeight.w500,
                              fontSize: 13.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class SplashscreenModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}

class SplashscreenWidget extends StatefulWidget {
  const SplashscreenWidget({Key? key}) : super(key: key);

  @override
  _SplashscreenWidgetState createState() => _SplashscreenWidgetState();
}

class _SplashscreenWidgetState extends State<SplashscreenWidget>
    with TickerProviderStateMixin {
  late SplashscreenModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'containerOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeIn,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SplashscreenModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 4000));

      context.goNamed('NearbyLocations');
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(_model.unfocusNode),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFF3BB06C),
        body: SafeArea(
          top: true,
          child: Container(
            width: MediaQuery.sizeOf(context).width * 1.0,
            height: MediaQuery.sizeOf(context).height * 1.0,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondary,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: Image.asset(
                  'assets/images/9267_[Converted]-01_1.png',
                ).image,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/Group_1.png',
                  width: MediaQuery.sizeOf(context).width * 0.2,
                  fit: BoxFit.cover,
                ),
                Text(
                  'Search in UX Living Lab',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    fontWeight: FontWeight.w600,
                    fontSize: 24.0,
                  ),
                ),
              ],
            ),
          ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!),
        ),
      ),
    );
  }
}
