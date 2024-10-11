add_grades() {
    local course_name="$1"
    local student_count="$2"
    local grades_file="$course_name/Оценки.txt"
    echo "Добавьте фамилии студентов:"
    for (( i=1; i<=student_count; i++ )); do
        read -p "Студент $i: " student_name
        read -p "Введите оценку для $student_name: " grade
        echo "$student_name: $grade" >> "$grades_file"
    done
    echo "Оценки добавлены в файл 'Оценки.txt' для курса '$course_name'."
}
read -p "Укажите название курса: " course_name
if [ ! -d "$course_name" ]; then
    mkdir -p "$course_name/Студенты"
    touch "$course_name/Оценки.txt"
    echo "Создана папка для курса '$course_name'."
else
    echo "Папка курса '$course_name' уже существует."
fi
read -p "Сколько студентов в группе? " student_count
add_grades "$course_name" "$student_count"
edit_grades() {
    local grades_file="$1"
    if [ ! -f "$grades_file" ]; then
        echo "Файл 'Оценки.txt' не найден."
        return
    fi
    echo "Текущие оценки:"
    cat "$grades_file"
    read -p "Введите фамилию студента для редактирования: " student_name
    if grep -q "$student_name:" "$grades_file"; then
        read -p "Введите новую оценку для $student_name: " new_grade
        sed -i "s/^$student_name:.*/$student_name: $new_grade/" "$grades_file"
        echo "Оценка для $student_name обновлена."
    else
        echo "Студент с фамилией '$student_name' не найден."
    fi
}
read -p "Хотите редактировать оценки? (y/n): " edit_choice
if [[ "$edit_choice" == "y" ]]; then
    edit_grades "$course_name/Оценки.txt"
fi

