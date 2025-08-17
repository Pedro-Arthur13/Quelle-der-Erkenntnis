
from .database import get_db
from unidecode import unidecode

class UserRepository:
    def find_by_username(self, username):
        return get_db().execute('SELECT * FROM users WHERE username = ?', (username,)).fetchone()

    def find_by_id(self, user_id):
        return get_db().execute('SELECT * FROM users WHERE id = ?', (user_id,)).fetchone()

    def create(self, username, password_hash):
        db = get_db()
        db.execute('INSERT INTO users (username, password_hash) VALUES (?, ?)', (username, password_hash))
        db.commit()

    def update_profile(self, user_id, bio, pfp_url):
        db = get_db()
        db.execute('UPDATE users SET bio = ?, pfp_url = ? WHERE id = ?', (bio, pfp_url, user_id))
        db.commit()

    def search_users(self, query):
        term = f"%{unidecode(query.lower())}%"
        return get_db().execute(
            "SELECT id, username, pfp_url FROM users WHERE unaccent(LOWER(username)) LIKE ? AND id != 0", (term,)
        ).fetchall()

    def get_friendship_status(self, user1_id, user2_id):
        return get_db().execute(
            """SELECT * FROM friendships WHERE 
               (requester_id = ? AND addressee_id = ?) OR 
               (requester_id = ? AND addressee_id = ?)""",
            (user1_id, user2_id, user2_id, user1_id)
        ).fetchone()

    def add_friend_request(self, requester_id, addressee_id):
        db = get_db()
        db.execute(
            "INSERT INTO friendships (requester_id, addressee_id, status) VALUES (?, ?, 'pending')",
            (requester_id, addressee_id)
        )
        db.commit()

    def get_friend_requests(self, user_id):
        return get_db().execute(
            """SELECT u.id, u.username, u.pfp_url FROM friendships f
               JOIN users u ON f.requester_id = u.id
               WHERE f.addressee_id = ? AND f.status = 'pending'""",
            (user_id,)
        ).fetchall()

    def update_friend_request_status(self, requester_id, addressee_id, status):
        db = get_db()
        if status == 'accepted':
            db.execute(
                "UPDATE friendships SET status = 'accepted' WHERE requester_id = ? AND addressee_id = ?",
                (requester_id, addressee_id)
            )
        else:
            db.execute(
                "UPDATE friendships SET status = 'rejected' WHERE (requester_id = ? AND addressee_id = ?) OR (requester_id = ? AND addressee_id = ?)",
                (requester_id, addressee_id, addressee_id, requester_id)
            )
        db.commit()

    def get_friends(self, user_id):
        query = """
            SELECT u.id, u.username, u.pfp_url FROM users u JOIN friendships f ON u.id = f.addressee_id
            WHERE f.requester_id = ? AND f.status = 'accepted'
            UNION
            SELECT u.id, u.username, u.pfp_url FROM users u JOIN friendships f ON u.id = f.requester_id
            WHERE f.addressee_id = ? AND f.status = 'accepted'
            ORDER BY username
        """
        return get_db().execute(query, (user_id, user_id)).fetchall()

class BookRepository:
    _BASE_QUERY = """
        SELECT
            b.id, b.title, b.publication_year, b.review, b.critic_score, b.cover_image_url,
            a.id as author_id, a.name as author_name,
            CASE
                WHEN EXISTS (SELECT 1 FROM reservations r WHERE r.book_id = b.id AND r.status = 'Ativa')
                THEN 'Emprestado'
                ELSE 'Disponível'
            END as status
        FROM books b
        JOIN authors a ON b.author_id = a.id
    """

    def find_all(self):
        return get_db().execute(f'{self._BASE_QUERY} ORDER BY b.title').fetchall()

    def find_by_id(self, book_id):
        return get_db().execute(f'{self._BASE_QUERY} WHERE b.id = ?', (book_id,)).fetchone()

    def search(self, query):
        search_term = f'%{query}%'
        return get_db().execute(
            f'{self._BASE_QUERY} WHERE b.title LIKE ? OR a.name LIKE ? ORDER BY b.title',
            (search_term, search_term)
        ).fetchall()
    
    def create(self, title, pub_year, review, score, cover_url, author_id):
        db = get_db()
        db.execute(
            "INSERT INTO books (title, publication_year, review, critic_score, cover_image_url, author_id) VALUES (?, ?, ?, ?, ?, ?)",
            (title, pub_year, review, score, cover_url, author_id)
        )
        db.commit()

    def update(self, book_id, title, pub_year, review, score, cover_url, author_id):
        db = get_db()
        db.execute(
            "UPDATE books SET title = ?, publication_year = ?, review = ?, critic_score = ?, cover_image_url = ?, author_id = ? WHERE id = ?",
            (title, pub_year, review, score, cover_url, author_id, book_id)
        )
        db.commit()

    def delete(self, book_id):
        db = get_db()
        db.execute('DELETE FROM books WHERE id = ?', (book_id,))
        db.commit()

class ReservationRepository:
    def create(self, user_id, book_id):
        db = get_db()
        db.execute(
            "INSERT INTO reservations (user_id, book_id, status) VALUES (?, ?, 'Ativa')",
            (user_id, book_id)
        )
        db.commit()

    def find_active_by_book_id(self, book_id):
        return get_db().execute("SELECT * FROM reservations WHERE book_id = ? AND status = 'Ativa'", (book_id,)).fetchone()
        
    def find_by_user_id(self, user_id):
        return get_db().execute("""
            SELECT r.id, r.status, r.reservation_date, b.title, b.id as book_id
            FROM reservations r
            JOIN books b ON r.book_id = b.id
            WHERE r.user_id = ?
            ORDER BY r.reservation_date DESC
        """, (user_id,)).fetchall()
        
    def find_recent_by_user_id(self, user_id, limit=5):
        return get_db().execute("""
            SELECT 
                r.reservation_date, 
                b.id as book_id, 
                b.title, 
                b.cover_image_url
            FROM reservations r
            JOIN books b ON r.book_id = b.id
            WHERE r.user_id = ?
            ORDER BY r.reservation_date DESC
            LIMIT ?
        """, (user_id, limit)).fetchall()

    def update_status(self, reservation_id, status):
        db = get_db()
        db.execute('UPDATE reservations SET status = ? WHERE id = ?', (status, reservation_id))
        db.commit()

class AuthorRepository:
    def find_all(self):
        return get_db().execute('SELECT * FROM authors ORDER BY name').fetchall()

    def find_by_id(self, author_id):
        return get_db().execute('SELECT * FROM authors WHERE id = ?', (author_id,)).fetchone()

    def create(self, name, birth_date, biography):
        db = get_db()
        db.execute('INSERT INTO authors (name, birth_date, biography) VALUES (?, ?, ?)', (name, birth_date, biography))
        db.commit()

    def update(self, author_id, name, birth_date, biography):
        db = get_db()
        db.execute('UPDATE authors SET name = ?, birth_date = ?, biography = ? WHERE id = ?', (name, birth_date, biography, author_id))
        db.commit()

    def delete(self, author_id):
        db = get_db()
        db.execute('DELETE FROM authors WHERE id = ?', (author_id,))
        db.commit()