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
                    where (a.ReviewId == (from b in context.Reviews where b.ReviewId == pReviewID select b.AReviewID).FirstOrDefault()
                    && a.CategoryID == pCategoryID)
                    select a).ToList<ReviewInfo>();

           if (result.Count() > 0)
               return result[0];
           else
               return null;
        
        }

        public int GetReviewID(int LMID, int ReviewerID, int EmpID)
        {
            try
            {
                return (from a in context.Reviews
                        where a.EmpID == EmpID && a.LMID == LMID && a.ReviewerID == ReviewerID
                        select a.ReviewId).First();
            }
            catch(Exception ex) {
                return -1;
            }
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
                         && a.Status1.StatusName != "Rejected"
                         select new
                         {
                             ID = a.ReviewId,
                             EmployeeName = a.Employee.Name,
                             LineManager = a.Employee1.Name,
                             Deadline = a.Date,
                             Type = a.ReviewType.TypeName,
                             Feedback = a.feedback,
                             Status = a.Status1.StatusName,
                             Employee = a.Employee2,
                             Review = a
                         };
            //IMPROVE THIS BHAND LATER

            foreach (var b in Result)
            {

                ReturnList.Add(new EmployeeReviews(b.Employee, b.Review ,b.ID, b.EmployeeName, b.LineManager, (DateTime)b.Deadline, b.Type, b.Feedback, b.Status));
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
                                  && a.version == ParamReview.version  
                                  select a).FirstOrDefault();
                if (Orignal != null)
                    return Orignal.ReviewId;
                else
                {
                    ParamReview.ReviewId = GenerateReviewID();
                    if (ParamReview.AReviewID == -1)
                        ParamReview.AReviewID = ParamReview.ReviewId;

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



       #region Permissions
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

       # endregion
 
       public bool CanConsolidate(int EmployeeID)
       {
           return (from a in context.Reviews
                   where a.EmpID == EmployeeID && a.Status1.StatusName == "Completed" && a.ReviewerID != a.Employee1.EmpID
                   select a).Count() == (from b in context.Peers where (b.EmpID == EmployeeID || b.PeerID == EmployeeID) select b).Count() +1;
       } //+1 is for self review
        
       public bool UpdateReviewStatus(int ReviewID,String Status)
       {
           try
           {
               Review Orignal = (from a in context.Reviews where a.ReviewId == ReviewID select a).ToList<Review>()[0];
               context.Reviews.Attach(Orignal);
               Orignal.Status = (from b in context.Status where b.StatusName == Status select b.ID).First();
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

        
        
       public List<LineManagersWithDirector> GetLineManagers(int pDirectorID)
       {

           List<LineManagersWithDirector> ReturnList = new List<LineManagersWithDirector>();


           var Result = from a in
                            (
                               from aa in context.Employees
                               join bb in context.EmployeeRoles on aa.EmpID equals bb.EmpID
                               where bb.RoleID == (from x in context.Roles1 where x.RoleName == "Line Manager" select x).FirstOrDefault().ID
                               select aa
                               )
                        join b in context.DirectorAllocations on a.EmpID equals b.LMId into lefto
                        from o in lefto.DefaultIfEmpty()
                        select new { LMName = a.Name, LMID = a.EmpID, LMDesignation = a.Position.PositionDetails, DirectorID = (o.DirectorID == null) ? 0 : o.DirectorID, DirectorName = (o.Employee1.Name == null) ? "NoOne" : o.Employee1.Name };




           foreach (var temp in Result)
           {
               ReturnList.Add(new LineManagersWithDirector() { LMName = temp.LMName, LMDesignation = temp.LMDesignation, LMDirector = temp.DirectorName, LMID = temp.LMID, DirectorID = temp.DirectorID });
           }

           return ReturnList;
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
                             && f.version == (from ff in fg
                                              where ff.EmpID == a.EmpID
                                              && ff.LMID == pLMID
                                              select ff.version).Max()
                             select f).DefaultIfEmpty()
                        where a.EmpID == pManageeID
                        select new
                        {
                            Employee = a.Employee1,
                            ReviewId = (System.Int32?)fgi.ReviewId,
                            ReviewStatus = fgi.Status1.StatusName
                        };

           foreach (var b in Result)
           {
               if(b.ReviewId !=null)
               ReturnList.Add(new PeersWithReviews((Int32)b.ReviewId, b.ReviewStatus, b.Employee , pManageeID));
               else
                   ReturnList.Add(new PeersWithReviews(0, "0", b.Employee ,pManageeID));

           }


           var Result2 = from a in context.Peers
                         join f in context.Reviews on a.EmpID equals f.ReviewerID into fg
                         from fgi in
                             (from f in fg
                              where f.EmpID == a.PeerID
                              && f.LMID == pLMID
                               && f.version == (from ff in fg
                                                where ff.EmpID == a.PeerID
                                                && ff.LMID == pLMID
                                                select ff.version).Max()
                              select f).DefaultIfEmpty()
                         where a.PeerID == pManageeID
                        select new
                        {
                            Employee = a.Employee,
                            ReviewId = (System.Int32?)fgi.ReviewId,
                            ReviewStatus = fgi.Status1.StatusName
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
               if (ItemRet.PeerID == id  )
                   return false;
           }
           return true;
       }
       public List<EmpWithRevInfo_Cat> GetAllReviewsOf_Peer_GivenCategory(int EmpID, int CatID)
       {
           List<EmpWithRevInfo_Cat> ReturnList = new List<EmpWithRevInfo_Cat>();
           var Result = (from a in context.ReviewInfoes
                        where a.CategoryID == CatID
                        join b in context.Reviews on a.ReviewId equals b.AReviewID
                        where b.EmpID == EmpID
                        select a).Distinct();

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
           return (from a in context.ReviewCategories where a.CategoryName != "LineManager" && a.CategoryName != "Director" select a).ToList<ReviewCategory>();
       }


       public List<ReviewCategory> GetAllCategories()
       {
           return (from a in context.ReviewCategories select a).ToList<ReviewCategory>();
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


       public bool InsertReviewInfo(ReviewInfo r)
       {

           try
           {
               
                   if (context.ReviewInfoes.Any(e => (e.ReviewId == r.ReviewId && e.CategoryID == r.CategoryID)))
                   {
                       context.ReviewInfoes.Attach(r);
                       context.ObjectStateManager.ChangeObjectState(r, EntityState.Modified);
                   }
                   else
                   {
                       context.ReviewInfoes.AddObject(r);
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
                   select a.Status1.StatusName).FirstOrDefault() == "Drafted";
       }

       public string GetStatus(int LMID, int EmpID)
       {
           try
           {
               return (from a in context.Reviews
                       where a.LMID == LMID && a.ReviewerID == EmpID && a.EmpID == EmpID
                       select a.Status1.StatusName).First();
           }
           catch
           {
               return "Pending";
           }
       }

       public string GetStatus(int ReviewID)
       {
           switch ((from a in context.Reviews
                    where a.ReviewId == ReviewID
                    select a.Status1.StatusName).FirstOrDefault())
           {
               case "Completed":
               case "Consolidated" :
                   return "Complete";
               //break;
               case "Pending":
                   return "Pending";
               //break;
               case "Drafted":
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

       public bool isConsolidated(int EmpID, int LMID)
       {
           try
           {
               return (from a in context.Reviews
                       where a.LMID == LMID && a.ReviewerID == LMID && a.EmpID == EmpID && a.Status1.StatusName != "Rejected" 
                       select a.Status1.StatusName).First() == "Consolidated";
           }
           catch {
               return false;
           }
       
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
                   where (a.EmpID == UserID || a.ReviewerID == UserID) && a.ReviewId == ReviewID
                   select a.LMID).FirstOrDefault() != null;
       }

        //CONDITION FOR MAKING PEERS
        //(from b in Peers where (b.EmpID == PEER1 && b.PeerID == PEER2) || ( b.EmpID == PEER2 && b.PeerID == PEER1) select b).Count() == 0
       public int AddReview(int EmpID, int LMID ,int Reviewee , String feedback , String Type)
       {

           try
           {
               Review temp = new ERS.Review();
               temp.Date = DateTime.Now;
               temp.EmpID = EmpID;
               temp.LMID = LMID;
               temp.IsActive = 0;
                int RTID = (from a in context.ReviewTypes  where a.TypeName == Type select a.ReviewTypeID).DefaultIfEmpty(4).First();
               temp.ReviewTypeID = RTID ;
               temp.feedback = feedback;
               temp.Status = 2;   // Review Status For Pending 
               
       var MidQuery = (from a in context.Reviews where a.EmpID == EmpID && a.LMID == LMID && a.ReviewerID == Reviewee select new { version = a.version, AReviewID = a.AReviewID }).OrderByDescending(e => e.version).FirstOrDefault();
               if(MidQuery == null)
                   temp.version = 1;
               else
               temp.version = MidQuery.version;
               temp.ReviewerID = Reviewee;
               if (MidQuery == null)
                   temp.AReviewID = -1;
               else
               temp.AReviewID = MidQuery.AReviewID;
               return InsertReview(temp); 
           }
           catch(Exception ex)
           {
               throw ex;
               return -1;
           }

       }

        /*

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
               temp.AReviewID = -1;
                return InsertReview(temp);
           }
           catch {
           return -1;
           }

       }
        */
       public int CreateReviewForConsolidate(int EmpID, int LMID)
       {
           int ReviewID =  AddReview(EmpID, LMID ,LMID , "LM's Request" , "Consolidation");
           return ReviewID;
       }

       public bool AreReviewsPending(int LMID)
       {
           return (from a in context.Reviews
                   where (a.Status1.StatusName != "Completed" && a.Status1.StatusName != "Consolidated" && a.Status1.StatusName != "Rejected")
                   && a.LMID == LMID
                   select a).Count() == 0
                   && ( from b in context.Reviews where b.LMID == LMID select b).Count() != 0
                   ;
       
       }


       public bool RejectReview(int ReviewID, String Feedback, int RejectedBy)
       {

           try
           {

               Review Orignal = (from a in context.Reviews where a.ReviewId == ReviewID select a).ToList<Review>()[0];
               if (Orignal.Status1.StatusName != "Rejected")
               {
                   //context.Reviews.Attach(Orignal);
                   Review New = new Review()
                   {
                       version = Orignal.version + 1,
                       Status = (from a in context.Status where a.StatusName == "Pending" select a.ID).First(),
                       EmpID = Orignal.EmpID,
                       LMID = Orignal.LMID,
                       ReviewerID = Orignal.ReviewerID,
                       Date = DateTime.Now,
                       AReviewID = Orignal.AReviewID,
                       IsActive = 0,
                       ReviewTypeID = Orignal.ReviewTypeID,
                       feedback = Feedback + "| By " + (from a in context.Employees where a.EmpID == RejectedBy select a.Name).First(),
                       RejectedBy = RejectedBy
                   };
                   InsertReview(New);
                   UpdateReviewStatus(ReviewID, "Rejected");

               }

               return true;


           }
           catch (Exception ex)
           {
               throw ex;
               return false;
           }
       }


       public bool RejectReview(int ReviewID, int RejectedBy)
       {

           try
           {

               Review Orignal = (from a in context.Reviews where a.ReviewId == ReviewID select a).ToList<Review>()[0];
               if(Orignal.Status1.StatusName != "Rejected")
               {
               //context.Reviews.Attach(Orignal);
               Review New = new Review() { 
               version = Orignal.version  + 1,
               Status = (from a in context.Status where a.StatusName == "Pending" select a.ID).First(),
               EmpID = Orignal.EmpID,
               LMID = Orignal.LMID,
               ReviewerID = Orignal.ReviewerID,
               Date = DateTime.Now,
               AReviewID = Orignal.AReviewID,
               IsActive = 0,
               ReviewTypeID = Orignal.ReviewTypeID,
               feedback = "Rejected" + "| By " + (from a in context.Employees where a.EmpID == RejectedBy select a.Name).First(),
               RejectedBy = RejectedBy
               };
               InsertReview(New);
               UpdateReviewStatus(ReviewID, "Rejected");

               }
               
               return true;
           

           }
           catch (Exception ex)
           {
               throw ex;
               return false;
           }
       }

       public int GetCategoryID(string CatName)
       {
           return (from a in context.ReviewCategories
                   where a.CategoryName == CatName
                   select a.CategoryID).First() ;
           
       }


       public int GetAReviewID(int ReviewID)
       {
           return ( from a in context.Reviews where a.ReviewId == ReviewID select a.AReviewID).First();

       }

       public int GetLatestReviewID(int LMID, int EmpID)
       {
           return (from a in context.Reviews where a.EmpID == EmpID && a.LMID == LMID && a.ReviewerID == LMID select a).OrderByDescending(e => e.version).First().ReviewId;
       }



       public bool isLMSConsolidation(int ReviewID)
       {
          return ( ( from a in context.Reviews where a.ReviewId == ReviewID && a.LMID == a.ReviewerID select a.ReviewId ).Count() > 0 );
       }

       public string GetType(int ReviewID)
       {
           return (from a in context.Reviews where a.ReviewId == ReviewID select a.ReviewType.TypeName).First();
       }
    }

}
