-- Health Facts Events
-- From data dictionary: 
--	Clinical Event Facts – Each record in the clinical event fact table
--	has a different event per event time and result. The same encounter
--	can have many records in this table. Clinical events were new in 2009
--	and at this time not all contributors are providing these.
--
-- Height event codes:
--	178         Height
--	179         Height, Body Surface Area
--	180         Height, Estimated
--	181         Height, Feet
--	182         Height, Inches
--	183         Height, Measured
--	184         Height, Percent
--	185         Height, Percent for Age
--
SELECT
	COUNT(DISTINCT fce.encounter_id) AS "encounter_count",
	COUNT(DISTINCT fe.patient_id) AS "patient_count",
	dec.event_code_desc,
	dec.event_code_display,
	dec.event_code_group,
	dec.event_code_category
FROM	
        hf_f_clinical_event fce
JOIN
	hf_f_encounter fe ON fce.encounter_id = fe.encounter_id
JOIN
	hf_d_event_code dec ON fce.event_code_id = dec.event_code_id
WHERE
	dec.event_code_desc LIKE 'Height%'
	AND fce.result_value_num IS NOT NULL
        AND fe.admitted_dt_tm BETWEEN CAST('2013-01-01' AS date) AND CAST('2013-12-31' AS date)
GROUP BY
	dec.event_code_desc,
	dec.event_code_display,
	dec.event_code_group,
	dec.event_code_category
ORDER BY
	encounter_count DESC
	;
--
--
