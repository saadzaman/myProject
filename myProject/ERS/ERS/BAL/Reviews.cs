﻿using System;
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

        public bool FillReviews( int ReviewID , List<ReviewInfo> Infoes )
        {


            if (ersRep.InsertMultipleReviewInfo(Infoes))
            {
                ersRep.UpdateReviewStatus(ReviewID);
                return true;
            } return false;
        }

        public ReviewInfo GetReviewInfo(int pReviewID, int pCategoryID)
        {

            return ersRep.GetReviewInfo(pReviewID, pCategoryID);
        }


        public List<EmpWithRevInfo_Cat> GetAllReviewsOf_Peer_GivenCategory(int EmpID, int CatID)
        {

            return ersRep.GetAllReviewsOf_Peer_GivenCategory(EmpID, CatID);
        
        }
    }
}