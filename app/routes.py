
from flask import (
    Blueprint, render_template, request, redirect, url_for,
    flash, abort, session, g
)
from .services import AuthorService, BookService, UserService, ReservationService
import functools

bp = Blueprint('main', __name__)

author_service = AuthorService()
book_service = BookService()
user_service = UserService()
reservation_service = ReservationService()

def login_required(view):
    @functools.wraps(view)
    def wrapped_view(**kwargs):
        if g.user is None:
            flash('Você precisa estar logado para acessar esta página.', 'warning')
            return redirect(url_for('main.login'))
        return view(**kwargs)
    return wrapped_view

@bp.before_app_request
def load_logged_in_user():
    user_id = session.get('user_id')
    if user_id is None:
        g.user = None
        g.friend_requests = []
    else:
        g.user = user_service.repo.find_by_id(user_id)
        if g.user:
            g.friend_requests = user_service.get_friend_requests(g.user['id'])
        else:
            g.friend_requests = []

@bp.app_errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404

@bp.route('/register', methods=('GET', 'POST'))
def register():
    if g.user: return redirect(url_for('main.index'))
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        try:
            user_service.register(username, password)
            flash('Usuário registrado com sucesso! Faça o login.', 'success')
            return redirect(url_for('main.login'))
        except (ValueError, KeyError) as e:
            flash(str(e) or 'Dados inválidos.', 'danger')
    return render_template('auth/register.html')

@bp.route('/login', methods=('GET', 'POST'))
def login():
    if g.user: return redirect(url_for('main.index'))
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        user = user_service.check_credentials(username, password)
        if user:
            session.clear()
            session['user_id'] = user['id']
            flash(f'Bem-vindo(a), {user["username"]}!', 'success')
            return redirect(url_for('main.index'))
        flash('Usuário ou senha inválidos.', 'danger')
    return render_template('auth/login.html')
    
@bp.route('/logout')
def logout():
    session.clear()
    flash('Você saiu da sua conta.', 'info')
    return redirect(url_for('main.index'))

@bp.route('/')
def index():
    return render_template('welcome.html')

@bp.route('/about')
def about():
    return render_template('about.html')

@bp.route('/books')
def list_books():
    query = request.args.get('search')
    books = book_service.get_all_or_search_books(query)
    return render_template('books/list_books.html', books=books, search_query=query)

@bp.route('/books/<int:book_id>')
def book_detail(book_id):
    book = book_service.get_book_by_id(book_id)
    if book is None: abort(404)
    return render_template('books/book_detail.html', book=book)

@bp.route('/books/new', methods=('GET', 'POST'))
@login_required
def new_book():
    if request.method == 'POST':
        book_service.create_book(request.form)
        flash('Livro adicionado com sucesso!', 'success')
        return redirect(url_for('main.list_books'))
    authors = author_service.get_all_authors()
    return render_template('books/form_book.html', authors=authors)

@bp.route('/books/<int:book_id>/edit', methods=('GET', 'POST'))
@login_required
def edit_book(book_id):
    book = book_service.get_book_by_id(book_id)
    if book is None: abort(404)
    if request.method == 'POST':
        book_service.update_book(book_id, request.form)
        flash('Livro atualizado com sucesso!', 'success')
        return redirect(url_for('main.book_detail', book_id=book_id))
    authors = author_service.get_all_authors()
    return render_template('books/form_book.html', book=book, authors=authors)

@bp.route('/books/<int:book_id>/delete', methods=('POST',))
@login_required
def delete_book(book_id):
    if book_service.get_book_by_id(book_id) is None: abort(404)
    book_service.delete_book(book_id)
    flash('Livro excluído com sucesso!', 'danger')
    return redirect(url_for('main.list_books'))

@bp.route('/authors')
def list_authors():
    authors = author_service.get_all_authors()
    return render_template('authors/list_authors.html', authors=authors)

@bp.route('/authors/new', methods=('GET', 'POST'))
@login_required
def new_author():
    if request.method == 'POST':
        author_service.create_author(request.form)
        flash('Autor adicionado com sucesso!', 'success')
        return redirect(url_for('main.list_authors'))
    return render_template('authors/form_author.html')

