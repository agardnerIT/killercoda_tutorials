from flask import Flask, render_template, request

app = Flask(__name__)

@app.route("/")
def index():
   return render_template("index.html")

@app.route("/viewfile")
def view_file():

    filename = request.args.get('name','')

    # Read file content
    if filename == "": file_content = "NO FILENAME PROVIDED"
    else:
        try:
            with open(filename) as f:
                file_content = f.read()
        except Exception as e:
            print(e)
    return render_template("viewfile.html", file_content=file_content)

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
