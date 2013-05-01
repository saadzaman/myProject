using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using ERS;
using ERS.BAL;

namespace ERSFYP_AdminPanel
{
    public partial class CategoryWeightage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Admin admin = new Admin();
                List<ERS.DAL.CategoryWithWeightage> DSource = admin.getCategoryWeights(1); 
                Categories.DataSource = DSource;
                Categories.DataBind();

                CountOfRepeaterItems.Value = DSource.Count + "";
              
                Position.DataSource = admin.GetAllPosition();
                Position.DataTextField = "PositionName";
                Position.DataValueField = "PositionID";
                Position.DataBind();
               
            }
            

        }

        protected void Position_SelectedIndexChanged(object sender, EventArgs e)
        {
            Admin admin = new Admin();
         //   List<ERS.DAL.CategoryWithWeightage> list = 
            Categories.DataSource = admin.getCategoryWeights(int.Parse(Position.SelectedValue));
            Categories.DataBind();
            string script = "OnSelectedIndexChange();";
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "UserSecurity", script, true);
          //  Total.Text = 

            
        }

        protected void Save_Click(object sender, EventArgs e)
        {
            int sum = 0;
            List<ERS.CategoryWeightage> SaveList = new List<ERS.CategoryWeightage>();
            foreach (RepeaterItem ri in Categories.Items)
            {
                TextBox tb = (TextBox)ri.FindControl("Weightage");
                sum+= int.Parse(tb.Text);
                HiddenField hf = (HiddenField)ri.FindControl("CategoryID");
                SaveList.Add(new ERS.CategoryWeightage(){PositionID = int.Parse(Position.SelectedValue),CategoryID= int.Parse(hf.Value)
                    ,Weightage = double.Parse(tb.Text) } );
            }
            Admin admin = new Admin();
            admin.InsertCategoryWeightages(SaveList);
            Response.Redirect(Request.RawUrl);
        }
    }
}