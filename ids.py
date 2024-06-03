import time
import re
from collections import defaultdict

LOG_FILE = "access.log"
ALERT_FILE = "alerts.log"
MAX_ATTEMPTS = 5
TIME_WINDOW = 60  # seconds

# Dictionnaire pour stocker les tentatives de connexion
login_attempts = defaultdict(list)

def check_intrusion():
    with open(LOG_FILE, "r") as file:
        lines = file.readlines()

    for line in lines:
        match = re.search(r'(\d+\.\d+\.\d+\.\d+).*"POST /authentification', line)
        if match:
            ip_address = match.group(1)
            timestamp = time.time()
            login_attempts[ip_address].append(timestamp)

            # Supprimer les tentatives plus anciennes que TIME_WINDOW
            login_attempts[ip_address] = [t for t in login_attempts[ip_address] if t > timestamp - TIME_WINDOW]

            if len(login_attempts[ip_address]) > MAX_ATTEMPTS:
                log_alert(ip_address)

def log_alert(ip_address):
    with open(ALERT_FILE, "a") as alert_file:
        alert_file.write(f"Intrusion detected from IP: {ip_address} at {time.ctime()}\n")
    print(f"Intrusion detected from IP: {ip_address}")

if __name__ == "__main__":
    while True:
        check_intrusion()
        time.sleep(10)
