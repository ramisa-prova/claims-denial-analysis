WITH payer_summary AS (
    SELECT
        vc.payer,
        COUNT(*) AS total_claims,
        SUM(CASE WHEN vc.claim_status != 'Paid' THEN 1 ELSE 0 END) AS denied_claims,
        SUM(CASE WHEN vc.claim_status != 'Paid' THEN vc.billed_amount ELSE 0 END) AS dollars_denied
    FROM view_clean_claims vc
    GROUP BY vc.payer
)
SELECT
    ps.payer,
    pc.contract_type,
    ps.total_claims,
    ps.denied_claims,
    ROUND(100.0 * ps.denied_claims / ps.total_claims, 1) AS denial_rate_percent,
    ROUND(ps.dollars_denied, 2) AS dollars_denied,
    RANK() OVER (ORDER BY ps.dollars_denied DESC) AS risk_rank
FROM payer_summary ps
JOIN payer_contracts pc ON ps.payer = pc.payer
ORDER BY risk_rank;