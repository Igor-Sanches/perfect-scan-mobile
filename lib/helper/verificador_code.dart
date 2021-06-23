import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';

import 'email_validor.dart';

class FindCode{
  static String GetResultado({required String codigo, required String format})
  {
    CodigoFind codeType = CodigoFind.texto;
    if (Verificador.verificar(codigo: codigo)!.isEMAIL)
    {
      codeType = CodigoFind.email;
    }
    else if (Verificador.verificar(codigo: codigo)!.isWhatsApp)
    {
      codeType = CodigoFind.whatsapp;
    }
    else if (Verificador.verificar(codigo: codigo)!.isContato)
    {
      codeType = CodigoFind.contato;
    }
    else if (Verificador.verificar(codigo: codigo)!.isNumeroTelefone)
    {
      codeType = CodigoFind.numero;
    }
    else if (Verificador.verificar(codigo: codigo)!.isAppAndroid)
    {
      codeType = CodigoFind.appAndroid;
    }
    else if (Verificador.verificar(codigo: codigo)!.isAppWindows)
    {
      codeType = CodigoFind.appWindows;
    }
    else if (Verificador.verificar(codigo: codigo)!.isWIFI)
    {
      codeType = CodigoFind.wifi;
    }
    else if (Verificador.verificar(codigo: codigo, formato: format)!.isProduto)
    {
      codeType = CodigoFind.produto;
    }
    else if (Verificador.verificar(codigo: codigo)!.isSMS)
    {
      codeType = CodigoFind.sms;
    }
    else if (Verificador.verificar(codigo: codigo)!.isUri)
    {
      codeType = CodigoFind.url;
    }
    else
    {
      codeType = CodigoFind.texto;
    }
    return codeType.toString().replaceAll('CodigoFind.', '');
  }

}

enum CodigoFind {
  texto, url, sms, produto, wifi, appWindows, appAndroid, numero, contato, whatsapp, email
}

class Verificador{
  static String? _codigo, _formato;

  static getIcone(String tipo){
    String result = '';
    switch(tipo.replaceAll('CodigoFind.', '')){
      case 'texto':
        result = 'assets/icons/texto.png';
        break;
      case 'url':
        result = 'assets/icons/url.png';
        break;
      case 'sms':
        result = 'assets/icons/sms.png';
        break;
      case 'produto':
        result = 'assets/icons/protudos.png';
        break;
      case 'wifi':
        result = 'assets/icons/wifi.png';
        break;
      case 'appWindows':
        result = 'assets/icons/appwindows.png';
        break;
      case 'appAndroid':
        result = 'assets/icons/googleplay.png';
        break;
      case 'numero':
        result = 'assets/icons/numero.png';
        break;
      case 'contato':
        result = 'assets/icons/contato.png';
        break;
      case 'whatsapp':
        result = 'assets/icons/whatsapp.png';
        break;
      case 'email':
        result = 'assets/icons/email.png';
        break;
    }
    return result;
  }

  static getTipo(String tipo){
    String result = '';
    switch(tipo.replaceAll('CodigoFind.', '')){
      case 'texto':
        result = 'Texto';
        break;
      case 'url':
        result = 'Url';
        break;
      case 'sms':
        result = 'SMS';
        break;
      case 'produto':
        result = 'Produto';
        break;
      case 'wifi':
        result = 'WI-FI';
        break;
      case 'appWindows':
        result = 'App Windows';
        break;
      case 'appAndroid':
        result = 'App Android';
        break;
      case 'numero':
        result = 'Número';
        break;
      case 'contato':
        result = 'Contato';
        break;
      case 'whatsapp':
        result = 'WhatsApp';
        break;
      case 'email':
        result = 'E-Mail';
        break;
    }
    return result;
  }

  static Verificador? verificar({required String codigo, String? formato}){
    return Verificador(codigo: codigo, formato: formato);  }

  Verificador({required String codigo, String? formato}){
    _codigo = codigo;
    _formato = formato;
  }

  bool get isContato {
    if (_codigo!.startsWith("MECARD:") || _codigo!.startsWith("BEGIN:VCARD"))
    {
      return _codigo!.contains("N") || _codigo!.contains("TEL");
    }
    else { return false; }
  }

  bool get isNumeroTelefone {
    if (_codigo!.startsWith("tel:") || _codigo!.startsWith("TEL:"))
    {

      String formatado = _codigo!.replaceAll("tel:", "").replaceAll("TEL:", "").replaceAll("+", "").replaceAll("(", "").replaceAll(")", "").replaceAll(" ", "").replaceAll("-", "");
      final phone = FlutterLibphonenumber().formatNumberSync(formatado);
      int numero = phone.length;
      if (numero < 8) return false;
      else if (numero > 16) return false;
      else
      {
        return true;
      }
    }
    return false;
  }

  bool get isWhatsApp {
    if(_codigo!.startsWith('http://') || _codigo!.startsWith('https://')){
      return _codigo!.contains("api.whatsapp.com") || _codigo!.contains("wa.me/") || _codigo!.contains("v.whatsapp.com") || _codigo!.contains("chat.whatsapp.com");
    }else {
      return false;
    }
  }

  bool get isAppAndroid => _codigo!.contains("play.google.com") || _codigo!.contains("market://") ||_codigo!.contains("market.android.com");

