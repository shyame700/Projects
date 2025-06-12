CREATE TABLE Cleaned_Salaries (
    Id INT PRIMARY KEY,
    EmployeeName varchar(70) NOT NULL,
    JobTitle varchar(100) NOT NULL,
    BasePay FLOAT DEFAULT 0,
    OvertimePay FLOAT DEFAULT 0,
    OtherPay FLOAT DEFAULT 0,
    Benefits FLOAT DEFAULT 0,
    TotalPay FLOAT DEFAULT 0,
    TotalPayBenefits FLOAT DEFAULT 0,
    Year Date,
    Notes varchar(10),
    Agency varchar(15),
    Status varchar(5)
);

