创建镜像
docker build -t letote/pgdump:0.1 .


备份指定数据库
docker run -it -v ~/Downloads/tongbu:/pgdump  \
-e AWS_ACCESS_KEY_ID=******* \
-e AWS_SECRET_ACCESS_KEY=******* \
-e AWS_BUCKET=******* \
-e PREFIX=******* \
-e PGDUMP_DATABASE=*******  \
-e POSTGRES_ENV_POSTGRES_USER=******* \
-e POSTGRES_ENV_POSTGRES_PASSWORD=******* \
-e POSTGRES_PORT_5432_TCP_ADDR=******* \
-e POSTGRES_PORT_5432_TCP_PORT=******* \
letote/pgdump:0.1





备份所有数据库

docker run -it -v ~/Downloads/tongbu:/pgdump  \
-e AWS_ACCESS_KEY_ID=******* \
-e AWS_SECRET_ACCESS_KEY=******* \
-e AWS_BUCKET=******* \
-e PREFIX=******* \
-e ALL_DATABASES=TRUE \
-e POSTGRES_ENV_POSTGRES_USER=******* \
-e POSTGRES_ENV_POSTGRES_PASSWORD=******* \
-e POSTGRES_PORT_5432_TCP_ADDR=******* \
-e POSTGRES_PORT_5432_TCP_PORT=******* \
letote/pgdump:0.1


备份所有数据库需要使用pgsql的超级管理员账户，否则会有以下报错
pg_dumpall: query failed: ERROR:  permission denied for relation pg_authid
pg_dumpall: query was: SELECT oid, rolname, rolsuper, rolinherit, rolcreaterole, rolcreatedb, rolcanlogin, rolconnlimit, rolpassword, rolvaliduntil, rolreplication, rolbypassrls, pg_catalog.shobj_description(oid, 'pg_authid') as rolcomment, rolname = current_user AS is_current_user FROM pg_authid WHERE rolname !~ '^pg_' ORDER BY 2