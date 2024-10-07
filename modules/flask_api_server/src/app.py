from flask import Flask, jsonify
from dotenv import load_dotenv

import logging
import os
import requests

# Create the Flask application
app = Flask(__name__)

# Load environment variables
load_dotenv()

# Configuration
app.config.from_mapping(
    DEBUG=os.getenv('FLASK_DEBUG', 'false').lower() in ['true', '1'],
    FLASK_PORT=int(os.getenv('FLASK_PORT', 5000)),
    API_KEY=os.getenv('API_KEY'),
    API_URL=f"https://v6.exchangerate-api.com/v6/{os.getenv('API_KEY')}/pair/"
)

# Logger setup
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

@app.route('/', methods=['GET'])
def root():
    response = jsonify(message="path: /")
    logger.info(f"Response: {response.get_json()}")
    return response

@app.route('/health', methods=['GET'])
def health_check():
    return jsonify(status='OK'), 200

@app.route('/api/greet/<name>', methods=['GET'])
def greet(name):
    response = jsonify(message=f"Hello, {name}!")
    logger.info(f"Response: {response.get_json()}")
    return response

@app.route('/api/exchange/<currency>', methods=['GET'])
def make_request(currency):
    try:
        FULL_API_URL = f"{app.config['API_URL']}/{currency}/ILS"
        response = requests.get(FULL_API_URL)
        response.raise_for_status()  # Check if the request was successful
        logger.info(f"Response: {response}")
        res_json = response.json()
        logger.info(f"Response JSON: {res_json}")
        
        return jsonify(res_json['conversion_rate'])
    except Exception as e:
        logger.error(f"An error occurred: {e}")
        return jsonify(error="An error occurred"), 500

def run_server():
    port = app.config['FLASK_PORT']
    logger.info(f"Listening on port {port}")
    app.run(host="0.0.0.0", port=port)

if __name__ == "__main__":
    run_server()