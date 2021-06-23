import 'package:qr_code_scanner/qr_code_scanner.dart' as camerabarcode;
import 'package:zxing2/src/barcode_format.dart' as imagebarcode;

class Tools{
  static String getType({imagebarcode.BarcodeFormat? imagemEscaneamento, camerabarcode.BarcodeFormat? cameraEscaneamento}) {
    String? formato;
    switch(imagemEscaneamento ?? cameraEscaneamento){
      case camerabarcode.BarcodeFormat.aztec:
      case imagebarcode.BarcodeFormat.aztec:
        formato = 'AZTEC';
        break;
      case camerabarcode.BarcodeFormat.codabar:
      case imagebarcode.BarcodeFormat.codabar:
        formato = 'Código de barras';
        break;
      case camerabarcode.BarcodeFormat.code39:
      case imagebarcode.BarcodeFormat.code39:
        formato = 'Código de barras 39';
        break;
      case camerabarcode.BarcodeFormat.code93:
      case imagebarcode.BarcodeFormat.code93:
        formato = 'Código de barras 93';
        break;
      case camerabarcode.BarcodeFormat.code128:
      case imagebarcode.BarcodeFormat.code128:
        formato = 'Código de barras 128';
        break;
      case camerabarcode.BarcodeFormat.dataMatrix:
      case imagebarcode.BarcodeFormat.dataMatrix:
        formato = 'Código Data Matrix';
        break;
      case camerabarcode.BarcodeFormat.ean8:
      case imagebarcode.BarcodeFormat.ean8:
        formato = 'Código EAN-8';
        break;
      case camerabarcode.BarcodeFormat.ean13:
      case imagebarcode.BarcodeFormat.ean13:
        formato = 'Código EAN-13';
        break;
      case camerabarcode.BarcodeFormat.itf:
      case imagebarcode.BarcodeFormat.itf:
        formato = 'Código ITF';
        break;
      case camerabarcode.BarcodeFormat.maxicode:
      case imagebarcode.BarcodeFormat.maxicode:
        formato = 'Código Maxicode';
        break;
      case camerabarcode.BarcodeFormat.pdf417:
      case imagebarcode.BarcodeFormat.pdf417:
        formato = 'Código PDF 417';
        break;
      case camerabarcode.BarcodeFormat.qrcode:
      case imagebarcode.BarcodeFormat.qrCode:
        formato = 'Código Qr';
        break;
      case camerabarcode.BarcodeFormat.rss14:
      case imagebarcode.BarcodeFormat.rss14:
        formato = 'Código RSS-14';
        break;
      case camerabarcode.BarcodeFormat.rssExpanded:
      case imagebarcode.BarcodeFormat.rssExpanded:
        formato = 'Código RSS-Expanded';
        break;
      case camerabarcode.BarcodeFormat.upcA:
      case imagebarcode.BarcodeFormat.upcA:
        formato = 'Código UPC-A';
        break;
      case camerabarcode.BarcodeFormat.upcE:
      case imagebarcode.BarcodeFormat.upcE:
        formato = 'Código UPC-E';
        break;
      case camerabarcode.BarcodeFormat.upcEanExtension:
      case imagebarcode.BarcodeFormat.upcEanExtension:
        formato = 'Código UPC-EAN Extension';
        break;
    }
    return formato!;
  }

  static getFormato({imagebarcode.BarcodeFormat? imagemEscaneamento, camerabarcode.BarcodeFormat? cameraEscaneamento}) {
    String barcodeFormat = imagemEscaneamento == null ? cameraEscaneamento.toString() : imagemEscaneamento.toString();
    return barcodeFormat.replaceAll('BarcodeFormat.', '').toLowerCase();
  }
}