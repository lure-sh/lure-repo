line1_to_remove='alias hlna="hlna.py"'
line2_to_remove='alias hlna-bot="hlna-bot.py"'
file_paths=( "/home/$SUDO_USER/.zshrc" "/home/$SUDO_USER/.bashrc" "/home/$SUDO_USER/.config/fish/config.fish" )

for file_path in "${file_paths[@]}"
do
    if [ -f "$file_path" ]; then
        # Check if the line is in the file
        grep -qF "$line1_to_remove" "$file_path"
        if [ $? -eq 0 ]; then
            sed -i "/$line1_to_remove/d" "$file_path"
            echo "Alias hlna удалён из $file_path"
        else
            echo "Alias hlna нет в  $file_path"
        fi

        grep -qF "$line2_to_remove" "$file_path"
        if [ $? -eq 0 ]; then
            sed -i "/$line2_to_remove/d" "$file_path"
            echo "Alias hlna-bot удалён из $file_path"
        else
            echo "Alias hlna-bot нет в  $file_path"
        fi
    else
        echo "$file_path не существует"
    fi
done