-- Consulta para analisar quais os 5 scripts que mais demoraram para rodar desde a reinicialização
SELECT TOP 5
		 DB_NAME(qt.dbid)
		,SUBSTRING(qt.text, (qs.statement_start_offset/2)+1, 
		((CASE qs.statement_end_offset
			WHEN -1 THEN DATALENGTH(qt.text)
			ELSE qs.statement_end_offset
			END - qs.statement_start_offset)/2)+1)
		,avg_logical_reads_MB=((qs.total_logical_reads/qs.execution_count)*8)/1024.
		,qs.execution_count
		--,qs.total_logical_reads
		--,qs.last_logical_reads
		--,qs.min_logical_reads
		--,qs.max_logical_reads
		--,qs.total_elapsed_time
		--,qs.last_elapsed_time
		--,qs.min_elapsed_time
		,qs.max_elapsed_time
		,qs.last_execution_time
		,qp.query_plan 
	FROM sys.dm_exec_query_stats qs (nolock)
	CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) qt 
	CROSS APPLY sys.dm_exec_query_plan(qs.plan_handle) qp 
	WHERE qt.encrypted=0 AND DB_NAME(qt.dbid) = 'master' --Colocar o nome da base que você deseja consultar
ORDER BY [avg_logical_reads_MB] DESC