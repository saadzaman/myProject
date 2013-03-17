using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ERS.DAL;


namespace ERS.BAL
{
    public class Login
    {
        ERSRepository ersRep = new ERSRepository();

        public int GetUserID(string email)
        {
            return ersRep.GetUserID(email);
        }
    }
}
