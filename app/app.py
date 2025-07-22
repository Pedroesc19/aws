from flask import Flask, render_template, request, redirect, url_for
import pymysql
import os

app = Flask(__name__)


def get_connection():
    return pymysql.connect(
        host=os.environ.get('DB_HOST'),
        user=os.environ.get('DB_USER'),
        password=os.environ.get('DB_PASSWORD'),
        database=os.environ.get('DB_NAME', 'store'),
        cursorclass=pymysql.cursors.DictCursor
    )


@app.route('/')
def index():
    conn = get_connection()
    with conn.cursor() as cursor:
        cursor.execute('SELECT * FROM products')
        products = cursor.fetchall()
    conn.close()
    return render_template('index.html', products=products)


@app.route('/add', methods=['POST'])
def add():
    name = request.form['name']
    quantity = int(request.form['quantity'])
    conn = get_connection()
    with conn.cursor() as cursor:
        cursor.execute('INSERT INTO products (name, quantity) VALUES (%s, %s)', (name, quantity))
    conn.commit()
    conn.close()
    return redirect(url_for('index'))


@app.route('/delete/<int:id>')
def delete(id):
    conn = get_connection()
    with conn.cursor() as cursor:
        cursor.execute('DELETE FROM products WHERE id=%s', (id,))
    conn.commit()
    conn.close()
    return redirect(url_for('index'))


@app.route('/update/<int:id>', methods=['POST'])
def update(id):
    quantity = int(request.form['quantity'])
    conn = get_connection()
    with conn.cursor() as cursor:
        cursor.execute('UPDATE products SET quantity=%s WHERE id=%s', (quantity, id))
    conn.commit()
    conn.close()
    return redirect(url_for('index'))


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
