#!/usr/bin/env python3

import os
import sys
import subprocess
import shutil
from os.path import exists
import logging
import tempfile
import re
import platform

#logging.basicConfig(level=logging.ERROR)  # DEBUG => print ALL msgs
logging.basicConfig(level=logging.DEBUG)  # DEBUG => print ALL msgs

modified = re.compile('^(?:M|A)(\s+)(?P<name>.*)')

def get_path_to_1c():
    '''
    get path to 1c binary. 
    fist env, "PATH1C" 
    two env "PROGRAMFILES" on windows
    three /opt/1c - only linux
    
    '''
    
    cmd = os.getenv("PATH1C")
    if not cmd is None:
        return os.getenv("PATH1C")
    
    if platform.system() == "Darwin":
        raise Exception("MacOS not run 1C")
    elif platform.system() == "Windows":
        program_files = os.getenv("PROGRAMFILES(X86)")
        if program_files is None:
            #FIXME: проверить архетиктуру.  
            program_files = os.getenv("PROGRAMFILES")
            if program_files is None:
                raise Exeption("path to Program files not found");
        cmd = os.path.join(program_files, "1cv8")
        maxversion =  max(list(filter((lambda x: '8.' in x), os.listdir(cmd))))
        if maxversion is None:
            raise Exception("not found verion dirs")
        cmd = os.path.join(cmd, maxversion + os.path.sep + "bin"+os.path.sep+"1cv8.exe")

        if not os.path.isfile(cmd):
            raise Exception("file not found %s" %(cmd))
        
    else:
        cmd = subprocess.Popen(["which", "1cv8"], stdout=PIPE).communicate()[0].strip()
    
    logging.info("CMD: %s" % cmd)
    return cmd 

def get_list_of_comitted_files():
    """
    Retun a list of files abouts to be decompile
    """
    files = []
    output = []
    try:
        output = subprocess.check_output(['git','diff-index', '--name-status', '--cached','HEAD']
            ).decode("utf-8")
    except subprocess.CalledProcessError:
        print("Error diff files get: trace %s" % subprocess.CalledProcessError)
        return files

    for result in output.split("\n"):
        logging.info(result)
        if result != '':
            match = modified.match(result)
            if match:
                files.append(match.group('name'))

    return files


def decompile():
    """
    Main functions doing be decompile
    """
    #list of files to decompile and results decompile
    dataprocessor_files = []

    #list of files to decompile and results decompile for 1C v7.7
    dataprocessor_files_v7 = []

    #list of files to decompile and results decompile for 1C MD
    dataprocessor_files_MD = []

    #set the exit code
    exit_code = 0

    #Find datapocessor files
    for filename in get_list_of_comitted_files():
        #Check the file extensions
        logging.info("file to check %s" % filename)
        if filename[-3:] == "ert":
            dataprocessor_files_v7.append(filename)
<<<<<<< HEAD
            logging.info("file %s" % filename)
            continue            
        if filename[-3:] in ['.MD','.md']:
            dataprocessor_files_MD.append(filename)
            logging.info("file %s" % filename)
            continue            
=======
            logging.info("file %s" % filename)
            continue            
        if filename[-3:] in ['.MD','.md']:
            dataprocessor_files_MD.append(filename)
            logging.info("file %s" % filename)
            continue            
