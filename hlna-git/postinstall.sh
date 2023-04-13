line1_to_add='alias hlna="hlna.py"'
line2_to_add='alias hlna-bot="hlna-bot.py"'
file_paths=( "/home/$SUDO_USER/.zshrc" "/home/$SUDO_USER/.bashrc" "/home/$SUDO_USER/.config/fish/config.fish" )

for file_path in "${file_paths[@]}"
do
    if [ -f "$file_path" ]; then
        # Check if the lines are already in the file
        grep -qF "$line1_to_add" "$file_path"
        if [ $? -ne 0 ]; then
            echo "$line1_to_add" >> "$file_path"
            echo "Alias hlna добавлен в $file_path"
        else
            echo "Alias hlna уже есть в файле $file_path"
        fi

        grep -qF "$line2_to_add" "$file_path"
        if [ $? -ne 0 ]; then
            echo "$line2_to_add" >> "$file_path"
            echo "Alias hlna-bot добавлен в $file_path"
        else
            echo "Alias hlna-bot уже есть в файле $file_path"
        fi

    else
        echo "$file_path не существует"
    fi
done