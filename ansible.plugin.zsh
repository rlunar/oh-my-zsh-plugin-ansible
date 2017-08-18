alias ap='ansible-playbook main.yml -i hosts';

function anstart() {
    touch hosts;
    echo "[server]" >> hosts;
    echo "192.168.1.10 ansible_user= ansible_ssh_pass=" >> hosts;
    touch main.yml;
    mkdir roles;
}

function ansrole() {
    mkdir $1 $1/files $1/tasks $1/handlers $1/vars $1/defaults $1/meta $1/tests;
}

function ansgi() {
    ansible-galaxy install --roles-path ./roles $1
}
