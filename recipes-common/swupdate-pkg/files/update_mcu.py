#!/usr/bin/python
"""
  MCU update tool, it attaches to Probe daemon via D-Bus, and send update commands to probe daemo
  It  will write the process information to /tmp/update_info
"""
import sys
import os
import time
import dbus
from traceback import print_exc
from argparse import ArgumentParser
import json



def is_json(myjson):
    try:
        json_object = json.loads(myjson)
    except ValueError:
        return False
    return True


class ProbeDBus(object):

    def __init__(self, dbus_tcp):
        super(ProbeDBus, self).__init__()
        self.probe_general = None
        self.probe_measure = None
        self.bus = self.attach_probe(dbus_tcp)

    def is_alive(self):
        return False if self.bus is None else True

    def attach_probe(self, dbus_tcp=None):
        try:
            if dbus_tcp is not None:
                bus = dbus.bus.BusConnection("tcp:host="+dbus_tcp+",port=55556")
            else:
                bus = dbus.SystemBus() 
            bus_obj = bus.get_object("h2o.probe.service", "/ProbeObject")
            self.probe_general = dbus.Interface(bus_obj, "h2o.probe.service.general")
            self.probe_measure = dbus.Interface(bus_obj, "h2o.probe.service.measure")
            return bus
        except dbus.DBusException:
            print_exc()
            return None

    def dbus_json(self, json_cmd):
        result = self.probe_measure.Json(json_cmd)
        result = json.loads(result)
        # result = json.dumps(result, sort_keys=True, indent=4, separators=(',', ': '))
        return result

class ProbeCommand(object):
    
    def __init__(self, protocol):
        pass

    def execute(self, cmd):
        pass


class UpdateClient(ProbeCommand):

    info_path = '/tmp/update_info'
    error_path = '/tmp/update_error'

    ''' Resolve command from single command, command json list, or event command BASIC script. '''
    def __init__(self, dbus_tcp):
        try :
            self.probe = ProbeDBus(dbus_tcp)
        except:
            print_exc()
            self.write_err("Can not connect to dbus service")


    def write_err(self, err):
        err_msg = json.dumps(err, sort_keys=True, indent=4, separators=(',', ': '))
        print(err_msg)
        with open(self.error_path, 'w') as err_file:
            err_file.write(err_msg)

    def write_info(self, info):
        with open(self.info_path, 'w') as info_file:
            info_file.write(info)

    def write_stdout(self, info):
        sys.stdout.write("\rUpdate mcu in processing: " + info + "%")
        sys.stdout.flush()

    def send_udpate(self, file):
        json_cmd = '{"op": "flash", "param": {"hex": "' + file + '"}}'
        result = self.probe.dbus_json(json_cmd)
        if result['ack'] != 0:
            self.write_err(result)
            return False
        return True

    def query_update(self):
        json_cmd = '{ "op": "flash_progress", "param": {} }'
        for i in range(1, 180):
            time.sleep(1)
            result = self.probe.dbus_json(json_cmd)
            if result['ack'] != 0:
                self.write_err(result)
                return False
            process = float(result['result']) * 100
            self.write_stdout(str(int(process)))
            self.write_info(str(int(process)))

            if(process == 100):
                print('\rUpdate finished!                    ')
                break
        return True

    def init_update(self):
        if os.access(self.error_path, os.F_OK):
            os.remove(self.error_path)
        self.write_info('0')

    def update(self, file):
        self.init_update()
        if False == self.send_udpate(file):
            return False
        if False == self.query_update():
            return False
        return True

    def execute(self, file):
        try :
            return self.update(file)
        except:
            print_exc()
            self.write_err("Exception happened in update muc")
            return False


def parse_args():
    parser = ArgumentParser(description='Communicate with Probe to update firmware.')
    parser.add_argument('--tcp', dest='dbus_tcp',
                        help='Attach to remote D-Bus Probe daemon (e.g.: 10.131.133.25)',
                        default=None, type=str)
    parser.add_argument('--firmware', dest='firmware_file',
                        help='Pointer to the mcu firmware binary file path',
                        default='/tmp/mcu/firmware.bin', type=str)
    args = parser.parse_args()
    return args
  

def main():
    args = parse_args()
    client = UpdateClient(args.dbus_tcp)
    return client.execute(args.firmware_file)


if __name__ == "__main__":
    main()
