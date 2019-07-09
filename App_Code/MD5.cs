using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;

/// <summary>
/// Summary description for MD5
/// </summary>
public class MD5
{
	public MD5()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    private static Random random = new Random();
    public static string RandomString(int length)
    {
        const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        return new string(Enumerable.Repeat(chars, length)
          .Select(s => s[random.Next(s.Length)]).ToArray());
    }



    public static string GeneratePasswordHash(string thisPassword)
    {
        MD5CryptoServiceProvider md5 = new MD5CryptoServiceProvider();
        byte[] tmpSource;
        byte[] tmpHash;

        tmpSource = ASCIIEncoding.ASCII.GetBytes(thisPassword); // Turn password into byte array
        tmpHash = md5.ComputeHash(tmpSource);

        StringBuilder sOuput = new StringBuilder(tmpHash.Length);
        for (int i = 0; i < tmpHash.Length; i++)
        {
            sOuput.Append(tmpHash[i].ToString("X2"));  // X2 formats to hexadecimal
        }
        return sOuput.ToString();
    }

    public static Boolean VerifyHashPassword(string thisPassword, string thisHash)
    {
        Boolean IsValid = false;
        string tmpHash = GeneratePasswordHash(thisPassword); // Call the routine on user input
        if (tmpHash == thisHash) IsValid = true;  // Compare to previously generated hash
        return IsValid;
    }

    public Boolean isValidPassword(string thisPassword)
    {
        string newPassword = sanitizeInput(thisPassword);
        Regex regX = new Regex(@"^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{5,15)");
        return regX.Match(newPassword).Success;
    }

    public string sanitizeInput(string thisInput)
    {
        Regex regX = new Regex(@"([<>""'%;()&])");
        return regX.Replace(thisInput, "");
    }

}