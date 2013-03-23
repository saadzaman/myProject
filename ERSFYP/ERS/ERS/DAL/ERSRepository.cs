using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;

namespace ERS.DAL
{
    public  class ERSRepository : IDisposable
    {
        private ERS_LMTEntities context = new ERS_LMTEntities();

        public ReviewInfo GetReviewInfo(int pReviewID, int pCategoryID)
        {

           var result = (from a in context.ReviewInfoes
                    where (a.ReviewId == pReviewID && a.CategoryID == pCategoryID)
                    select a).ToList<ReviewInfo>();

           if (result.Count() > 0)
               return result[0];
           else
               return null;
        
        }

        public Employee GetUserID(string email)
        {
            Employee result = (from a in context.Employees
                         where a.Email == email
                         select a).FirstOrDefault();
            return result;
        }
        public List<EmployeeReviews> GetMyReviews(int ParamEmpId)
        {
            List<EmployeeReviews> ReturnList = new List<EmployeeReviews>();
            var Result = from a in context.Reviews
                         where a.ReviewerID == ParamEmpId
                         select new
                         {
                             ID = a.ReviewId,
                             EmployeeName = a.Employee.Name,
                             LineManager = a.Employee1.Name,
                             Deadline = a.Date,
                             Type = a.ReviewType.TypeName,
                             Feedback = a.feedback,
                             Status = a.Status,
                             Employee = a.Employee,
                             Review = a
                         };
            //IMPROVE THIS BHAND LATER

            foreach (var b in Result)
            {

                ReturnList.Add(new EmployeeReviews(b.Employee, b.Review ,b.ID, b.EmployeeName, b.LineManager, (DateTime)b.Deadline, b.Type, b.Feedback, (Int32)b.Status));
            }

            return ReturnList;

        }
     

       public  int InsertReview(Review ParamReview)
        {
            try
            {
                Review Orignal = (from a in context.Reviews
                                  where a.LMID == ParamReview.LMID
                                  && a.EmpID == ParamReview.EmpID
                                  && a.ReviewerID == ParamReview.ReviewerID
                                  select a).FirstOrDefault();
                if (Orignal != null)
                    return Orignal.ReviewId;
                else
                {
                    ParamReview.ReviewId = GenerateReviewID();
                    context.Reviews.AddObject(ParamReview);
                    context.SaveChanges();
                    return ParamReview.ReviewId;
                }
            }
            catch (Exception ex)
            {
                //Include catch blocks for specific exceptions first,
                //and handle or log the error as appropriate in each.
                //Include a generic catch block like this one last.
                throw ex;
               // return false;
            }


        }

       public bool InsertFeature(Feature ParamFeature)
       {
           try
           {
               context.Features.AddObject(ParamFeature);
               context.SaveChanges();
               return true;
           }
           catch (Exception)
           {

               //Include catch blocks for specific exceptions first,
               //and handle or log the error as appropriate in each.
               //Include a generic catch block like this one last.
               return false;
           }
       }

       public bool InsertPermission(Permission ParamPermission)
       {
           try
           {
               context.Permissions.AddObject(ParamPermission);
               context.SaveChanges();
               return true;
           }
           catch (Exception)
           {

               //Include catch blocks for specific exceptions first,
               //and handle or log the error as appropriate in each.
               //Include a generic catch block like this one last.
               return false;
           }
       }
       public bool isAllowed(int FeatureID, int EmployeeID)
       {
           var q = (from c in context.Permissions
                    join d in
                        ((from a in context.Employees
                          join b in context.EmployeeRoles on a.EmpID equals b.EmpID
                          where a.EmpID == EmployeeID
                          select new { RoleID = b.RoleID }).Distinct()) on c.RoleID equals d.RoleID
                    where c.FeatureID == FeatureID
                    select c.Feature).Count();
           if (q > 0)
               return true;
           else
           {
               return false;
           }
          
       }

       public bool CanConsolidate(int EmployeeID)
       {
           return (from a in context.Reviews
                   where a.EmpID == EmployeeID && a.Status == 1 && a.ReviewerID != a.Employee1.EmpID
                   select a).Count() == (from b in context.Peers where (b.EmpID == EmployeeID || b.PeerID == EmployeeID) select b).Count() +1;
       } //+1 is for self review
        
