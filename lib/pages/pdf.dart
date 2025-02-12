import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';
import 'package:tandaterima/providers/recipt_provider.dart';

// Fungsi buat generate PDF dan return file dalam bentuk Uint8List
Future<Uint8List> generatePDF(
    BuildContext context, PdfPageFormat format) async {
  final pdf = pw.Document();
  final dataProvider = Provider.of<InventoryProvider>(context, listen: false);
  final dateAndTitle = Provider.of<DateProvider>(context, listen: false);
  pdf.addPage(
    pw.MultiPage(build: (pw.Context context) {
      return [
        pw.Padding(
          padding: const pw.EdgeInsets.all(10.0),
          child: pw.Column(children: [
            _BuildMenu(
              dataProvider.rows,
              PdfColors.green,
              'Menyerahkan',
              dateAndTitle.title,
              dateAndTitle.getFormatedDate(),
              dateAndTitle.unYtkMenerima,
              dateAndTitle.unYtkMenyerahkan
            ),
            pw.SizedBox(
              height: 20,
            ),
            pw.Divider(
              height: 10,
            ),
            pw.SizedBox(
              height: 20,
            ),
            _BuildMenu(
                dataProvider.rows,
                PdfColors.amber,
                'Menerima',
                dateAndTitle.title,
                dateAndTitle.getFormatedDate(),
                dateAndTitle.unYtkMenerima,
                dateAndTitle.unYtkMenyerahkan
                
                )
          ]),
        ),
      ];
    }),
  );
  return await pdf.save();
}

pw.Widget _BuildMenu(List<InventoryRow> 
    rows,
    PdfColor color,
    String yangApa,
    String title,
    String date,
    String untukMenerima,
    String? untukMenyerahkan,
    ) {
  return pw.Padding(
    padding: const pw.EdgeInsets.all(8.0),
    child:
        pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.center, children: [
        pw.Table(
            border: pw.TableBorder.all(width: 1),
          children: [
            pw.TableRow(children: [
              pw.Padding(padding: pw.EdgeInsets.all(20.0),
              child: pw.Column(children: [
                  pw.Text('Tanda Terima $title'),
      pw.SizedBox(height: 10),
      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
        pw.Text('Tanggal : $date'),
      ]),
      pw.SizedBox(height: 10), // row
      pw.Table(border: pw.TableBorder.all(), children: [
        pw.TableRow(decoration: pw.BoxDecoration(color: color), children: [
          pw.Padding(
            padding: pw.EdgeInsets.all(
              8.0
              
            ),
            child: pw.Text('No', textAlign: pw.TextAlign.center),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(8.0),
            child: pw.Text('Nama Barang', textAlign: pw.TextAlign.center),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(8.0),
            child: pw.Text('Merek', textAlign: pw.TextAlign.center),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(8.0),
            child: pw.Text('Type', textAlign: pw.TextAlign.center),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(8.0),
            child: pw.Text('Jumlah', textAlign: pw.TextAlign.center),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(8.0),
            child: pw.Text('Keterangan', textAlign: pw.TextAlign.center),
          ),
        ]),

        //ini adalah table yang bisa di tambah
        ...rows.map((row) => pw.TableRow(children: [
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 8.0),
                child: pw.Text(row.no,textAlign: pw.TextAlign.center),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(8.0),
                child: pw.Text(row.namaInventaris,textAlign: pw.TextAlign.center),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(8.0),
                child: pw.Text(row.merek,textAlign: pw.TextAlign.center),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(8.0),
                child: pw.Text(row.type,textAlign: pw.TextAlign.center),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(8.0),
                child: pw.Text(row.jumlah,textAlign: pw.TextAlign.center),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.all(8.0),
                child: pw.Text(row.keterangan,textAlign: pw.TextAlign.center),
              ),
            ]))
      ]),
      pw.SizedBox(
        height: 15,
      ),
      pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
          children: [pw.Text('Yang Menerima'), pw.Text('Yang Menyerahkan')]),
      pw.SizedBox(
        height: 50,
      ),
      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly, children: [
        pw.Text('$untukMenerima'),
        pw.Text('$untukMenyerahkan'),
      ]),
      pw.SizedBox(
        height: 10,
      ),
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(' Untuk Yang $yangApa *'),
        ],
      ),
    
              ]),
              )
              
            ])
          ]
          ),
    ]),
  );
}
