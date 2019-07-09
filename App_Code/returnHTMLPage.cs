using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for returnHTMLPage
/// </summary>
public class returnHTMLPage
{
    public string outputHTMLPage(int total, int currPage, string url)
    {
        string path = HttpContext.Current.Request.Path;
        string type = HttpContext.Current.Request.Url.AbsolutePath;
        string pageHTML = "";

        if (total <= 5)
        {
            for (int i = 1; i <= total; i++)
            {
                if (i == currPage)
                {
                    pageHTML = pageHTML + @"<b>" + currPage + "</b>&nbsp;";
                }
                else
                {
                    pageHTML = pageHTML + @"<a href='" + path + "?page=" + i + "" + url + "'>" + i + "</a>&nbsp;";
                }
            }
        }
        else
        {
            if (currPage == 1)
            {
                pageHTML = pageHTML + @"<b>" + currPage + "</b>&nbsp;";
                pageHTML = pageHTML + @"<a href='" + path + "?page=" + 2 + "" + url + "'>" + 2 + "</a>&nbsp;";
                pageHTML = pageHTML + @"<a href='" + path + "?page=" + 3 + "" + url + "'>" + 3 + "</a>&nbsp;";
                pageHTML = pageHTML + @"<a href='" + path + "?page=" + 4 + "" + url + "'>" + 4 + "</a>&nbsp;";
                pageHTML = pageHTML + @"<b>...</b>&nbsp;";
                pageHTML = pageHTML + @"<a href='" + path + "?page=" + total + "" + url + "'>" + total + "</a>&nbsp;";
            }
            else if (currPage == 2)
            {
                pageHTML = pageHTML + @"<a href='" + path + "?page=" + 1 + "" + url + "'>" + 1 + "</a>&nbsp;";
                pageHTML = pageHTML + @"<b>" + currPage + "</b>&nbsp;";
                pageHTML = pageHTML + @"<a href='" + path + "?page=" + 3 + "" + url + "'>" + 3 + "</a>&nbsp;";
                pageHTML = pageHTML + @"<a href='" + path + "?page=" + 4 + "" + url + "'>" + 4 + "</a>&nbsp;";
                pageHTML = pageHTML + @"<b>...</b>&nbsp;";
                pageHTML = pageHTML + @"<a href='" + path + "?page=" + total + "" + url + "'>" + total + "</a>&nbsp;";
            }
            else if (currPage == 3)
            {
                pageHTML = pageHTML + @"<a href='" + path + "?page=" + 1 + "" + url + "'>" + 1 + "</a>&nbsp;";
                pageHTML = pageHTML + @"<a href='" + path + "?page=" + 2 + "" + url + "'>" + 2 + "</a>&nbsp;";
                pageHTML = pageHTML + @"<b>" + currPage + "</b>&nbsp;";
                pageHTML = pageHTML + @"<a href='" + path + "?page=" + 4 + "" + url + "'>" + 4 + "</a>&nbsp;";
                pageHTML = pageHTML + @"<b>...</b>&nbsp;";
                pageHTML = pageHTML + @"<a href='" + path + "?page=" + total + "" + url + "'>" + total + "</a>&nbsp;";
            }
            else if (currPage == total)
            {
                pageHTML = pageHTML + @"<a href='" + path + "?page=" + 1 + "" + url + "'>" + 1 + "</a>&nbsp;";
                pageHTML = pageHTML + @"<b>...</b>&nbsp;";
                pageHTML = pageHTML + @"<a href='" + path + "?page=" + (total - 3) + "" + url + "'>" + (total - 3) + "</a>&nbsp;";
                pageHTML = pageHTML + @"<a href='" + path + "?page=" + (total - 2) + "" + url + "'>" + (total - 2) + "</a>&nbsp;";
                pageHTML = pageHTML + @"<a href='" + path + "?page=" + (total - 1) + "" + url + "'>" + (total - 1) + "</a>&nbsp;";
                pageHTML = pageHTML + @"<b>" + currPage + "</b>&nbsp;";
            }
            else if (currPage == (total - 1))
            {
                pageHTML = pageHTML + @"<a href='" + path + "?page=" + 1 + "" + url + "'>" + 1 + "</a>&nbsp;";
                pageHTML = pageHTML + @"<b>...</b>&nbsp;";
                pageHTML = pageHTML + @"<a href='" + path + "?page=" + (total - 3) + "" + url + "'>" + (total - 3) + "</a>&nbsp;";
                pageHTML = pageHTML + @"<a href='" + path + "?page=" + (total - 2) + "" + url + "'>" + (total - 2) + "</a>&nbsp;";
                pageHTML = pageHTML + @"<b>" + (total - 1) + "</b>&nbsp;";
                pageHTML = pageHTML + @"<a href='" + path + "?page=" + total + "" + url + "'>" + total + "</a>&nbsp;";
            }
            else if (currPage == (total - 2))
            {
                pageHTML = pageHTML + @"<a href='" + path + "?page=" + 1 + "" + url + "'>" + 1 + "</a>&nbsp;";
                pageHTML = pageHTML + @"<b>...</b>&nbsp;";
                pageHTML = pageHTML + @"<a href='" + path + "?page=" + (total - 3) + "" + url + "'>" + (total - 3) + "</a>&nbsp;";
                pageHTML = pageHTML + @"<b>" + (total - 2) + "</b>&nbsp;";
                pageHTML = pageHTML + @"<a href='" + path + "?page=" + (total - 1) + "" + url + "'>" + (total - 1) + "</a>&nbsp;";
                pageHTML = pageHTML + @"<a href='" + path + "?page=" + total + "" + url + "'>" + total + "</a>&nbsp;";
            }
            else
            {
                pageHTML = pageHTML + @"<a href='" + path + "?page=" + 1 + "" + url + "'>" + 1 + "</a>&nbsp;";
                pageHTML = pageHTML + @"<b>...</b>&nbsp;";
                pageHTML = pageHTML + @"<a href='" + path + "?page=" + (currPage - 1) + "" + url + "'>" + (currPage - 1) + "</a>&nbsp;";
                pageHTML = pageHTML + @"<b>" + currPage + "</b>&nbsp;";
                pageHTML = pageHTML + @"<a href='" + path + "?page=" + (currPage + 1) + "" + url + "'>" + (currPage + 1) + "</a>&nbsp;";
                pageHTML = pageHTML + @"<b>...</b>&nbsp;";
                pageHTML = pageHTML + @"<a href='" + path + "?page=" + total + "" + url + "'>" + total + "</a>&nbsp;";
            }
        }
        return pageHTML;
    }
}