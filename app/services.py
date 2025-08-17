
from .repositories import AuthorRepository, BookRepository, UserRepository, ReservationRepository
from werkzeug.security import check_password_hash, generate_password_hash

class UserService:
    def __init__(self):
        self.repo = UserRepository()
        self.reservation_repo = ReservationRepository()

    def register(self, username, password):
        if self.repo.find_by_username(username):
            raise ValueError(f"Usuário '{username}' já existe.")
        
        password_hash = generate_password_hash(password)
        self.repo.create(username, password_hash)

    def check_credentials(self, username, password):
        user = self.repo.find_by_username(username)
        if user and check_password_hash(user['password_hash'], password):
            return user
        return None

    def get_profile_data(self, username, viewer_id=None):
        user = self.repo.find_by_username(username)
        if not user:
            return None, None, None, None, None

        friends = self.repo.get_friends(user['id'])
        reservations = self.reservation_repo.find_recent_by_user_id(user['id'])
        friendship_status_info = None
        friendship_status = 'self'

        if viewer_id and viewer_id != user['id']:
            friendship_status_info = self.repo.get_friendship_status(viewer_id, user['id'])
            if not friendship_status_info:
                friendship_status = 'none'
            elif friendship_status_info['status'] == 'pending':
                if friendship_status_info['requester_id'] == viewer_id:
                    friendship_status = 'pending_sent'
                else:
                    friendship_status = 'pending_received'
            elif friendship_status_info['status'] == 'accepted':
                friendship_status = 'friends'

        return user, friends, friendship_status, friendship_status_info, reservations

    def update_profile(self, user_id, bio, pfp_url):
        self.repo.update_profile(user_id, bio, pfp_url)

    def search_users(self, query, current_user_id):
        all_users = self.repo.search_users(query)
        return [user for user in all_users if user['id'] != current_user_id]
        
    def add_friend(self, requester_id, addressee_id):
        if requester_id == addressee_id:
            raise ValueError("Você não pode adicionar a si mesmo.")
        
        existing = self.repo.get_friendship_status(requester_id, addressee_id)
        if existing:
            raise ValueError("Já existe um pedido de amizade ou vocês já são amigos.")
            
        self.repo.add_friend_request(requester_id, addressee_id)
        
    def get_friend_requests(self, user_id):
        return self.repo.get_friend_requests(user_id)
        
    def respond_to_friend_request(self, requester_id, addressee_id, action):
        status = 'accepted' if action == 'accept' else 'rejected'
        self.repo.update_friend_request_status(requester_id, addressee_id, status)

class ReservationService:
    def __init__(self):
        self.repo = ReservationRepository()
        self.book_repo = BookRepository()
        
    def create_reservation(self, user_id, book_id):
        book = self.book_repo.find_by_id(book_id)
        if not book or book['status'] == 'Emprestado':
            raise ValueError("Este livro não está disponível para reserva.")
        
        self.repo.create(user_id, book_id)

    def get_user_reservations(self, user_id):
        return self.repo.find_by_user_id(user_id)

    def return_book(self, reservation_id):
        self.repo.update_status(reservation_id, 'Concluída')

class BookService:
    def __init__(self):
        self.repo = BookRepository()

    def get_all_or_search_books(self, query=None):
        if query:
            return self.repo.search(query)
        return self.repo.find_all()
    
    def get_book_by_id(self, book_id):
        return self.repo.find_by_id(book_id)

    def create_book(self, data):
        self.repo.create(
            data['title'], data.get('publication_year'), data.get('review'),
            data.get('critic_score'), data.get('cover_image_url'), data['author_id']
        )

    def update_book(self, book_id, data):
        self.repo.update(
            book_id, data['title'], data.get('publication_year'), data.get('review'),
            data.get('critic_score'), data.get('cover_image_url'), data['author_id']
        )
        
    def delete_book(self, book_id):
        self.repo.delete(book_id)

class AuthorService:
    def __init__(self):
        self.repo = AuthorRepository()

    def get_all_authors(self):
        return self.repo.find_all()

    def get_author_by_id(self, author_id):
        return self.repo.find_by_id(author_id)

    def create_author(self, data):
        self.repo.create(data['name'], data.get('birth_date'), data.get('biography'))

    def update_author(self, author_id, data):
        self.repo.update(author_id, data['name'], data.get('birth_date'), data.get('biography'))

    def delete_author(self, author_id):
        self.repo.delete(author_id)