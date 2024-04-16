import 'package:atelieoliveira/src/common/progress_bar.dart';
import 'package:atelieoliveira/src/data/model/magazine_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MagazineDetailView extends StatefulWidget {
  const MagazineDetailView({
    super.key,
  });

  static const routeName = '/details';

  @override
  State<StatefulWidget> createState() {
    return _MagazineDetailView();
  }
}

class _MagazineDetailView extends State<MagazineDetailView>
    with TickerProviderStateMixin {
  String urlPDFPath = "";
  bool exists = true;
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  late PDFViewController _pdfViewController;
  bool loaded = false;
  EditionModel? edition;

  Future<File> getFileFromUrl(String url, {name}) async {
    var fileName = 'testonline';
    if (name != null) {
      fileName = name;
    }
    try {
      var uriFromUrl = Uri.parse(url);
      var data = await http.get(uriFromUrl);
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$fileName.pdf");
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception(e);
    }
  }

  void requestPersmission() async {
    const permission = Permission.storage;

    if (await permission.isDenied) {
      await permission.request();
    }
  }

  @override
  void initState() {
    requestPersmission();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      edition = EditionModel.fromJson(
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>);
      getFileFromUrl(edition!.pdf).then(
        (value) => {
          setState(() {
            urlPDFPath = value.path;
            loaded = true;
            exists = true;
          }),
        },
        onError: (error) {
          exists = false;
        },
      );
    });

    super.initState();
  }

  Widget pdfView() {
    return PDFView(
      filePath: urlPDFPath,
      autoSpacing: true,
      enableSwipe: true,
      pageSnap: true,
      swipeHorizontal: true,
      nightMode: false,
      onError: (e) {
        //Show some error message or UI
      },
      onRender: (pages) {
        setState(() {
          _totalPages = pages!;
          pdfReady = true;
        });
      },
      onViewCreated: (PDFViewController vc) {
        setState(() {
          _pdfViewController = vc;
        });
      },
      onPageChanged: (int? page, int? total) {
        setState(() {
          _currentPage = page!;
        });
      },
      onPageError: (page, e) {},
    );
  }

  Widget fab() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.chevron_left),
          iconSize: 50,
          color: Colors.black,
          onPressed: () {
            setState(() {
              if (_currentPage > 0) {
                _currentPage--;
                _pdfViewController.setPage(_currentPage);
              }
            });
          },
        ),
        Text(
          "${_currentPage + 1}/$_totalPages",
          style: const TextStyle(color: Colors.black, fontSize: 20),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          iconSize: 50,
          color: Colors.black,
          onPressed: () {
            setState(() {
              if (_currentPage < _totalPages - 1) {
                _currentPage++;
                _pdfViewController.setPage(_currentPage);
              }
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String title = edition == null ? "TItulo" : edition!.title;
    if (loaded) {
      return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: pdfView(),
        floatingActionButton: fab(),
      );
    } else {
      if (exists) {
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: const Center(
            child: Column(
              children: [
                SizedBox(
                  height: 32,
                ),
                Text(
                  "Carregando sua revista",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 16,
                ),
                CircularProgressIndicator(),
              ],
            ),
          ),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: const Text(
            "Não foi possível encontrar o PFD, por favor tente mais tarde",
            style: TextStyle(fontSize: 20),
          ),
        );
      }
    }
  }
}
