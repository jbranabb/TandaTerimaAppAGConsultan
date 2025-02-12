  import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
  import 'package:printing/printing.dart';
  import 'package:tandaterima/pages/pdf.dart';
  import 'dart:io';
  import 'dart:typed_data';
  import 'package:open_file/open_file.dart';
  import 'package:pdf/pdf.dart';
  import 'package:permission_handler/permission_handler.dart';
  import 'package:provider/provider.dart';
  import 'package:tandaterima/providers/recipt_provider.dart';


  class PDFViewerPage extends StatefulWidget {
    const PDFViewerPage({super.key});

    @override
    State<PDFViewerPage> createState() => _PDFViewerPageState();
  }

  class _PDFViewerPageState extends State<PDFViewerPage> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Preview PDF'),
          actions: [
            IconButton(onPressed: () {savePDFToFile(context);}, icon: Icon(Icons.save))
          ],
        ),
          
        body: PdfPreview(
          allowPrinting: true,
          allowSharing: true,
          canDebug: false,
          shouldRepaint: false,
          canChangeOrientation: true,
          canChangePageFormat: true,
          useActions: true,
          build: (format) {
            if(format.height > format.width){
          return generatePDF(context,PdfPageFormat.a4);
            } else{
          return generatePDF(context,PdfPageFormat.a4.landscape);
            }
          }
        ),
      );
    }
  }
  Future<void> savePDFToFile(BuildContext context) async {
    
    final dataProvider = Provider.of<DateProvider>(context,listen: false);
    String pdfNameFile = 'Tanda Terima ${dataProvider.unYtkMenerima}.pdf';
    try {

      Uint8List bytes = await generatePDF(context, PdfPageFormat.a4 );

      // Minta izin akses penyimpanan dulu
      if (await Permission.storage.request().isGranted) {
        // Ambil direktori Download
      final directory = await getExternalStorageDirectory();
      final file = File('${directory!.path}/${pdfNameFile}');

        // Simpan file PDF 
        await file.writeAsBytes(bytes);

        OpenFile.open(file.path);


        print('📂 PDF berhasil disimpan di: $file');
      } else {
        print('🚫 Izin penyimpanan ditolak!');
      }
    } catch (e) {
      print('❌ Error menyimpan PDF: $e');
    }
  }

  Future<void> requestStoragePermission() async {
  PermissionStatus status = await Permission.storage.request();

  if (status.isGranted) {
    print("Izin diberikan");
  } else if (status.isDenied) {
    print("Izin ditolak");
  } else if (status.isPermanentlyDenied) {
    print("Izin secara permanen ditolak");
    openAppSettings();
  }
}