>>>>>>> remotes/origin/master

    dirsource = os.path.abspath(os.path.join(os.path.curdir, "src"))
    curabsdirpath = os.path.abspath(os.path.curdir)    

    if len(dataprocessor_files) > 0:
        #pathbin1c = "C:\\Program Files\\1cv82\8.2.17.153\\bin\\1cv8.exe"
        #pathbin1c = "c:\\Program Files (x86)\\1cv8\\8.3.4.304\\bin\\1cv8.exe"
        pathbin1c = get_path_to_1c()

    if len(dataprocessor_files_v7) > 0:
        for filename in dataprocessor_files_v7:
            print("ert file %s" % filename)
            #TODO: добавить копирование этих же файлов в каталог src/имяфайла/...
            #get file name.
            fullpathfile = os.path.abspath(filename)
            basename = os.path.splitext(os.path.basename(filename))[0]
            fullbasename = os.path.basename(filename)
            newdirname = os.path.dirname(filename)

            print("ert file %s" % fullpathfile )

            #Скопируем сначало просто структуру каталогов.
            if not os.path.exists(dirsource):
                os.makedirs(dirsource)
            #для каждого файла определим новую папку.
            newsourcepath = os.path.join(dirsource, newdirname)
            newpath2 = os.path.join(newsourcepath, basename)
            if not os.path.exists(newsourcepath):
                logging.info("create new dir %s" % newsourcepath)
                os.makedirs(newsourcepath)
            #print("curabsdirpath %s" % curabsdirpath)
            #print("newpath2 %s" % newpath2)
            #print("basename %s" % basename)

            t1 = format("gcomp -q -d -F %s -D %s -v --no-ini --no-version --no-empty-mxl" % (filename, newsourcepath))
            result = subprocess.check_call(['cmd.exe', '/C', t1])            
            #изменим кодировку cp1251 на utf-8 
            #утилита iconv.exe должна запускаться в cmd = добавлена в PATH			
            #файлов 1s, mdp, frm, txt
            t3 = 'bash .git/hooks/convert_utf8.sh {0}'.format( newpath2 )
            print("t3 = %s" % t3)
            result = subprocess.check_call(['cmd.exe', '/C', t3])
<<<<<<< HEAD
            #result = subprocess.check_call(['git', 'add', '--all', newsourcepath])
            result = subprocess.check_call(['git', 'add', '*.1s', newsourcepath])
            result = subprocess.check_call(['git', 'add', '*.frm', newsourcepath])
            result = subprocess.check_call(['git', 'add', '*.mxl', newsourcepath])
=======
            result = subprocess.check_call(['git', 'add', '--all', newsourcepath])
>>>>>>> remotes/origin/master
            if not result == 0:
                logging.error(result)
                exit(result)

    if len(dataprocessor_files_MD) > 0:
        for filename in dataprocessor_files_MD:
            print("MD file %s" % filename)
            #TODO: добавить копирование этих же файлов в каталог src/имяфайла/...
            #get file name.
            fullpathfile = os.path.abspath(filename)
            basename = os.path.splitext(os.path.basename(filename))[0]
            fullbasename = os.path.basename(filename)
            newdirname = os.path.dirname(filename)
            
            #Скопируем сначало просто структуру каталогов.
            if not os.path.exists(dirsource):
                os.makedirs(dirsource)
            #для каждого файла определим новую папку.
            newsourcepath = os.path.join(dirsource, newdirname, "MD")
            if not os.path.exists(newsourcepath):
                logging.info("create new dir %s" % newsourcepath)
                os.makedirs(newsourcepath)
            newpath2 = os.path.join(newsourcepath, basename)
            print("fullbasename %s" % fullbasename)
            print("newdirname %s" % newdirname)
            print("newsourcepath %s" % newsourcepath)
            
            t1 = format("gcomp -d -v -F %s -D %s" % (filename, newsourcepath))
            result = subprocess.check_call(['cmd.exe', '/C', t1])

            #изменим кодировку cp1251 на utf-8 
            #утилита iconv.exe должна запускаться в cmd = добавлена в PATH			
            #файлов 1s, mdp, frm, txt
            t3 = 'bash .git/hooks/convert_utf8.sh {0}'.format( newsourcepath )
            print("t3 = %s" % t3)
            result = subprocess.check_call(['cmd.exe', '/C', t3])

<<<<<<< HEAD
            #result = subprocess.check_call(['git', 'add', '--all', newsourcepath])
            result = subprocess.check_call(['git', 'add', '*.1s', newsourcepath])
            result = subprocess.check_call(['git', 'add', '*.frm', newsourcepath])
            result = subprocess.check_call(['git', 'add', '*.mxl', newsourcepath])
=======
            result = subprocess.check_call(['git', 'add', '--all', newsourcepath])
>>>>>>> remotes/origin/master
            if not result == 0:
                logging.error(result)
                exit(result)

if __name__ == '__main__':
    decompile()
