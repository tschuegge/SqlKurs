import sqlite3
import pandas as pd
import urllib.request
from IPython.display import display, Markdown

urllib.request.urlretrieve("https://github.com/tschuegge/SqlKurs/raw/master/database.db", "database.db")
conn = sqlite3.connect("database.db")
conn.execute("PRAGMA foreign_keys = ON")

def sql(query: str):
  cursor = conn.cursor()
  returnvalue = None
  try:
    cursor.execute(query)
    result = cursor.fetchall()
    if len(result) > 0:
      returnvalue = pd.DataFrame(result)
      returnvalue.columns = list(map(lambda elem: elem[0], cursor.description))
    else:
      returnvalue = display(Markdown("✅ **Befehl korrekt ausgeführt, kein Resultat erhalten**"))
    cursor.close()
    return returnvalue
  except sqlite3.Error as error:
    returnvalue = display(Markdown("🛑 **SQL Error**: " + str(error)))
  finally:
    cursor.close()
  return returnvalue

print("😊 Verbunden mit Sqlite " + sqlite3.sqlite_version)