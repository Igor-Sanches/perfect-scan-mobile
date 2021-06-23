class Email
{

  static bool Validor(String id)
  {
    String codigo = id;
    if (codigo.startsWith("mailto:") || codigo.startsWith("MAILTO:"))
    {
      if (codigo.contains("@") && !codigo.contains("/") || codigo.contains("@") && !codigo.contains(" "))
      {
        var aar = codigo.split("@");
        String number = aar[0];
        if (codigo.substring(number.length + 1).contains("@") || codigo.substring(number.length + 1).contains(","))
        {
          return false;
        }

        if (aar[1].contains("."))
        {
          return aar[1].endsWith(".") || aar[1].startsWith(".") || aar[1].contains(",") || aar[1].contains(" ");
        }
        else {
          return false;
        }
      }
      return false;
    }
    else if (codigo.contains("@") && !codigo.contains(":"))
    {
      var aar = codigo.split("@");
      String number = aar[0];
      if (codigo.substring(number.length + 1).contains("@") || codigo.substring(number.length + 1).contains(",") || codigo.substring(number.length + 1).contains(" "))
      {
        return false;
      }

      if (aar[1].contains("."))
      {
        return aar[1].endsWith(".") || aar[1].startsWith(".") || aar[1].contains(",");
      }
      else {
        return false;
      }
    }
    else {
      return false;
    }
  }
}