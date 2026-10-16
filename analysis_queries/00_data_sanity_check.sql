SELECT 'claims' AS table_name, COUNT(*) AS row_count FROM claims
UNION ALL
SELECT 'denial_codes', COUNT(*) FROM denial_codes
UNION ALL
SELECT 'payer_contracts', COUNT(*) FROM payer_contracts;
