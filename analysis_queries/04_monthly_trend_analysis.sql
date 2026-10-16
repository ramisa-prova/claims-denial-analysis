SELECT
    DATE_TRUNC('month', submission_date) AS claim_month,
    COUNT(*) AS total_claims,
    SUM(CASE WHEN claim_status != 'Paid' THEN 1 ELSE 0 END) AS denied_claims,
    ROUND(100.0 * SUM(CASE WHEN claim_status != 'Paid' THEN 1 ELSE 0 END) / COUNT(*), 1) AS denial_rate_percent
FROM view_clean_claims
GROUP BY claim_month
ORDER BY claim_month;