INSERT INTO groupement_porc_gold.CGP_FCT_VENTES_ENTETE_POLESANTE
SELECT CODE_SOCIETE AS CODE_SOCIETE_PK,
	NUMERO_FACTURE AS NUM_FACTURE_PK,
	2000 + ANNEE_COMPTABLE AS ANNEE_COMPTABLE_PK,
	MOIS_COMPTABLE AS MOIS_COMPTABLE_PK,
	DATE_FACTURE AS DATE_FACTURE,
	CLIENT_CODE AS CODE_CLIENT,
	MONTANT_HORS_TAXE AS MTT_HORS_TAXE,
	MONTANT_TVA AS MTT_TVA,
	MONTANT_TOUTES_TAXES_COMPRISES AS MTT_TOUTES_TAXES_COMPRISES,
	MODE_REGLEMENT AS CODE_MODE_REGLEMENT,
	CAST(
		DATE_PARSE(
			LPAD(CAST(DATE_ECHEANCE AS VARCHAR), 6, '0'),
			'%d%m%y'
		) AS DATE
	) AS DATE_ECHEANCE,
	NOW() AS DATH_MAJ
FROM(
		SELECT 3 AS CODE_SOCIETE,
			DATE_FACTURE,
			NUMERO_FACTURE,
			client_id AS CLIENT_CODE,
			BASE_HORS_TAXE_EXONERE + BASE_HORS_TAXE_TVA_5_5 + BASE_HORS_TAXE_TVA_10 + BASE_HORS_TAXE_TVA_20 AS MONTANT_HORS_TAXE,
			MONTANT_TVA_5_5 + MONTANT_TVA_10 + MONTANT_TVA_20 AS MONTANT_TVA,
			MONTANT_TOUTES_TAXES_COMPRISES,
			DATE_ECHEANCE,
			MODE_REGLEMENT,
			MOIS_COMPTABLE,
			ANNEE_COMPTABLE
		FROM FACTURES_MENSUELLES_GROUPEMENT
		WHERE EXTRACT(
				YEAR
				FROM DATE_FACTURE
			) > YEAR(CURRENT_DATE) -3
			and LPAD(CAST(DATE_ECHEANCE AS VARCHAR), 6, '0') = '999999'
		UNION ALL
		SELECT 9 AS CODE_SOCIETE,
			DATE_FACTURE,
			NUMERO_FACTURE,
			client_id AS CLIENT_CODE,
			BASE_HORS_TAXE_EXONERE + BASE_HORS_TAXE_TVA_5_5 + BASE_HORS_TAXE_TVA_10 + BASE_HORS_TAXE_TVA_20 AS MONTANT_HORS_TAXE,
			MONTANT_TVA_5_5 + MONTANT_TVA_10 + MONTANT_TVA_20 AS MONTANT_TVA,
			MONTANT_TOUTES_TAXES_COMPRISES,
			DATE_ECHEANCE,
			MODE_REGLEMENT,
			MOIS_COMPTABLE,
			ANNEE_COMPTABLE
		FROM FACTURES_MENSUELLES_FARMAPRO
		WHERE EXTRACT(
				YEAR
				FROM DATE_FACTURE
			) > YEAR(CURRENT_DATE) -3
		UNION ALL
		SELECT 3 AS CODE_SOCIETE,
			DATE_FACTURE,
			NUMERO_FACTURE,
			client_id AS CLIENT_CODE,
			BASE_HORS_TAXE_EXONERE + BASE_HORS_TAXE_TVA_5_5 + BASE_HORS_TAXE_TVA_10 + BASE_HORS_TAXE_TVA_20 AS MONTANT_HORS_TAXE,
			MONTANT_TVA_5_5 + MONTANT_TVA_10 + MONTANT_TVA_20 AS MONTANT_TVA,
			MONTANT_TOUTES_TAXES_COMPRISES,
			DATE_ECHEANCE,
			MODE_REGLEMENT,
			MOIS_COMPTABLE,
			ANNEE_COMPTABLE
		FROM FACTURES_ANNUELLES_GROUPEMENT
		WHERE EXTRACT(
				YEAR
				FROM DATE_FACTURE
			) > YEAR(CURRENT_DATE) -3
	) PREP_CGP_FCT_FACTURATION_ENTETE_POLESANTE
WHERE CAST(NUMERO_FACTURE AS VARCHAR) LIKE '20%'