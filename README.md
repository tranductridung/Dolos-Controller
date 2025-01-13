# DOLOS

## Installing
Clone this repository:
```bash
git clone https://github.com/tranductridung/Dolos-Controller

Navigate to the project directory:
```bash
cd Dolos-Controller/Dolos-Agent```

Build the project:
```bash
./linux_build.sh
```

Copy the agent binary:
```bash
cp bin/agent linux/test/agent
```

## Configure
The MTD modules for each Agent are configured using a `dolos_worker.conf` file with JSON format in `files` folder. Example:
{
	"tool_1": {
		"file": "Portspoof",
		"class": "Portspoof",
		"method": "start",
		"ports": [5000,6000]
	}
}

The `Endlessh` tool is configured in `worker.yml` within `host_vars` folder. Example:
dolos_conf_file: dolos_worker2.conf
endlessh_ports:
  - 22
  - 2001

Configure the DOLOS Agent details in the `inventory.ini` file.
[workers]
worker1 ansible_host=<IP_address> ansible_user=<username2> ansible_ssh_port=22
worker2 ansible_host=<IP_address> ansible_user=<username2> ansible_ssh_port=2000

Copy SSH key of DOLOS Controller to the DOLOS Agent.
ssh-copy-id -p SSH_port username@IP_address

## Usage
To install and run DOLOS Agent from DOLOS Controller.
cd Dolos-Controller/Management
ansible-playbook deploy.yml -i inventory.ini --ask-become-pass

To stop DOLOS Agent from DOLOS Controller.
ansible-playbook stop.yml -i inventory.ini --ask-become-pass

If you want to run DOLOS Agent without DOLOS Controller with Endlessh with port 2001 and 2002.
cd Dolos-Controller/Dolos-Agent/linux/test
./run.sh "2001 2002"

If you don't need to use Endlessh, just run
./run.sh
