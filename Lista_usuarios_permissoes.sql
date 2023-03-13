-- Consulta que retorna todos os usuários e permissões em cada base
exec sp_msForEachDb ' 
USE [?]
SELECT DB_NAME()
        , sys.server_permissions.permission_name
        , sys.server_permissions.state
        , sys.server_permissions.state_desc
        , granteeserverprincipal.name AS grantee_principal_name
        , granteeserverprincipal.type_desc AS grantee_principal_type_desc
        , grantorserverprinicipal.name AS grantor_name
	FROM sys.server_principals AS granteeserverprincipal
	INNER JOIN sys.server_permissions
		ON sys.server_permissions.grantee_principal_id = granteeserverprincipal.principal_id
	INNER JOIN sys.server_principals AS grantorserverprinicipal
		ON grantorserverprinicipal.principal_id = sys.server_permissions.grantor_principal_id
	WHERE granteeserverprincipal.name NOT LIKE ''##%''
ORDER BY granteeserverprincipal.name, sys.server_permissions.permission_name
'