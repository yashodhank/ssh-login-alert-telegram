#!/usr/bin/env bash

add_profiled() {
cat <<EOF > /etc/profile.d/telegram-alert.sh
#!/usr/bin/env bash
# Log connections
bash $ALERTSCRIPT_PATH
EOF
}

add_zsh() {
cat <<EOF >> /etc/zsh/zshrc

# Log connections
bash $ALERTSCRIPT_PATH
EOF
}

checkJq() {
    if [[ ! -x "$(command -v jq)" ]]; then
        echo "Installing jq..."
        apt -qqqq update && apt -y -qqqq install jq 2>/dev/null
    fi
}

checkGit() {
    if [[ ! -x "$(command -v git)" ]]; then
        echo "Installing git..."
        apt -qqqq update && apt -y -qqqq install git 2>/dev/null
    fi
}


ALERTSCRIPT_PATH="/opt/ssh-login-alert-telegram/alert.sh"

checkGit

checkJq

echo "Deploying alerts..."
add_profiled

echo "Check if ZSH is installed.."

HAS_ZSH=$(grep -o -m 1 "zsh" /etc/shells)
if [ ! -z $HAS_ZSH ]; then
    echo "ZSH is installed, deploy alerts to zshrc"
    add_zsh
else
    echo "No zsh detected"
fi

echo "Done!"
