import mysql.connector
import os
from dotenv import load_dotenv

load_dotenv()

db_host = os.getenv('DB_HOST')
db_user = os.getenv('DB_USER')
db_password = os.getenv('DB_PASSWORD')

print("DB_HOST:", db_host)
print("DB_USER:", db_user)
print("DB_PASSWORD:", db_password)

db = mysql.connector.connect(
    host=os.getenv('DB_HOST'),
    user=os.getenv('DB_USER'),
    passwd=os.getenv('DB_PASSWORD'),
    database='warehouse_management',
    raise_on_warnings=True
)

if db.is_connected():
    print("Connected to MySQL database")
else:
    print("Connection failed")

cursor = db.cursor()
cursor.execute('SELECT * FROM Users')

for i in cursor:
    print(i)