       public bool UpdateReviewStatus(int ReviewID,int Status)
       {
           try
           {
               Review Orignal = (from a in context.Reviews where a.ReviewId == ReviewID select a).ToList<Review>()[0];
               context.Reviews.Attach(Orignal);
               Orignal.Status = Status;
               context.ApplyCurrentValues("Reviews", Orignal);
               context.SaveChanges();
               return true;
           }
           catch (Exception ex)
           {
               //Include catch blocks for specific exceptions first,
               //and handle or log the error as appropriate in each.
               //Include a generic catch block like this one last.
               throw ex;
               return false;
           }

       }

       public List<Employee> GetManageesList(int LMID)
       {
           return (from a in context.LMAllocations
                  where a.LMID == LMID
                  select a.Employee1).ToList<Employee>();
       
       }


       public List<PeersWithReviews> GetPeersWithReviewStats(int pManageeID , int pLMID)
       {

           List<PeersWithReviews> ReturnList = new List<PeersWithReviews>();


           var Result = from a in context.Peers
                        join f in context.Reviews on a.PeerID equals f.ReviewerID into fg
                        from fgi in
                            (from f in fg
                             where f.EmpID == a.EmpID
                             && f.LMID == pLMID
                             select f).DefaultIfEmpty()
                        where a.EmpID == pManageeID
                        select new
                        {
                            Employee = a.Employee1,
                            ReviewId = (System.Int32?)fgi.ReviewId,
                            ReviewStatus = (System.Int32?)fgi.Status
                        };

           foreach (var b in Result)
           {
               if(b.ReviewId !=null)
               ReturnList.Add(new PeersWithReviews((Int32)b.ReviewId, b.ReviewStatus.ToString(), b.Employee , pManageeID));
               else
                   ReturnList.Add(new PeersWithReviews(0, "0", b.Employee ,pManageeID));

           }


           var Result2 = from a in context.Peers
                         join f in context.Reviews on a.EmpID equals f.ReviewerID into fg
                         from fgi in
                             (from f in fg
                              where f.EmpID == a.PeerID
                              && f.LMID == pLMID
                              select f).DefaultIfEmpty()
                         where a.PeerID == pManageeID
                        select new
                        {
                            Employee = a.Employee,
                            ReviewId = (System.Int32?)fgi.ReviewId,
                            ReviewStatus = (System.Int32?)fgi.Status
                        };

           foreach (var b in Result2)
           {
              if(CheckIfExists(ReturnList , (Int32)b.Employee.EmpID))
              {
               if (b.ReviewId != null)
                   ReturnList.Add(new PeersWithReviews((Int32)b.ReviewId, b.ReviewStatus.ToString(), b.Employee, pManageeID));
               else
                   ReturnList.Add(new PeersWithReviews(0, "0", b.Employee, pManageeID));
              }
           }

           return ReturnList;

       }
       bool CheckIfExists(List<PeersWithReviews> ReturnList, int id)
       {
           foreach (PeersWithReviews ItemRet in ReturnList)
           {
               if (ItemRet.PeerID == id)
                   return false;
           }
           return true;
       }
       public List<EmpWithRevInfo_Cat> GetAllReviewsOf_Peer_GivenCategory(int EmpID, int CatID)
       {
           List<EmpWithRevInfo_Cat> ReturnList = new List<EmpWithRevInfo_Cat>();
           var Result = from a in context.ReviewInfoes
                        where a.CategoryID == CatID
                        join b in context.Reviews on a.ReviewId equals b.ReviewId
                        where b.EmpID == EmpID
                        select a;

           foreach (var b in Result)
           {

               ReturnList.Add(new EmpWithRevInfo_Cat(b,b.Review.Employee2));
           }

           return ReturnList;
       }

       private Int32 GenerateReviewID()
       {
           Int32 maxDepartmentID = 0;
           var department = (from d in context.Reviews
                             orderby d.ReviewId descending
                             select d).FirstOrDefault();
           if (department != null)
           {
               maxDepartmentID = department.ReviewId + 1;
           }
           return maxDepartmentID;
       }



       public List<ReviewCategory> GetCategories()
       {
           return (from a in context.ReviewCategories  where a.CategoryName != "LineManager" select a ).ToList<ReviewCategory>();
       }

       public EmployeeWithLM GetEmployee(int pEmpID)
       {

           var a = (from b in context.Employees
                    join c in context.LMAllocations on b.EmpID equals c.ManageeId
                    where b.EmpID == pEmpID
                    select new
                    {
                        Employee = b,
                        LineManager = c.Employee
                    });
           foreach (var va in a )
                  return new EmployeeWithLM(va.Employee, va.LineManager);
           return null;
               
       }



