SET SERVEROUTPUT ON;

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE SAVINGS_ACCOUNTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE SAVINGS_ACCOUNTS (
    AccountID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    Balance NUMBER
);

INSERT INTO SAVINGS_ACCOUNTS VALUES (1, 101, 10000);
INSERT INTO SAVINGS_ACCOUNTS VALUES (2, 102, 5000);

COMMIT;

-- Create stored procedure
CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest AS
BEGIN
    FOR rec IN (SELECT AccountID, Balance FROM SAVINGS_ACCOUNTS) LOOP
        UPDATE SAVINGS_ACCOUNTS
        SET Balance = Balance + (Balance * 0.01)
        WHERE AccountID = rec.AccountID;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Monthly interest processed for all savings accounts.');
END;
/

-- Run the procedure and display updated balances
BEGIN
    ProcessMonthlyInterest;

    DBMS_OUTPUT.PUT_LINE('Updated balances after interest application:');
    FOR rec IN (SELECT AccountID, CustomerID, Balance FROM SAVINGS_ACCOUNTS ORDER BY AccountID) LOOP
        DBMS_OUTPUT.PUT_LINE('AccountID: ' || rec.AccountID || 
                             ', CustomerID: ' || rec.CustomerID || 
                             ', New Balance: ' || TO_CHAR(rec.Balance, 'FM9999990.00'));
    END LOOP;
END;
/
