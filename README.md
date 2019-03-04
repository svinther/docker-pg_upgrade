
```

PostgreSQL 8.4 datafiles should be placed here:

pgdata/8.4/data/
  
sudo rm -Rf pgdata.tmp ; sudo chown -R lgv.lgv pgdata ; cp -R -l pgdata pgdata.tmp
docker run --rm -d -v $PWD/pgdata.tmp/8.4/data:/var/lib/postgresql/data pg84
docker exec -ti d5a9ea5b0e53f8a429b684aef157302561a5dd7aff7cc8521a56c650844a8fed psql -U postgres -c "drop table public.pg_ts_dict; drop table public.pg_ts_parser" signflow
docker rm -f d5a9ea5b0e53f8a429b684aef157302561a5dd7aff7cc8521a56c650844a8fed
docker run --rm -v $PWD/pgdata.tmp:/var/lib/postgresql pgconvert



create user tmpuser;
alter user tmpuser with superuser; 
alter user postgres rename to signflow;
drop user tmpuser;
  
```
