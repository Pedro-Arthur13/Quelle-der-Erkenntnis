# Quelle der Erkenntnis - Biblioteca Online

![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge\&logo=python\&logoColor=white) ![Flask](https://img.shields.io/badge/Flask-000000?style=for-the-badge\&logo=flask\&logoColor=white) ![SQLite](https://img.shields.io/badge/SQLite-003B57?style=for-the-badge\&logo=sqlite\&logoColor=white) ![Bootstrap](https://img.shields.io/badge/Bootstrap-7952B3?style=for-the-badge\&logo=bootstrap\&logoColor=white)

**Quelle der Erkenntnis** (Fonte do Conhecimento) é uma aplicação web full-stack desenvolvida com Python e o microframework Flask. O projeto simula uma biblioteca online completa, permitindo que os usuários explorem um vasto acervo de livros, gerenciem autores, reservem obras para leitura e interajam socialmente com outros leitores.

A aplicação foi construída com uma arquitetura de serviços e repositórios, garantindo um código limpo, organizado e escalável.

---

## Funcionalidades Principais

* **📚 Catálogo de Livros:** Visualização do acervo completo, com capas, resenhas e notas da crítica.
* **🔍 Sistema de Busca:** Pesquisa dinâmica por título de livro ou nome de autor.
* **👤 Autenticação de Usuários:** Sistema seguro de registro, login e logout.
* **✏️ Gerenciamento (CRUD):** Adicionar, editar e excluir livros e autores.
* **📅 Sistema de Reservas:** Empréstimo e devolução de livros com status atualizado em tempo real.
* **👥 Rede Social de Leitores:**

  * Perfis de usuário com foto, biografia e lista de amigos.
  * Busca por outros usuários.
  * Sistema de pedidos de amizade.
  * Feed de atividade recente.
* **🔔 Notificações:** Alertas visuais para novos pedidos de amizade.
* **🎨 Interface Moderna:** Design responsivo com Bootstrap e animações interativas.
* **📄 Páginas Personalizadas:** Página "Sobre" e erro 404 amigável.

---

## Tecnologias Utilizadas

* **Backend:** Python, Flask
* **Banco de Dados:** SQLite
* **Frontend:** HTML5, CSS3, Bootstrap 5, JavaScript
* **Bibliotecas Python Notáveis:** Werkzeug, Unidecode, Click
* **Bibliotecas Frontend:** SweetAlert2, AOS

---

## Estrutura do Projeto

```
.
├── run.py                  # Ponto de entrada da aplicação
└── app/
    ├── __init__.py         # Inicializador do app Flask (Factory)
    ├── database.py         # Configuração do banco de dados
    ├── repositories.py     # Camada de acesso aos dados (SQL)
    ├── routes.py           # Definição das rotas e views
    ├── schema.sql          # Script de criação do banco
    ├── services.py         # Camada de lógica de negócios
    ├── static/
    │   └── css/
    │       └── style.css   # Estilos principais
    └── templates/          # HTML com Jinja2
        ├── 404.html
        ├── about.html
        ├── base.html
        ├── welcome.html
        ├── auth/
        ├── authors/
        ├── books/
        ├── partials/
        ├── reservations/
        └── users/
```

---

## Instalação e Execução

### Pré-requisitos

* Python 3.6+
* `pip`

### 1. Clone o repositório

```bash
git clone https://github.com/Pedro-Arthur13/Quelle-der-Erkenntnis.git
cd Quelle-der-Erkenntnis
```

### 2. Crie e ative um ambiente virtual

```bash
# macOS/Linux
python3 -m venv venv
source venv/bin/activate

# Windows
python -m venv venv
.\venv\Scripts\activate
```

### 3. Instale as dependências

```bash
pip install Flask Werkzeug unidecode click
```

### 4. Inicialize o banco de dados

```bash
flask init-db
```

Mensagem esperada:
`Banco de dados inicializado.`

### 5. Execute a aplicação

```bash
flask run
```

A aplicação estará rodando em:
[http://127.0.0.1:5000](http://127.0.0.1:5000)

---

## Como Usar

1. **Crie uma conta:** registre-se na plataforma.
2. **Explore o acervo:** navegue pelos livros ou use a busca.
3. **Adicione conteúdo:** ao logar, você pode cadastrar autores e livros.
4. **Interaja:** encontre leitores, envie pedidos de amizade e acompanhe perfis.
5. **Gerencie seu perfil:** personalize sua biografia e acompanhe atividades.

---

Desenvolvido por [**Arthur**](https://github.com/Pedro-Arthur13)
