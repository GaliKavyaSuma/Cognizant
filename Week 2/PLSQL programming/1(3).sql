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

INSERT INTO CUSTOMERS VALUES (1, 40, 10000, 'FALSE');
INSERT INTO CUSTOMERS VALUES (2, 55, 12000, 'FALSE');

-- Loans with due dates in next 30 days
INSERT INTO LOANS VALUES (201, 1, 7.5, SYSDATE + 10);
INSERT INTO LOANS VALUES (202, 2, 8.0, SYSDATE + 25);
-- Loan beyond 30 days
INSERT INTO LOANS VALUES (203, 1, 9.0, SYSDATE + 40);

COMMIT;

-- PL/SQL Block: Reminders for loans due soon
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Loan Due Reminders (Next 30 Days) ---');
    FOR rec IN (
        SELECT LoanID, CustomerID, DueDate
        FROM LOANS
        WHERE DueDate <= SYSDATE + 30
    ) LOOP
        DBMS_OUTPUT.PUT_LINE('Reminder: Loan ID ' || rec.LoanID || 
                             ', Customer ID: ' || rec.CustomerID || 
                             ' is due on ' || TO_CHAR(rec.DueDate, 'DD-Mon-YYYY'));
    END LOOP;
END;
/
