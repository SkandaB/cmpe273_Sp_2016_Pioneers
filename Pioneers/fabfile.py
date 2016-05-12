#!/usr/bin/env python

from fabric.api import run, sudo, task, get, put, env, hosts
from array import *
from termcolor import colored
env.hosts = [ ]

@task
def set_hosts(hosts):
    """ Usage: fab set_hosts:"host_name" """
    env.hosts = [hosts]

'''
@task
def add_host(new_host):
    if not env.hosts:
        env.hosts = [ ]
    elif env.hosts:
        if new_host not in env.hosts:
            env.hosts.append(new_host)
            print colored('%s added to the hosts' %new_host,'green','on_grey')
        if new_host in env.hosts:
            print colored('%s already in hosts' %new_host,'yellow','on_magenta')
    print colored(env.hosts,'blue')

@task
def del_host(old_host):
    if not env.hosts:
        print colored('No list of hosts present','white','on_red')
    elif env.hosts:
        if old_host in env.hosts:
            env.hosts.remove(old_host)
            print colored('Removed host %s from hosts list' %old_host,'blue','on_yellow')
        elif old_host not in env.hosts:
            print colored('host %s not found in the hosts list' %old_host,'red', 'on_black')
    print colored(env.hosts,'blue')
'''

@task
def cmdrun(arg):
    """ Usage: fab -H server1,server2 cmdrun:"uptime" """
    run(arg)


@task
def sudorun(arg):
    """ Usage: fab -H server1,server2 sudorun:"fdisk -l" """
    sudo(arg)


@task
def download(arg):
    """ Usage: fab -H server1 download:"/path/to/file" """
    get(remote_path=arg, local_path="/tmp/", use_sudo=True)


@task
def upload(arg1, arg2):
    """Usage: fab -H server1,server2 upload:"/localfile","/remote/path/" """
    put(local_path=arg1, remote_path=arg2, use_sudo=True)

@task
def install(package):
    """Usage: fab -H server1,server2 install:"package_name" """
    sudo("apt-get -y install %s" % package)



