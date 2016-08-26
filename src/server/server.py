#!/usr/bin/env python3

import sys
import os
import socket
import signal
from db import database as mdb

sys.path.append(os.path.abspath(os.path.curdir) + "/../lib")
from data_type import type_dict

class music_srv:
        "Music Server class."
        port = 6666
        host = "127.0.0.1"
        client_address = ['0.0.0.0', 6666]
        socket = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        message = bytearray(1024)
        db = mdb()

        def __init__(self):
                self.socket.bind((self.host, self.port))
                signal.signal(signal.SIGINT, self.kill)

        def kill(self, signum, frame):
                self.socket.close()
                self.db.close()
                print("Exit safely.")
                sys.exit()

        def run(self):
                while True:
                        nbytes, address = self.socket.recvfrom_into(self.message)
                        if not nbytes:
                                continue
                        self.client_address = address
                        data = self.message.decode('utf-8')
                        data = data.split('\0')[0]
                        data_list = data.split('\r\n')

                        if data_list[0] == type_dict['login']:
                                result = self.login(data_list[1], data_list[2])
                                self.response(result)
                        elif data_list[0] == type_dict['register']:
                                result = self.register(data_list[1], data_list[2], data_list[3])
                                self.response(result)
                        elif data_list[0] == type_dict['fetch_list']:
                                result = self.send_user_list(data_list[1])
                                self.response(result)
                        elif data_list[0] == type_dict['new_list']:
                                result = self.user_list_new(data_list[1], data_list[2])
                                self.response(result)
                        else:
                                pass
                                
        def response(self, result):
                send_buffer = result.encode('utf-8')
                self.socket.sendto(send_buffer, self.client_address)

        def login(self, email, password):
                key =self.db.get_password_by_email(email)
                if None != key and key == password:
                        return "login_success"
                else:
                        return "login_failed"
        
        def register(self, email, password, nick):
                res = self.db.insert_new_user(email, password, nick)
                if True == res:
                        return "register_success"
                else:
                        return "register_failed"

        def send_user_list(self, email):
                return "fetch_end"
                # Todo

        def user_list_new(self, email, list_name):
                print(list_name)
                # Todo
                return "new_list_success"

if __name__ == "__main__":
        print("Server listening...")
        srv = music_srv()
        srv.run()
