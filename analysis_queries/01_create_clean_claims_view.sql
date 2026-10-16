CREATE OR REPLACE VIEW view_clean_claims AS
SELECT
    c.claim_id,
    c.patient_id,
    pc.payer AS payer,
    c.procedure_category,
    COALESCE(c.billed_amount, AVG(c.billed_amount) OVER (PARTITION BY c.procedure_category)) AS billed_amount,
    c.claim_status,
    c.carc_code,
    c.denial_reason,
    c.submission_date,
    c.resolution_date,
    c.resolution_date - c.submission_date AS days_to_resolve
FROM claims c
JOIN payer_contracts pc ON UPPER(c.payer) = UPPER(pc.payer);

SELECT COUNT(*) FROM view_clean_claims;