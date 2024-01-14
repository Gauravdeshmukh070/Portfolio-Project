--Create DataBase
create database Bank_analitics

--Joining Both Tables
select *
from Bank_analitics..Finance_1
join Bank_analitics..Finance_2
on Finance_1.id=Finance_2.id

--Year Wise Lone Amount
select year(issue_d) as Year, loan_amnt as Total_Lone_Amount
from Finance_1
order by issue_d

--Grade and Sub Grade Wise Sum of Revol Balance
select grade, sub_grade, sum(revol_bal) revolving_Balance
from Finance_1 F1 inner join Finance_2 F2
on F1.id = F2.id
group by grade, sub_grade
order by grade, sub_grade

--Grade and Sub Grade Wise Revol Balance
--select grade, sub_grade, revol_bal
--from Finance_1, Finance_2
--order by grade, sub_grade

--Total Payment for Verified Status Vs Total Payment for Non Verified Status
select verification_status, sum(loan_amnt) Total_Lone_Amount
from Finance_1 F1
where verification_status in ('verified', 'source verified', 'not verified')
group by verification_status

--State wise and month wise loan status
select addr_state, MONTH(issue_d) Month_Number, Sum(loan_amnt) Total_Lone_Amount
from Finance_1
group by addr_state, MONTH(issue_d)
order by addr_state, MONTH(issue_d)

--Home ownership Vs last payment date stats
select home_ownership Home_Ownership, last_pymnt_d Last_Payment_Date
from Finance_1 F1 inner join Finance_2 F2
on (F1.id=F2.id)
where last_pymnt_d is not null
group by home_ownership,last_pymnt_d
Order by last_pymnt_d
