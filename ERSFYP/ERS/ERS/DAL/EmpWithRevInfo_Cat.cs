using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ERS.DAL
{
    public class EmpWithRevInfo_Cat
    {
      

        public EmpWithRevInfo_Cat(ReviewInfo b, Employee employee)
        { 
            // TODO: Complete member initialization
            this.Rating = (int)b.Rating;
            this.Name = employee.Name;
            this.Comment = b.Comments;
            this.ID = employee.EmpID;
        }
        public String Name { get; set; }
        public decimal Rating { get; set; }
         public String Comment { get; set; }
         public int ID { get; set; }
    }
}
