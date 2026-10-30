from flask import Flask, request, jsonify, render_template_string

app = Flask(__name__)

students = [
    {"id": 1, "name": "Sakshi", "course": "AWS"},
    {"id": 2, "name": "Janvhi", "course": "Python"}
]

@app.route('/')
def home():
    return render_template_string("""
    <h1>Student Registration Form</h1>
    <form action="/add_student" method="POST">
        <label>Student ID:</label>
        <input type="number" name="id" required><br><br>

        <label>Student Name:</label>
        <input type="text" name="name" required><br><br>

        <label>Course:</label>
        <input type="text" name="course" required><br><br>

        <button type="submit">Submit</button>
    </form>
    """)

@app.route('/students', methods=['GET'])
def get_students():
    return jsonify(students)

@app.route('/add_student', methods=['POST'])
def add_student():
    student = {
        "id": int(request.form['id']),
        "name": request.form['name'],
        "course": request.form['course']
    }
    students.append(student)

    return f"""
    <h2>Student Added Successfully!</h2>
    <p>Name: {student['name']}</p>
    <p>Course: {student['course']}</p>
    <a href="/">Add Another Student</a><br>
    <a href="/students">View All Students</a>
    """

if _name_ == '_main_':
    app.run(host='0.0.0.0', port=5000)