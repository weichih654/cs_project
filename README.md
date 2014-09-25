cs_project
==========
This is a vim plugin which helps you add the cscsope.out for a specific project. 
For example, you may have some projects, and those paths are /a/b/c, /aa/bb/cc/, /aaa/bbb/ccc, if you open a file /aa/bb/cc/dd/ee.c, 
this plugin will auto add the /aa/bb/cc/cscopes.out, uniformly, if you open /a/b/c/d/e/f/g/h.c, the /a/b/c/cscope.out will be added. 

Installation 
========== 
1. Python must be installed. 
2. cscope must be installed. 
3. Install the plugin. -> https://github.com/simplyzhao/cscope_maps.vim 
4. Vim must be compiled with the Python interface. 
eg. ./configure --enable-pythoninterp=yes 

Usage 
========== 
1. The first time you use this, 
the plugin will auto generate the profile ~/.vim_cscope_project, 
you should edit this for your project. 
eg. 
projectname1,/a/b/c 
projectname2,/aa/bb/cc 
projectname3,/aaa/bba/ccc 
2. To generate the cscope.out by your self. -> cd /a/b/c && cscope -Rb 
If the cscope.out does not exist, the plugin will be automatically generated.

