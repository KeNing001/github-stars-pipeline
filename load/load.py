import os 
import zipfile 
import duckdb 

def extract_zip_file(zip_file_path, target_dir): 
    # implement logic to extract zip file here 
    with zipfile.ZipFile(zip_file_path, 'r') as zip_ref:
            zip_ref.extractall(target_dir) 

def load_json_gz_files_in_duck_db(json_dir): 
    # implement logic to load json.gz files in duckdb here 
    con = duckdb.connect("github_stars.db")
    con.sql("CREATE SCHEMA IF NOT EXISTS source")
    con.sql(f"""
        CREATE OR REPLACE TABLE source.src_gharchive AS 
        SELECT * FROM read_json_auto('{os.path.join(json_dir, '*.json.gz')}');
    """)
    con.table("source.src_gharchive").show() # Total Row: 244,066 (6 extra?)
    con.close()

if __name__ == "__main__": 
    data_dir = os.path.join(os.path.dirname(__file__), "..", "data") 

    zip_file_path = os.path.join(data_dir, "gharchive_sample.zip") 
    temp_folder = "./tmp" 
    extract_zip_file(zip_file_path, temp_folder) 

    unpacked_zip_dir = os.path.join(temp_folder, "gharchive_sample") 
    load_json_gz_files_in_duck_db(unpacked_zip_dir)     