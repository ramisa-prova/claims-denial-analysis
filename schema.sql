CREATE TABLE claims (
    claim_id VARCHAR(20),
    patient_id VARCHAR(20),
    payer VARCHAR(50),
    procedure_category VARCHAR(50),
    billed_amount NUMERIC(12,2),
    claim_status VARCHAR(20),
    carc_code VARCHAR(10),
    denial_reason VARCHAR(100),
    submission_date DATE,
    resolution_date DATE
);

CREATE TABLE denial_codes (
    carc_code VARCHAR(10) PRIMARY KEY,
    category VARCHAR(50),
    actionable BOOLEAN,
    description VARCHAR(200)
);

CREATE TABLE payer_contracts (
    payer VARCHAR(50) PRIMARY KEY,
    contract_type VARCHAR(20),
    expected_reimbursement_rate NUMERIC(4,2),
    typical_appeal_turnaround_days INT
);