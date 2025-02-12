import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InventoryRow with ChangeNotifier{
  String no;
  DateTime tanggal = DateTime.now();
  String namaInventaris;
  String merek;
  String type;
  String jumlah;
  String keterangan;

  InventoryRow({
   required this.no,
   required this.namaInventaris,
   required this.merek,
   required this.type,
   required this.jumlah,
   required this.keterangan
  });
InventoryRow.empty()
      : no = '1',
        tanggal = DateTime.now(),
        namaInventaris = '',
        merek = '',
        type = '',
        jumlah = '',
        keterangan = '';


  // list untuk simpan semua row
   InventoryRow copyWith({
    String? no,
    String? namaInventaris,
    String? merek,
    String? type,
    String? jumlah,
    String? keterangan,
  }) {
    return InventoryRow(
      no: no ?? this.no,
      namaInventaris: namaInventaris ?? this.namaInventaris,
      merek: merek ?? this.merek,
      type: type ?? this.type,
      jumlah: jumlah ?? this.jumlah,
      keterangan: keterangan ?? this.keterangan,
    );
  } 
  }

  class DateProvider with ChangeNotifier{
  DateTime tanggal = DateTime.now();
  String title = '';
  String unYtkMenyerahkan = '';
  String unYtkMenerima = '';

  void updateVoucher(
      {
      required String title,
      required String unYtkMenyerahkan,
      required String unYtkMenerima,
      }) {
    this.title = title;
    this.unYtkMenerima = unYtkMenerima;
    this.unYtkMenyerahkan = unYtkMenyerahkan;
    notifyListeners();
  }


  String getFormatedDate(){
    return DateFormat('dd-MM-yyyy').format(tanggal);
  }
  }

class InventoryProvider with ChangeNotifier{
  final List<InventoryRow> _rows = [InventoryRow.empty()];

  List<InventoryRow> get rows => _rows;


  void addRows(){
    _rows.add(InventoryRow(
      no: (_rows.length + 1).toString(),
      namaInventaris: '',
      merek: '',
      type: '',
      jumlah: '',
      keterangan:  '',
    ));
    notifyListeners();
  }

  void updateData(int index, InventoryRow newRow){
    if(index < _rows.length){
      _rows[index] = newRow;
      notifyListeners();
    }
  }
    void deleteRow(int index) {
    if (index < _rows.length) {
      _rows.removeAt(index);
      for(int i = index; i < _rows.length; i++){
        _rows[i] = _rows[i].copyWith(no: (i + 1).toString());
      }
      notifyListeners();
    }
  }
  void deleteLastRow() {
    if (_rows.length > 1) { 
      _rows.removeLast();
      notifyListeners();
    }
}
}