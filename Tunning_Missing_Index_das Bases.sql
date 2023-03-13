 -- Consulta para analisar quais indices precisam de reindex
 SELECT 
		--DB_NAME(),
		  Object_name(T.object_id) AS 'Tabela'
		, T.index_id
		, T.index_level
		, T.index_depth
		, D.name
		, T.avg_fragmentation_in_percent
		, T.page_count
	FROM sys.dm_db_index_physical_stats(db_id('master'), NULL, NULL, NULL, 'detailed') AS T --Aqui deve ser explicitado em qual banco deve ser realizaod a consulta
	INNER JOIN sys.indexes D
		ON T.Object_id = D.object_id AND T.index_id = D.index_id
	WHERE T.OBJECT_ID IS NOT NULL
		AND Avg_Fragmentation_In_Percent <> 0 --Excluir da busca os indíces não fragmentados
		AND index_type_desc != 'HEAP' --Excluir da busca as HEAPs
		AND page_count > 1000 -- Excluir da busca os índices muito pequenos
ORDER BY T.object_id