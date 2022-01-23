import sqlite3
import pandas as pd
import urllib.request

urllib.request.urlretrieve("https://github.com/tschuegge/SqlKurs/raw/master/database.db", "database.db")
conn = sqlite3.connect("database.db")
conn.execute("PRAGMA foreign_keys = ON")

def query(query):
  return pd.read_sql_query(query, conn)

print("😊 Verbunden mit Sqlite " + sqlite3.sqlite_version)