using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ERS.DAL
{
    public class CategoryWithWeightage
    {
        public int CategoryID { get; set; }
        public string CategoryName  { get; set; }
        public double Weightage { get; set; }

        public CategoryWithWeightage(ReviewCategory rc, double weight)
        {
            CategoryID = rc.CategoryID;
            CategoryName = rc.CategoryName;
            Weightage = weight;
        }
            

    }
}
