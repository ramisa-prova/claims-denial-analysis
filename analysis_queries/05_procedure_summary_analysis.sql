SELECT
    procedure_category,
    COUNT(*) AS total_claims,
    SUM(CASE WHEN claim_status != 'Paid' THEN 1 ELSE 0 END) AS denied_claims,
    ROUND(100.0 * SUM(CASE WHEN claim_status != 'Paid' THEN 1 ELSE 0 END) / COUNT(*), 1) AS denial_rate_percent,
    ROUND(SUM(CASE WHEN claim_status != 'Paid' THEN billed_amount ELSE 0 END), 2) AS dollars_denied
FROM view_clean_claims
GROUP BY procedure_category
ORDER BY dollars_denied DESC;
