import psycopg2
try:
    connection=psycopg2.connect(
        host='localhost',
        user='postgres',
        password='Andy1r1m4n',
        database='postgres'
    )
    cursor=connection.cursor()
    cursor.execute("SELECT trip.trip_id, trip.departure_at, trip.arrival_at, trip.route_name, trip.vehicle_capacity, reservation.total_price, (SELECT (((((trip.vehicle_capacity-reservation.seats))*100)/trip.vehicle_capacity)-100)*-1 as occupancy) FROM trip JOIN reservation ON trip.trip_id = reservation.trip_id WHERE trip.departure_at BETWEEN '01-11-2017' AND '30-11-2017'")
    rows=cursor.fetchall()
    for row in rows:
        row.to_excel('Export/prueba.xlsx')
        print(row)
    
    
except Exception as ex:
    print(ex)
