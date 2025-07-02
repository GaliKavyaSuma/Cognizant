SET SERVEROUTPUT ON;

BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE BANK_ACCOUNTS';
EXCEPTION WHEN OTHERS THEN NULL;
END;
/

CREATE TABLE BANK_ACCOUNTS (
    AccountID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    Balance NUMBER
);

INSERT INTO BANK_ACCOUNTS VALUES (1, 101, 10000);
INSERT INTO BANK_ACCOUNTS VALUES (2, 102, 3000);

COMMIT;

-- Create stored procedure to transfer funds
CREATE OR REPLACE PROCEDURE TransferFunds (
    p_FromAccount IN NUMBER,
    p_ToAccount IN NUMBER,
    p_Amount IN NUMBER
) AS
    v_FromBalance NUMBER;
BEGIN
    -- Get balance of source account
    SELECT Balance INTO v_FromBalance
    FROM BANK_ACCOUNTS
    WHERE AccountID = p_FromAccount;

    -- Check sufficient funds
    IF v_FromBalance < p_Amount THEN
        RAISE_APPLICATION_ERROR(-20001, 'Insufficient funds in source account.');
    END IF;

    -- Perform transfer
    UPDATE BANK_ACCOUNTS
    SET Balance = Balance - p_Amount
    WHERE AccountID = p_FromAccount;

    UPDATE BANK_ACCOUNTS
    SET Balance = Balance + p_Amount
    WHERE AccountID = p_ToAccount;

    DBMS_OUTPUT.PUT_LINE('Transfer of ' || TO_CHAR(p_Amount, 'FM9999990.00') || 
                         ' from Account ' || p_FromAccount || ' to Account ' || p_ToAccount || ' successful.');

    -- Display updated balances
    DBMS_OUTPUT.PUT_LINE('Updated balances:');
    FOR rec IN (SELECT AccountID, CustomerID, Balance FROM BANK_ACCOUNTS ORDER BY AccountID) LOOP
        DBMS_OUTPUT.PUT_LINE('AccountID: ' || rec.AccountID || 
                             ', CustomerID: ' || rec.CustomerID || 
                             ', Balance: ' || TO_CHAR(rec.Balance, 'FM9999990.00'));
    END LOOP;
END;
/

-- Run the procedure
BEGIN
    TransferFunds(1, 2, 2000);
END;
/
