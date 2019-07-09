<%@ Page Language="C#" ValidateRequest="true" AutoEventWireup="true" CodeFile="testFile.aspx.cs" Inherits="testFile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div style="width: 100%; border: 1px solid green; padding-bottom: 20px">
            <asp:Label ID="Label2" runat="server" Text="Kiểm tra Media(AVI,MP4,MP3,FLV,WAVE)"></asp:Label>
            <asp:FileUpload ID="FileUpload1" runat="server" />
            <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" />
            <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
        </div>


        <div style="width: 100%; border: 1px solid green; padding-bottom: 20px">
            <asp:Label ID="Label3" runat="server" Text="Kiểm tra File(WORD,WORDX,PDF,EXCEL,EXCELX,MSDOC,PPT)"></asp:Label>
            <asp:FileUpload ID="FileUpload2" runat="server" />
            <asp:Button ID="Button2" runat="server" Text="Button" OnClick="Button2_Click" />
            <asp:Label ID="Label4" runat="server" Text=""></asp:Label>
        </div>

        <div style="width: 100%; border: 1px solid green; padding-bottom: 20px">
            <asp:Label ID="Label5" runat="server" Text="Kiểm tra Images(JPEG,PNG,GIF,BMP,ICO)"></asp:Label>
            <asp:FileUpload ID="FileUpload3" runat="server" />
            <asp:Button ID="Button3" runat="server" Text="Button" OnClick="Button3_Click" />
            <asp:Label ID="Label6" runat="server" Text=""></asp:Label>
        </div>

        <div style="width: 100%; border: 1px solid green; padding-bottom: 20px">
            <asp:Button ID="Button4" runat="server" Text="Button" OnClick="Button4_Click" />
            <asp:Label ID="Label8" runat="server" Text=""></asp:Label><br />
            <asp:Label ID="Label9" runat="server" Text=""></asp:Label>
            <asp:Literal ID="Literal1" runat="server"></asp:Literal>
            <div id="df" runat="server"></div>
        </div>
        
    </form>
</body>
</html>
