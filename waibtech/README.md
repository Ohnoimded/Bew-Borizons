# Assignment for waibtech Pre-Interview Round

### San Franciso Symphony Orchestra Website Scraper with LLM recommender

## Installation

1. Navigate to the `waib` directory:
    ```bash
    cd waib
    ```
2. Set up a virtual environment:
    ```bash
    python -m venv .venv
    ```
3. Activate the virtual environment (for Windows):
    ```bash
    .venv\Scripts\Activate
    ```
4. Install the required packages:
    ```bash
    pip install -r requirements.txt
    ```

5. Create a MySQL database with the following credentials (listed in `settings.py`):
    ```plaintext
    DATABASE NAME: waib
    USER: root
    PASSWORD: password
    HOST: 127.0.0.1
    PORT: 3306
    ```
    Example command to create the database:
    ```sql
    CREATE DATABASE waib;
    ```

## Starting the Server

1. Create initial migrations:
    ```bash
    python manage.py makemigrations
    ```
2. Apply migrations:
    ```bash
    python manage.py migrate
    ```
3. Start the development server:
    ```bash
    python manage.py runserver
    ```

## Usage

### Creation Endpoint
To save an entity, use the following API:
- **URL**: `http://127.0.0.1:8000/api/save-entity/?url=`
- **Example**: 
    ```plaintext
    http://127.0.0.1:8000/api/save-entity/?url=https://www.sfsymphony.org/Buy-Tickets/2024-25/Salonen-Nico-Muhly
    ```

### Fetch Endpoint
To fetch an entity, use the following API:
- **URL**: `http://127.0.0.1:8000/api/get-entity/?url=`
- **Example**:
    ```plaintext
    http://127.0.0.1:8000/api/get-entity/?url=https://www.sfsymphony.org/Buy-Tickets/2024-25/Salonen-Nico-Muhly
    ```
