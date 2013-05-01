using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using ERS.DAL;

namespace ERSFYP_AdminPanel
{
    public partial class Relations : BasePages
    {
        [Serializable]
        public class TypeOfRelation
        {
            public int id { get; set; }
            public String RelationName { get; set; }

            public TypeOfRelation(int id , String RelationName)
            {
                this.id = id;
                this.RelationName = RelationName;
            }
        }

        
       
        private void Page_Load(object sender, System.EventArgs e)
        {

            if (!IsPostBack)
            {


                List<ERS.DAL.Allocations> ml = new ERS.BAL.Admin().GetAllAllocations();
                ml.Sort((a, b) => (a.EmpFirstID == 1).CompareTo(false));
                Repeater1.DataSource = ml;
                Repeater1.DataBind();

                ViewState["ML"] = ml;
                
                HookOnFocus(this.Page as Control);
            }
            RestoreFocus();

        }
       /// <summary>
       /// 
       /// </summary>
       /// <param name="e"></param>
       
        override protected void OnInit(EventArgs e)
        {
            InitializeComponent();
            base.OnInit(e);
        }

        private void InitializeComponent()
        {
            this.Load += new System.EventHandler(this.Page_Load);
            this.Repeater1.ItemDataBound += new RepeaterItemEventHandler(Repeater1_ItemDataBound);
        }

        void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            List<TypeOfRelation> Types = new List<TypeOfRelation>();
            
                Types.Add(new TypeOfRelation(1,"LM"));
                Types.Add(new TypeOfRelation(2, "Director"));
                Types.Add(new TypeOfRelation(3, "Peer"));


                ERS.BAL.Admin rev = new ERS.BAL.Admin();
                List<ERS.Employee> Emp = rev.GetAllEmployees();
                

            DropDownList list = (DropDownList)e.Item.FindControl("dd");
            if (list != null)
            {
                list.DataSource = Emp;
                list.SelectedValue = ((((Allocations)(e.Item.DataItem)).EmpFirstID != -1) ? ((Allocations)(e.Item.DataItem)).EmpFirstID : Emp[0].EmpID).ToString();
                list.DataBind();
            }

            DropDownList list1 = (DropDownList)e.Item.FindControl("Type");
            if (list1 != null)
            {
                list1.DataSource = Types;
                list1.SelectedValue = ((((Allocations)(e.Item.DataItem)).TypeID != -1) ? ((Allocations)(e.Item.DataItem)).TypeID : Types[0].id).ToString();
                list1.DataBind();
            }

            DropDownList list2 = (DropDownList)e.Item.FindControl("Emp");
            if (list2 != null)
            {
                list2.DataSource = Emp;
                list2.SelectedValue = ((((Allocations)(e.Item.DataItem)).EmpSecondID != -1) ? ((Allocations)(e.Item.DataItem)).EmpSecondID : Emp[0].EmpID).ToString();
                list2.DataBind();
            }


        }
      
        protected void dd_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList dd = (DropDownList)(sender);
            RepeaterItem ri = (RepeaterItem)(dd.Parent);
            string selected = ((HiddenField)(ri.FindControl("selected"))).Value;
            if (selected != dd.SelectedValue)
            {
                ((TextBox)(ri.FindControl("Change"))).Text = "1";
                ((HiddenField)(ri.FindControl("selected"))).Value = dd.SelectedValue + "";
            }
            
            
            
        }

        protected void Type_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList Type = (DropDownList)(sender);
            RepeaterItem ri = (RepeaterItem)(Type.Parent);
            //((HiddenField)(ri.FindControl("TypeT"))).Value = Type.SelectedValue + "";
            string selected = ((HiddenField)(ri.FindControl("TypeT"))).Value;
            if (selected != Type.SelectedValue)
            {
                ((TextBox)(ri.FindControl("Change"))).Text = "1";
                ((HiddenField)(ri.FindControl("TypeT"))).Value = Type.SelectedValue + "";
            }
        }

        protected void Emp_SelectedIndexChanged(object sender, EventArgs e)
        {
            DropDownList Emp = (DropDownList)(sender);
            RepeaterItem ri = (RepeaterItem)(Emp.Parent);
            //((HiddenField)(ri.FindControl("EmpT"))).Value = Emp.SelectedValue + "";
            string selected = ((HiddenField)(ri.FindControl("EmpT"))).Value;
            if (selected != Emp.SelectedValue)
            {
                ((TextBox)(ri.FindControl("Change"))).Text = "1";
                ((HiddenField)(ri.FindControl("EmpT"))).Value = Emp.SelectedValue + "";
            }
        }
       
        protected void Button1_Click(object sender, EventArgs e)
        {
            List<Allocations> ml = (List<Allocations>)(ViewState["ML"]);
            //Saving State of all selected
            int i=0;
            foreach (RepeaterItem a in Repeater1.Items)
            {
                String texthiddden = (a.FindControl("selected") as HiddenField).Value;
                if (texthiddden.Length > 0)
                {
                    int aaa = Int32.Parse(texthiddden);
                    ml[i].EmpFirstID = aaa;
                   
                }
                texthiddden = (a.FindControl("TypeT") as HiddenField).Value;
                if (texthiddden.Length > 0)
                {
                    int aaa = Int32.Parse(texthiddden);
                    ml[i].TypeID = aaa;

                }
                texthiddden = (a.FindControl("EmpT") as HiddenField).Value;
                if (texthiddden.Length > 0)
                {
                    int aaa = Int32.Parse(texthiddden);
                    ml[i].EmpSecondID = aaa;

                } 
                
                
                
                i++;
            }
            
           Allocations test = new Allocations(-1,-1,-1);
            ml.Add(test);
          //  ml.Sort( (a,y) => (a.EmpFirstID == 1).CompareTo(false) );
            Repeater1.DataSource = ml;
            Repeater1.DataBind();

            ViewState["ML"] = ml;
        }

      


        
    }
}