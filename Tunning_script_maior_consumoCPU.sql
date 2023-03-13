-- Consulta para analisar quais script mais consumiram CPU desde a reinicialização
WITH eqs AS (
	SELECT 
			[execution_count] AS [N_execucoes]
			,[total_worker_time]/1000  AS [TotalCPUTime_ms]
			,[total_elapsed_time]/1000  AS [TotalDuration_ms]
			--,query_hash
			,plan_handle
			,[sql_handle]
		FROM sys.dm_exec_query_stats
)
	SELECT TOP 5
	     DB_NAME(info.dbid) AS db
		 , eqs.N_execucoes, eqs.TotalCPUTime_ms, eqs.TotalDuration_ms
		 , dados.text
		FROM eqs
		OUTER APPLY sys.dm_exec_query_plan(eqs.plan_handle) AS info
		OUTER APPLY sys.dm_exec_sql_text(eqs.sql_handle) AS dados
		WHERE DB_NAME(info.dbid) = 'master' --Colocar o nome da base que você deseja consultar
	ORDER BY [TotalCPUTime_ms] DESC