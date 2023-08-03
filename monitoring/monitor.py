from prometheus_client import start_http_server, Gauge, Counter, Histogram
import time, psutil, psycopg2
import odoolib

# Connect to Odoo server
odoo = odoolib.get_connection(hostname='localhost', port=80, database='db', login='odoo', password='odoo')

# Define Prometheus metrics
cpu_usage = Gauge('odoo_cpu_usage', 'CPU Usage')
memory_usage = Gauge('odoo_memory_usage', 'Memory Usage')
request_count = Counter('odoo_request_count', 'Request Count')
response_time = Histogram('odoo_response_time', 'Response Time')
database_connections = Gauge('odoo_database_connections', 'Database Connections')
database_query_time = Histogram('odoo_database_query_time', 'Database Query Time')
error_count = Counter('odoo_error_count', 'Error Count')

def collect_metrics():
    cpu_percent = psutil.cpu_percent()
    cpu_usage.set(cpu_percent)

    memory = psutil.virtual_memory().percent
    memory_usage.set(memory)

    request_count.inc()

    start_time = time.time()

    response_time.observe(time.time() - start_time)

    # database_connections.set(psutil.net_connections().count())

    connection = psycopg2.connect(host='db', port=5432, user='odoo', password='odoo')
    cursor = connection.cursor()
    cursor.execute("SELECT query, total_time FROM pg_stat_statements")
    query_times = cursor.fetchall()
    cursor.close()
    connection.close()

    for query, total_time in query_times:
        database_query_time.labels(query).set(total_time)

    # Error Count
    if odoo.has_error(): 
        error_count.inc()

if __name__ == '__main__':
    start_http_server(8000)

    while True:
        collect_metrics()
        time.sleep(60) 