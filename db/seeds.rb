School.destroy_all

school_1 = School.create!(name: 'School №1')
school_2 = School.create!(name: 'School №2')

class_1a = school_1.school_classes.create!(
  number: 1,
  letter: 'A'
)

class_1b = school_1.school_classes.create!(
  number: 1,
  letter: 'B'
)

class_2a = school_2.school_classes.create!(
  number: 2,
  letter: 'A'
)

[
  {
    first_name: 'Ivan',
    last_name: 'Ivanovich',
    surname: 'Petrov',
    school: school_1,
    school_class: class_1a
  },
  {
    first_name: 'Maria',
    last_name: 'Sergeevna',
    surname: 'Sidorova',
    school: school_1,
    school_class: class_1a
  },
  {
    first_name: 'Alexey',
    last_name: 'Nikolaevich',
    surname: 'Smirnov',
    school: school_1,
    school_class: class_1b
  },
  {
    first_name: 'Anna',
    last_name: 'Vladimirovna',
    surname: 'Kuznetsova',
    school: school_2,
    school_class: class_2a
  }
].each do |attributes|
  Student.create!(attributes)
end

puts "Created #{School.count} schools"
puts "Created #{SchoolClass.count} classes"
puts "Created #{Student.count} students"
