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

    touch $1/defaults/main.yml;
    echo "---\nvariable: value" >> $1/defaults/main.yml;

    touch $1/meta/main.yml;
    echo "galaxy_info:\n author: Roberto Luna\n description: Ansible Role\n license: MIT\n min_ansible_version: 2.1\n platforms:\n  -name: Ubuntu\n dependencies: []" >> $1/meta/main.yml;

    touch $1/tasks/main.yml;
    echo "--\n - name: task_name" >> $1/tasks/main.yml;

    touch $1/tests/inventory;
    echo "localhost" >> $1/tests/inventory;

    touch $1/tests/test.yml;
    echo "---\n- hosts: localhost\n  remote_user: root\n  roles:\n    - ansible-role-docker-portainer" >> $1/tests/test.yml;

    touch $1/handlers/main.yml;
    echo "---" >> $1/handlers/main.yml;
    
    touch $1/vars/main.yml;
    echo "---" >> $1/vars/main.yml;

    touch $1/.travis.yml;
    echo "---\nlanguage: python\npython: \"2.7\"\n# Use the new container infrastructure\nsudo: false\n# Install ansible\naddons:\n  apt:\n    packages:\n    - python-pip\ninstall:\n  # Install ansible\n  - pip install ansible\n
  # Check ansible version\n  - ansible --version\n
  # Create ansible.cfg with correct roles_path\n  - printf '[defaults]\nroles_path=../' >ansible.cfg\n
script:\n  # Basic role syntax check\n  - ansible-playbook tests/test.yml -i tests/inventory --syntax-check\nnotifications:\n  webhooks: https://galaxy.ansible.com/api/v1/notifications/" >> $1/.travis.yml;

}

function ansgi() {
    ansible-galaxy install --roles-path ./roles $1
}
