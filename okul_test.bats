#!/usr/bin/env bats

CSV_FILE=$(<okul.csv )
CSV_FILE_ALL=$(<schoolAll.csv )
CSV_FILE_BOY=$(<schoolBoy.csv )
CSV_FILE_GIRL=$( cat schoolGirl.csv )
CSV_FILE_ONE=$( cat schoolOne.csv )
CSV_FILE_TWO=$( cat schoolTwo.csv )
CSV_FILE_THREE=$( cat schoolThree.csv )
CSV_FILE_FOUR=$( cat schoolFour.csv )

@test "school_all" {
  run ./okul.sh $(< cat schoolAll.csv )
  [ "$status" -eq 0 ]
}
@test "school_boy" {
  run ./okul.sh k $(< cat schoolBoy.csv )
  [ "$status" -eq 0 ]
}
@test "school_girl" {
  run ./okul.sh k
  [ "$status" -eq 0 ]
  [ "$output"=="$CSV_FILE_GIRL" ]
}
@test "school_grade_one" {
  run ./okul.sh 1
  [ "$status" -eq 0 ]
  [ "$output"=="$CSV_FILE_ONE" ]
}
@test "school_grade_two" {
  run ./okul.sh 1
  [ "$status" -eq 0 ]
  [ "$output"=="$CSV_FILE_TWO" ]
}
@test "school_grade_three" {
  run ./okul.sh 3
  [ "$status" -eq 0 ]
  [ "$output"=="$CSV_FILE_THREE" ]
}
@test "school_grade_four" {
  run ./okul.sh 4
  [ "$output"=="$CSV_FILE_FOUR" ]
}
@test "error_one" {
  run ./okul.sh error 2
  [ "$output"=='$Hata: $CSV_FILE dosyası bulunamadı' ]
}
@test "error_two" {
  run ./okul.sh error 2
  [ "$output"=='Hata: ad,soyad çakışması var' ]
}
@test "error_three" {
  run ./okul.sh error 3
  [ "$output"=='Hata: devre numarası 1-4 aralığında olmalı' ]
}
@test "error_four" {
  run ./okul.sh error 4
  [ "$output"=='Hata: sadece bir argüman girebilirsiniz' ]
}
@test "error_five" {
  run ./okul.sh error 5
  [ "$output"=='Hata: taninmayan argüman: $2' ]
}
@test "error_general" {
  run ./okul.sh error *
  [ "$output"=='Hata: bir sorun oluştu' ]
}
@test "student_print_format_by_gender" {
  run ./okul.sh student_print_format by_gender
  [ "$output"=='$grade $name $surname' ]
}
@test "student_print_format_by_grade" {
  run ./okul.sh student_print_format by_grade
  [ "$output"=='$name $surname $gender' ]
}
@test "student_print_format_all" {
  run ./okul.sh student_print_format all
  [ "$output"=='$grade $name $surname $gender' ]
}
@test "dogru cinsiyet girilmediginde hata veriyor mu" {
  run ./okul.sh r 
  [ "$status" -eq 1 ]
}
@test "dogru sınıf girilmediginde hata veriyor mu" {
  run ./okul.sh 6
  [ "$status" -eq 1 ]
}
@test "birden fazla arguman girilince hata veriyormu" {
  run ./okul.sh k 1
  [ "$status" -eq 1 ]
}
@test "dogru cinsiyet girildiginde calısıyor mu" {
  run ./okul.sh k
  [ "$status" -eq 0 ]
}
@test "dogru sınıf girildiginde calısıyor mu" {
  run ./okul.sh 1
  [ "$status" -eq 0 ]
}
