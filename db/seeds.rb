admin = User.find_or_create_by!(email: "admin@kampus.ac.id") do |u|
  u.name = "Admin Sarpras"
  u.role = "admin"
end

student_1 = User.find_or_create_by!(email: "filbert.ongko@kampus.ac.id") do |u|
  u.name = "Filbert Ongko"
  u.role = "student"
end

student_2 = User.find_or_create_by!(email: "budi.santoso@kampus.ac.id") do |u|
  u.name = "Budi Santoso"
  u.role = "student"
end

lab_3 = Room.find_or_create_by!(code: "LAB-03") do |r|
  r.name = "Laboratorium Full-Stack 3"
  r.capacity = 30
  r.available = true
  r.description = "Lab komputer untuk praktikum pemrograman web"
end

aula = Room.find_or_create_by!(code: "AULA-01") do |r|
  r.name = "Aula Seminar Utama"
  r.capacity = 100
  r.available = true
  r.description = "Ruang seminar kapasitas besar"
end

RoomBooking.find_or_create_by!(booking_code: "BK-2026-001") do |b|
  b.user = student_1
  b.room = lab_3
  b.start_time = Time.zone.parse("2026-12-01 09:00:00")
  b.end_time = Time.zone.parse("2026-12-01 11:00:00")
  b.purpose = "Asistensi Proyek Capstone Full-Stack"
  b.status = "pending"
end

RoomBooking.find_or_create_by!(booking_code: "BK-2026-002") do |b|
  b.user = student_2
  b.room = lab_3
  b.start_time = Time.zone.parse("2026-12-01 10:00:00")
  b.end_time = Time.zone.parse("2026-12-01 12:00:00")
  b.purpose = "Rapat Organisasi Mahasiswa"
  b.status = "pending"
end

puts "Seed selesai -> Users: #{User.count}, Rooms: #{Room.count}, Bookings: #{RoomBooking.count}"
