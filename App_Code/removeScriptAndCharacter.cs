using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text.RegularExpressions;
using System.Net;
using System.Net.Sockets;

public static class removeScriptAndCharacter
{

    public static string GetLocalIPAddress()
    {
        var host = Dns.GetHostEntry(Dns.GetHostName());
        foreach (var ip in host.AddressList)
        {
            if (ip.AddressFamily == AddressFamily.InterNetwork)
            {
                return ip.ToString();
            }
        }
        throw new Exception("Local IP Address Not Found!");
    }
    // xoa html
    public static string StripTagsRegex(string source)
    {
        return Regex.Replace(source, "<.*?>", string.Empty);
    }
    static Regex _htmlRegex = new Regex("<.*?>", RegexOptions.Compiled);

    public static string StripTagsRegexCompiled(string source)
    {
        return _htmlRegex.Replace(source, string.Empty);
    }
    public static string StripTagsCharArray(string source)
    {
        char[] array = new char[source.Length];
        int arrayIndex = 0;
        bool inside = false;

        for (int i = 0; i < source.Length; i++)
        {
            char let = source[i];
            if (let == '<')
            {
                inside = true;
                continue;
            }
            if (let == '>')
            {
                inside = false;
                continue;
            }
            if (!inside)
            {
                array[arrayIndex] = let;
                arrayIndex++;
            }
        }
        return new string(array, 0, arrayIndex);
    }

    // xoa the script
    public static string replateScript(string source)
    {
        return Regex.Replace(source, "<script.*?</script>", "", RegexOptions.Singleline | RegexOptions.IgnoreCase);
    }

    // xoa the script va ky tu dac biet
    public static string formatTextInput(string source)
    {
        string temp = source;

        temp = Regex.Replace(temp, "<script.*?</script>", "", RegexOptions.Singleline | RegexOptions.IgnoreCase);

        List<string> lst = new List<string>() { "/web.xml", "win.ini", "etc/passwd", "%c0%ae/", "Injection", "master.dbo", "declare @", "select.*?from", "{applicationScope}", "script", "window.location", };
        foreach (var item in lst)
        {
            temp = Regex.Replace(temp, item, "", RegexOptions.Singleline | RegexOptions.IgnoreCase);
        }
        temp = Regex.Replace(
        temp,
        @"(<[\s\S]*?) on.*?\=(['""])[\s\S]*?\2([\s\S]*?>)",
        delegate(Match match)
        {
            return String.Concat(match.Groups[1].Value, match.Groups[3].Value);
        }, RegexOptions.Compiled | RegexOptions.IgnoreCase);

        return temp;
    }

    public static string formatURL(string source)
    {
        string temp = source.ToLower();
        List<string> lst = new List<string>() { "vega","%20","sleep","or","--","select","exists","from","union","delay","waitfor","update","create","drop","/./","&amp",">","-->"};
        foreach (var item in lst)
        {
            temp = Regex.Replace(temp, item, "", RegexOptions.Singleline | RegexOptions.IgnoreCase);
        }
        return temp;
    }
}
