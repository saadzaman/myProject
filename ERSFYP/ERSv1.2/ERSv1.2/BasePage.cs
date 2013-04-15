using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ERSv1._2
{

    public partial class BasePages : System.Web.UI.Page
     {
         public string MenuItemMyReviews { get; set; }
         public string MenuItemMyManagees { get; set; }
         public string MenuItemDirector { get; set; }
         public string MenuItemAbout { get; set; }
         public string Name { get; set; }
         

         public BasePages()
         {
             Name = "UnSigned";
         }
        
   }


}