using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserControl_URLMENU : System.Web.UI.UserControl
{
    DataC50Entities entity = new DataC50Entities();
    protected void Page_Load(object sender, EventArgs e)
    {
        string type = HttpContext.Current.Request.Url.AbsolutePath;
        var _listURL = entity.Menu_Client.Where(m => m.duongdan == type).FirstOrDefault();
        if (_listURL != null)
        {
            List<DMNgang> _listParent = new List<DMNgang>();
            List<DMNgang> _listParent2 = new List<DMNgang>();
            _listParent = new Libs().getList(_listURL.id_danhmuc, new List<DMNgang>());
            for (int j = _listParent.Count - 1; j >= 0; j--)
            {
                _listParent2.Add(_listParent[j]);
            }
            RepeaterURLMenu.DataSource = _listParent2;
            RepeaterURLMenu.DataBind();
        }
    }
}