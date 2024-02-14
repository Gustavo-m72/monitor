import socket
import psutil
import json
import mysql.connector

conn = mysql.connector.connect(
  host="localhost",
  user="root",
  password="",
  database="computador"
)
c = conn.cursor()

HOST = "192.168.0.126"

PORT = 5000

udp = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
dest = (HOST, PORT)
#msg = 

orig = (HOST, PORT)
udp.bind(orig)
while(True):
    ram = psutil.virtual_memory().percent
    cpu = psutil.cpu_percent()
    disco = psutil.disk_usage('/').percent
    processos = [proc.info for proc in psutil.process_iter(['name', 'pid'])]
    
    data = {
    'memoriaram': ram,
    'cpu': cpu,
    'disco': disco,
    #'processos': processos,
    }
    data = json.dumps(data).encode('utf-8')
    udp.sendto (data, dest)
    #msg = input()
    msg  = udp.recvfrom(1024)
    
    dados = json.loads(msg[0].decode('utf-8'))
    ip = msg[1][0]
    c.execute("SELECT * FROM computador WHERE IP = %s", (str(ip),))
    row = c.fetchone()

    if not row:
        c.execute("INSERT INTO computador (IP, RAM, CPU, DISCO) VALUES (%s, %s, %s, %s)",
              (ip, dados['memoriaram'], dados['cpu'], dados['disco']))
        print(msg)
        conn.commit()
    else:
        c.execute("UPDATE computador SET RAM = %s, CPU = %s, DISCO = %s WHERE IP = %s",
          (dados['memoriaram'], dados['cpu'], dados['disco'], ip))
        print(msg)
        conn.commit()
conn.close()