@bp.route('/authors/<int:author_id>/edit', methods=('GET', 'POST'))
@login_required
def edit_author(author_id):
    author = author_service.get_author_by_id(author_id)
    if author is None: abort(404)
    if request.method == 'POST':
        author_service.update_author(author_id, request.form)
        flash('Autor atualizado com sucesso!', 'success')
        return redirect(url_for('main.list_authors'))
    return render_template('authors/form_author.html', author=author)

@bp.route('/authors/<int:author_id>/delete', methods=('POST',))
@login_required
def delete_author(author_id):
    try:
        author_service.delete_author(author_id)
        flash('Autor excluído com sucesso!', 'danger')
    except Exception:
        flash('Não é possível excluir um autor que possui livros cadastrados.', 'warning')
    return redirect(url_for('main.list_authors'))

@bp.route('/books/<int:book_id>/reserve', methods=('POST',))
@login_required
def reserve_book(book_id):
    try:
        reservation_service.create_reservation(g.user['id'], book_id)
        flash('Livro agendado com sucesso!', 'success')
    except ValueError as e:
        flash(str(e), 'danger')
    return redirect(url_for('main.book_detail', book_id=book_id))

@bp.route('/my_reservations')
@login_required
def my_reservations():
    reservations = reservation_service.get_user_reservations(g.user['id'])
    return render_template('reservations/my_reservations.html', reservations=reservations)

@bp.route('/reservations/<int:reservation_id>/return', methods=('POST',))
@login_required
def return_book(reservation_id):
    user_reservations = reservation_service.get_user_reservations(g.user['id'])
    if any(r['id'] == reservation_id and r['status'] == 'Ativa' for r in user_reservations):
        reservation_service.return_book(reservation_id)
        flash('Livro devolvido com sucesso.', 'info')
    else:
        flash('Operação não permitida.', 'danger')
    return redirect(url_for('main.my_reservations'))

@bp.route('/users')
@login_required
def users_list():
    query = request.args.get('q', '')
    users = user_service.search_users(query, g.user['id'])
    return render_template('users/list.html', users=users, search_query=query)

@bp.route('/profile/<username>')
@login_required
def profile(username):
    user, friends, status, status_info, reservations = user_service.get_profile_data(username, g.user['id'])
    if not user: abort(404)
    
    friend_requests = []
    if g.user['id'] == user['id']:
        friend_requests = user_service.get_friend_requests(g.user['id'])

    return render_template(
        'users/profile.html', 
        user=user, 
        friends=friends, 
        friendship_status=status,
        friend_requests=friend_requests,
        reservations=reservations
    )

@bp.route('/profile/edit', methods=('GET', 'POST'))
@login_required
def edit_profile():
    if request.method == 'POST':
        bio = request.form.get('bio', '')
        pfp_url = request.form.get('pfp_url', g.user['pfp_url'])
        user_service.update_profile(g.user['id'], bio, pfp_url)
        flash('Perfil atualizado com sucesso!', 'success')
        return redirect(url_for('main.profile', username=g.user['username']))
    return render_template('users/edit_profile.html', user=g.user)

@bp.route('/friend/request/<int:user_id>', methods=('POST',))
@login_required
def send_friend_request(user_id):
    try:
        user_service.add_friend(g.user['id'], user_id)
        flash('Pedido de amizade enviado!', 'success')
    except ValueError as e:
        flash(str(e), 'danger')
    target_user = user_service.repo.find_by_id(user_id)
    return redirect(url_for('main.profile', username=target_user['username']))

@bp.route('/friend/respond/<int:requester_id>/<action>', methods=('POST',))
@login_required
def respond_to_friend_request(requester_id, action):
    user_service.respond_to_friend_request(requester_id, g.user['id'], action)
    flash('Amizade aceita!' if action == 'accept' else 'Pedido recusado.', 'success' if action == 'accept' else 'info')
    return redirect(url_for('main.profile', username=g.user['username']))