SET SERVEROUTPUT ON;

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE LOANS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
  EXECUTE IMMEDIATE 'DROP TABLE CUSTOMERS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE CUSTOMERS (
    CustomerID NUMBER PRIMARY KEY,
    Age NUMBER,
    Balance NUMBER,
    IsVIP VARCHAR2(5)
);

CREATE TABLE LOANS (
    LoanID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    InterestRate NUMBER,
    DueDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMERS(CustomerID)
);

INSERT INTO CUSTOMERS VALUES (1, 65, 9000, 'FALSE');
INSERT INTO CUSTOMERS VALUES (2, 45, 7000, 'FALSE');
INSERT INTO CUSTOMERS VALUES (3, 70, 10000, 'FALSE');

INSERT INTO LOANS VALUES (101, 1, 8.5, SYSDATE + 20);
INSERT INTO LOANS VALUES (102, 2, 9.0, SYSDATE + 40);
INSERT INTO LOANS VALUES (103, 3, 10.0, SYSDATE + 15);

COMMIT;

-- PL/SQL Block: Interest discount for age > 60
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Interest Rate Discount for Customers Age > 60 ---');
    FOR rec IN (
        SELECT c.CustomerID, l.LoanID, l.InterestRate
        FROM CUSTOMERS c
        JOIN LOANS l ON c.CustomerID = l.CustomerID
        WHERE c.Age > 60
    ) LOOP
        UPDATE LOANS
        SET InterestRate = rec.InterestRate - 1
        WHERE LoanID = rec.LoanID;

        DBMS_OUTPUT.PUT_LINE('Discount applied: Customer ID = ' || rec.CustomerID || 
                             ', Loan ID = ' || rec.LoanID || 
                             ', New Rate = ' || (rec.InterestRate - 1));
    END LOOP;
END;
/
