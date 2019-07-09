using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SourceClient_TinBaoCongDan : System.Web.UI.Page
{
    DataC50Entities timkiem = new DataC50Entities();
    public string kt = "false";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            kt = "true";
            var ketquatimkiem = timkiem.tbl_TinBaoCongDan.Where(m => m.trangthaihienthi == 2 && m.trangthaixem ==true).ToList().Select(m => new
            {
              m.hoten,
              m.email,
              m.noidungtinbao,
              m.tieude,
              m.linktinbao,
              m.ngaygui
            }).OrderByDescending(m => m.ngaygui);


            //CollectionPager1.PageSize = 10; //Số sản phẩm hiển thị trên một trang
            //CollectionPager1.DataSource = ketquatimkiem.ToList();
            //CollectionPager1.BindToControl = RepeaterDANHSACHTINBAOCONGDAN;
            //RepeaterDANHSACHTINBAOCONGDAN.DataSource = CollectionPager1.DataSourcePaged;
        }
    }
    protected void CollectionPager1_Click(object sender, EventArgs e)
    {
        kt = "false";
    }

}