       public bool InsertMultipleReviewInfo(List<ReviewInfo> Infoes)
       {

           try
           {
               foreach (ReviewInfo r in Infoes)
               {
                  
                   if (context.ReviewInfoes.Any(e => (e.ReviewId == r.ReviewId && e.CategoryID == r.CategoryID) ))
                   {
                       context.ReviewInfoes.Attach(r);
                       context.ObjectStateManager.ChangeObjectState(r, EntityState.Modified);
                   }
                   else
                   {
                       context.ReviewInfoes.AddObject(r);
                   }

                           
               }
               context.SaveChanges();
               return true;
           }
           catch (Exception ex)
           {

               //Include catch blocks for specific exceptions first,
               //and handle or log the error as appropriate in each.
               //Include a generic catch block like this one last.
               throw ex;
               return false;
           }

       
       }




       private bool disposedValue = false;

       protected virtual void Dispose(bool disposing)
       {
           if (!this.disposedValue)
           {
               if (disposing)
               {
                   context.Dispose();
               }
           }
           this.disposedValue = true;
       }

       public void Dispose()
       {
           Dispose(true);
           GC.SuppressFinalize(this);
       }



       public bool isLM(int EmpID)
       {
           return (from a in context.Employees
                   join b in context.LMAllocations on a.EmpID equals b.LMID
                   where a.EmpID == EmpID
                   select a).Count() != 0;
       }

       public bool isReviewDraft(int ReviewID)
       {
           return (from a in context.Reviews
                   where a.ReviewId == ReviewID
                   select a.Status).FirstOrDefault() == 3;
       }

       public string GetType(int ReviewID)
       {
           switch ((from a in context.Reviews
                    where a.ReviewId == ReviewID
                    select a.Status).FirstOrDefault())
           {
               case 1:
                   return "Complete";
               //break;
               case 2:
                   return "Pending";
               //break;
               case 3:
                   return "Draft";
                   break;
               default:
                   return "invalid";
           }

       }

       public EmployeeWithLM GetEmployeeFromReview(int ReviewID)
       {
           var a = (from b in context.Reviews
                    where b.ReviewId == ReviewID
                    select new
                    {
                        Employee = b.Employee,
                        LineManager = b.Employee1
                    });
           foreach (var va in a)
               return new EmployeeWithLM(va.Employee, va.LineManager);
           return null;
         
       }

       public bool isLMOfReview(int UserID ,int ReviewID)
       {
           return (from a in context.Reviews
                   where a.LMID == UserID && a.ReviewId == ReviewID
                   select a.LMID).FirstOrDefault() != null;
       }

       public bool isEmpOfReview(int UserID , int ReviewID)
       {
           return (from a in context.Reviews
                   where a.EmpID == UserID && a.ReviewId == ReviewID
                   select a.LMID).FirstOrDefault() != 0;
       }

        //CONDITION FOR MAKING PEERS
        //(from b in Peers where (b.EmpID == PEER1 && b.PeerID == PEER2) || ( b.EmpID == PEER2 && b.PeerID == PEER1) select b).Count() == 0
       public int AddReview(int EmpID, int LMID ,int PeerID , String feedback)
       {

           try
           {
               Review temp = new ERS.Review();
               temp.Date = DateTime.Now;
               temp.EmpID = EmpID;
               temp.LMID = LMID;
               temp.IsActive = 0;
               temp.Status = 2;
               temp.version = 1;
               temp.ReviewTypeID = 0;
               temp.feedback = feedback;
               temp.ReviewerID = PeerID;




               return InsertReview(temp); 
           }
           catch
           {
               return -1;
           }

       }



       public int AddReview(int EmpID , int LMID)
       {

           try
           {
               Review temp = new ERS.Review();
               temp.Date = DateTime.Now;
               temp.EmpID = EmpID;
               temp.LMID = LMID;
               temp.IsActive = 0;
               temp.Status = 2;
               temp.version = 1;
               temp.ReviewTypeID = 0;
               temp.feedback = "None";
               temp.ReviewerID = LMID;
                return InsertReview(temp);
           }
           catch {
           return -1;
           }

       }

       public int CreateReviewForConsolidate(int EmpID, int LMID)
       {
           int ReviewID =  AddReview(EmpID, LMID);
           return ReviewID;
       }
    }

}
