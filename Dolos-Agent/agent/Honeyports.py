from Core import Core
import subprocess

class Honeyports(Core):
    
    MSG = ""
    
    def __init__(self, sock, port, active_sock, ip): 
        super().__init__(sock, port, active_sock, ip)
        self.__blacklist(ip)
        
    def __blacklist(self, ip):
        if Honeyports.MSG != "":
            super().send(Honeyports.MSG)            
        super().shutdown()
        
        params = ['iptables', '-A', 'INPUT', '-s', ip, '-j', 'REJECT']
        subprocess.run(params)
        super().log(Core.WARNING, "Someone connect to Honeyport")
        super().log(Core.INFO, "Add rule to block IP {} in iptables".format(ip))
          
    def start(self, b):
        super().shutdown()