  bool get isAppWindows => _codigo!.contains("https://www.microsoft.com/store/productId")
  || _codigo!.contains("ms-windows-store://pdp/?ProductId=")
  || _codigo!.contains("ms-windows-store://pdp/?PFM=")
  || _codigo!.contains("ms-windows-store://pdp/?PhoneAppId=")
  || _codigo!.contains("ms-windows-store://pdp/?AppId=")
  || _codigo!.contains("https://www.microsoft.com/store/");

  bool get isWIFI {
    if (_codigo!.startsWith("WIFI:") || _codigo!.startsWith("wifi:")) {
      if (_codigo!.contains(";")) {
        return true;
      }
      else {
        return false;
      }
    }
    else {
      return false;
    }
  }

  bool get isProduto {
    bool pass = false;
    RegExp regex = RegExp("[^\d]");
    String produto = _codigo!;
    RegExp singaLetra = RegExp("[A-Z]+");
    if (_formato == "UPC_A" || _formato == "UPC_E" || _formato == "EAN_8" || _formato == "EAN_13")
    {
      if (regex.stringMatch(produto) != null)
      {
        pass = regex.stringMatch(produto)!.length == produto.length;
      }
    }
    if(produto.startsWith("package:") || produto.length == 13 || produto.length == 16 || produto.length == 18)
    {
      String formatado = "";
      if (produto.startsWith("package:")) {
        formatado = produto.replaceAll("package:", "");
      } else {
        formatado = produto;
      }


      int count = formatado.length;
      if (count == 13)
      {
        if (formatado.startsWith("SYBAA") || formatado.startsWith("SYBAB"))
        {
          String num = formatado.substring(5, 8);
          if (regex.stringMatch(num) != null)
          {
            pass = regex.stringMatch(num)!.length == num.length;
          }
        }
        else if (formatado.startsWith("SY"))
        {
          String num = formatado.substring(2, 11);
          if (regex.stringMatch(num) != null)
          {
            pass = regex.stringMatch(num)!.length == num.length;
          }
          else
          {
            String fim = formatado.substring(11, 2);
            String fim1 = formatado.substring(0, 1);
            String fim2 = formatado.substring(1, 1);
            if (singaLetra.stringMatch(fim1) != null && singaLetra.stringMatch(fim2) != null)
            {
              if(singaLetra.stringMatch(fim1)!.length == num.length && singaLetra.stringMatch(fim2)!.length == num.length){
                String center = formatado.substring(2, 9);
                if(regex.stringMatch(center) != null){
                  pass = regex.stringMatch(center)!.length == center.length;
                }
              }
            }
          }

        }
        else
        {
          String a1 = formatado.substring(0, 1);
          String a2 = formatado.substring(1, 1);
          if (singaLetra.stringMatch(a1) != null && singaLetra.stringMatch(a2) != null)
          {
            if(singaLetra.stringMatch(a1)!.length == a1.length && singaLetra.stringMatch(a2)!.length == a2.length){
              String b = formatado.substring(2, 9);
              if(regex.stringMatch(b) != null){
                if(regex.stringMatch(b)!.length == b.length){
                  String c = formatado.substring(11, 2);
                  String c1 = c.substring(0, 1);
                  String c2 = c.substring(1, 1);
                  if(singaLetra.stringMatch(c1) != null && singaLetra.stringMatch(c2) != null){
                    pass = singaLetra.stringMatch(c1)!.length == c1.length && singaLetra.stringMatch(c2)!.length == c2.length;
                  }
                }
              }
            }
          }
        }
      }
      else if (count == 18)
      {
        if (formatado.startsWith("YT"))
        {
          String num = formatado.substring(2, 16);
          if(regex.stringMatch(num) != null){
            pass = regex.stringMatch(num)!.length == num.length;
          }
        }
      }
      else if(count == 16)
      {
        if (formatado.startsWith("LP"))
        {
          String num = formatado.substring(2, 16);
          if(regex.stringMatch(num) != null){
            pass = regex.stringMatch(num)!.length == num.length;
          }
        }
      }

    }
    return pass;

  }

  bool get isEMAIL => Email.Validor(_codigo!);

  bool get isSMS => _codigo!.startsWith("smsto:") || _codigo!.startsWith("SMSTO:");

  bool get isUri{
    if (_codigo!.startsWith("http://") || _codigo!.startsWith("https://"))
    {
      if (_codigo!.contains(" ")) {
        return false;
      } else
      {
        if (!_codigo!.endsWith("."))
        {
          return true;
        }
        else {
          return false;
        }
      }
    }
    else if (_codigo!.startsWith("URL:") || _codigo!.startsWith("URI:"))
    {
      return true;
    }
    if (!isBasicValueURI || isPossibleURI)
    {
      return false;
    }
    else return false;

  }

  bool get isPossibleURI
  {
    RegExp ALLOWE = RegExp("[-._~:/?\\[\\]@!\$&'()*+,;=Aa-z0-9]+");
    if(ALLOWE.stringMatch(_codigo!) != null){
       return ALLOWE.stringMatch(_codigo!)!.length == _codigo!.length;
    }else{
      return false;
    }
  }

  bool get isBasicValueURI
  {
    if (_codigo!.contains(" "))
    {
      return false;
    }

    return true;
  }
}