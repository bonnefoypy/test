CREATE EXTERNAL TABLE IF NOT EXISTS GROUPEMENT_PORC_GOLD.CGP_FCT_VENTES_ENTETE_POLESANTE (
    CODE_SOCIETE_PK INT COMMENT 'CODE SOCIETE PK',
    NUM_FACTURE_PK INT COMMENT 'Numéro de facture de vente',
    ANNEE_COMPTABLE_PK INT COMMENT 'Mois Comptable Vente',
    MOIS_COMPTABLE_PK INT COMMENT 'Année Comptable Vente',
    DATE_FACTURE DATE COMMENT 'Date de facture',
    CODE_CLIENT INT COMMENT 'Code Client',
    MTT_HORS_TAXE float COMMENT 'Montant Hors Taxe',
    MTT_TVA float COMMENT 'Montant TVA',
    MTT_TOUTES_TAXES_COMPRISES float COMMENT 'Montant TTC',
    CODE_MODE_REGLEMENT INT COMMENT 'Code Mode de règlement',
    DATE_ECHEANCE date COMMENT 'Date d échéance',
    DATH_MAJ TIMESTAMP COMMENT 'DATE-HEURE DE INSERT DE L ENREGISTREMENT'
) COMMENT "Table d'En-tête facturation des ventes du Pôle Santé : Farmparo & Cooperl"
ROW FORMAT SERDE 'org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe'
WITH SERDEPROPERTIES ('serialization.format' = '1')
STORED AS INPUTFORMAT 'org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat' 
OUTPUTFORMAT 'org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat'
LOCATION 's3://cooperl-gold-step-function/groupement_porc/test/CGP_FCT_VENTES_ENTETE_POLESANTE/'