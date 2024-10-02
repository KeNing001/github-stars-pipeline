import duckdb
con = duckdb.connect()
con.execute("""create table src_gharchive as select * from read_json_auto('data/gharchive_sample/*.json..gz'); """)
con.close()