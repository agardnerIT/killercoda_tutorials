from flask import Flask
from flask import request
from flask import render_template
import sqlite3
from flask import g

DATABASE = "param_enumeration_database.db"
app = Flask(__name__)

def get_db():
    db = getattr(g, '_database', None)
    if db is None:
        db = g._database = sqlite3.connect(DATABASE)
    return db

def init_db():
    with app.app_context():
        db = get_db()
        with app.open_resource('schema.sql', mode='r') as f:
            db.cursor().executescript(f.read())
        db.commit()

@app.teardown_appcontext
def close_connection(exception):
    db = getattr(g, '_database', None)
    if db is not None:
        db.close()

def query_db(query, args=(), one=False):
    cur = get_db().execute(query, args)
    rv = cur.fetchall()
    cur.close()
    return (rv[0] if rv else None) if one else rv

@app.route('/')
def index():
    firstname = 'none'
    lastname = 'none'
    emailaddress= 'none@none.com'

    user_id = request.args.get("id")
    try:
        user_id = int(user_id)
    except:
        print("user id is not an int")
        return render_template('unsubscribe.html', firstname=firstname, lastname=lastname, email=emailaddress)

    if user_id is None or not isinstance(user_id,int) or user_id < 0:
      return render_template('unsubscribe.html', firstname=firstname, lastname=lastname, email=emailaddress)

    try:
        sql_query = f"SELECT rowid, firstname, lastname, email FROM Accounts WHERE rowid={user_id}"
        output = query_db(sql_query)

        for row in output:
            firstname = row[1]
            lastname = row[2]
            emailaddress = row[3]
    except Exception as e:
        print(e)
    return render_template('unsubscribe.html', firstname=firstname, lastname=lastname, email=emailaddress)
    

if __name__ == "__main__":
    init_db()
    app.run(host="0.0.0.0", port=5000)