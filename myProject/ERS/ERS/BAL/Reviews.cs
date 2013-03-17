using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ERS.DAL;
namespace ERS.BAL
{
    public class Reviews
    {
        ERSRepository ersRep = new ERSRepository();


        public List<EmployeeReviews>  GetReviewsList( int EmpID )
        {
            return ersRep.GetMyReviews(EmpID);
        }

        

        public List<ReviewCategory> GetAllCategories()
        {
            return ersRep.GetCategories();
        }

        public EmployeeWithLM GetEmployee(int EmpID)
        {
            return ersRep.GetEmployee(EmpID);
        }

        public bool FillReviews( int ReviewID , List<ReviewInfo> Infoes , string Type )
        {


            if (ersRep.InsertMultipleReviewInfo(Infoes))
            {
                if(Type == "submit")
                ersRep.UpdateReviewStatus(ReviewID,1);
                else
                ersRep.UpdateReviewStatus(ReviewID,3);
                return true;
            } return false;
        }

        public ReviewInfo GetReviewInfo(int pReviewID, int pCategoryID)
        {

            return ersRep.GetReviewInfo(pReviewID, pCategoryID);
        }

        public bool isDraft(int ReviewID)
        {

            return ersRep.isReviewDraft(ReviewID);
        
        }

        public List<EmpWithRevInfo_Cat> GetAllReviewsOf_Peer_GivenCategory(int EmpID, int CatID)
        {

            return ersRep.GetAllReviewsOf_Peer_GivenCategory(EmpID, CatID);
        
        }
    }
}
