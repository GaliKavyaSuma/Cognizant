SET SERVEROUTPUT ON;

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE EMPLOYEES';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE EMPLOYEES (
    EmpID NUMBER PRIMARY KEY,
    EmpName VARCHAR2(100),
    Department VARCHAR2(50),
    Salary NUMBER
);

INSERT INTO EMPLOYEES VALUES (1, 'Alice', 'IT', 50000);
INSERT INTO EMPLOYEES VALUES (2, 'Bob', 'IT', 60000);
INSERT INTO EMPLOYEES VALUES (3, 'Charlie', 'HR', 40000);

COMMIT;

-- Create stored procedure to update bonus
CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus (
    p_Department IN VARCHAR2,
    p_BonusPercent IN NUMBER
) AS
BEGIN
    UPDATE EMPLOYEES
    SET Salary = Salary + (Salary * p_BonusPercent / 100)
    WHERE Department = p_Department;

    DBMS_OUTPUT.PUT_LINE('Bonus applied to department: ' || p_Department);
END;
/

-- Run the procedure and display updated salaries
BEGIN
    UpdateEmployeeBonus('IT', 10);

    DBMS_OUTPUT.PUT_LINE('Updated salaries after bonus:');
    FOR rec IN (SELECT EmpID, EmpName, Department, Salary FROM EMPLOYEES ORDER BY EmpID) LOOP
        DBMS_OUTPUT.PUT_LINE('EmpID: ' || rec.EmpID || 
                             ', Name: ' || rec.EmpName || 
                             ', Dept: ' || rec.Department || 
                             ', New Salary: ' || TO_CHAR(rec.Salary, 'FM9999990.00'));
    END LOOP;
END;
/
