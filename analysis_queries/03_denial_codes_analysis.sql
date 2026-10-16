SELECT
    dc.carc_code,
    dc.category,
    dc.actionable,
    COUNT(*) AS times_used,
    ROUND(SUM(vc.billed_amount), 2) AS dollars_denied,
    ROUND(AVG(vc.days_to_resolve), 1) AS avg_days_to_resolve
FROM view_clean_claims vc
JOIN denial_codes dc ON vc.carc_code = dc.carc_code
WHERE vc.claim_status != 'Paid'
GROUP BY dc.carc_code, dc.category, dc.actionable
ORDER BY dollars_denied DESC;