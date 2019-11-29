# 备份Postgre数据库并上传到AWS S3

**克隆项目**

```
git clone https://github.com/my6889/pgdump_to_S3.git
cd pgdump_to_S3
```



**修改pgdump.env**

Such like this

```
# AWS CONFIG
AWS_ACCESS_KEY_ID=AKIDXTG*********7HQ
AWS_SECRET_ACCESS_KEY=JjfRVTBq2*****taVSNR9+SGZWlxu

# AWS S3 桶名称
AWS_BUCKET=water-bucket

# AWS S3桶下目录名
PREFIX=mattermost

# 需要备份的数据库(注意用户是否对本库有权限)
PGDUMP_DATABASE=mattermost

# 如果需要备份所有数据库，请注释第12行以及取消注释第15行！！！
#ALL_DATABASES=TRUE

# 数据库用户名和密码用户名和密码
POSTGRES_ENV_POSTGRES_USER=postgres
POSTGRES_ENV_POSTGRES_PASSWORD=n72b7fat3b76

# Postgre数据库的地址和端口
POSTGRES_PORT_5432_TCP_ADDR=192.168.17.193
POSTGRES_PORT_5432_TCP_PORT=5432
```



**开始备份**

```
docker-compose up
```

```
Creating pgdump2s3 ... done
Attaching to pgdump2s3
pgdump2s3 | Starting dump of all databases from 192.168.17.193...
pgdump2s3 | rsync to S3
pgdump2s3 | rsync to S3
pgdump2s3 | rsync to S3
upload: pgdump/PG_ALL_DB.20191129_104241.sql to s3://water-bucket/mattermost/PG_ALL_DB.20191129_104241.sql
pgdump2s3 | Done!
pgdump2s3 | Done!
pgdump2s3 | Done!
pgdump2s3 exited with code 0
```



**查看备份**

在S3控制台上已经可以看到备份文件了

![123](https://wood-bucket.oss-cn-beijing.aliyuncs.com/hexo/pgdumps39185404.png)

