-- Health Facts Diagnoses
-- Diabetes Codes: all kidney diseases, ICD9 and ICD10
--
SELECT
	dd.diagnosis_id,
	dd.diagnosis_type,
	dd.diagnosis_code,
	dd.diagnosis_description
FROM	
	hf_d_diagnosis dd
WHERE
	dd.diagnosis_description ILIKE '%kidney%'
	AND NOT (dd.diagnosis_type = 'ICD9' AND (dd.diagnosis_code ~ '^[EOV]' OR dd.diagnosis_code ~ '^(866|996)' ))
	AND NOT (dd.diagnosis_type = 'ICD10-CM' AND dd.diagnosis_code ~ '^[EORSTZ]')
ORDER BY
	dd.diagnosis_type,
	dd.diagnosis_code
	;
--
