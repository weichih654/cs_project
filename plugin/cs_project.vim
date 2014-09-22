if !has('python')
    echo "Error: Required vim compiled with +python"
    finish
endif

let g:filePath = fnamemodify( expand("%:p"), ':h')

python << EOF
import os
from os.path import expanduser
import vim
home = expanduser("~")

class Project:
    def __init__(self, name, path):
        self.name = name
        self.path = path

    def __str__(self):
        return 'Name = {0}, Path = {1}'.format(self.name, self.path)

def getThisProject(projects):
    for p in projects:
        thisFilePath = vim.eval("g:filePath");
        if p.path in thisFilePath:
            return p
    return False

def genCsOut(path):
    os.system("find " + path + " -name \"*.js\" -o -name \"*.html\" -o -name \"*.css\" -o -name \"*.json\" -o -name \"*.c\" -o -name \"*.cpp\" -o -name \"*.h\" -o -name \"*.hpp\" -o -name \"*.cxx\" > cscope.files; cscope -Rb; mv cscope.out " + path + "; rm cscope.files")

#read projects from file
projectFileName = home + "/.vim_cscope_project"
if os.path.isfile(projectFileName) == False:
    print "Profile not exist"
    print "Auto create `" + projectFileName + "'"
    os.system("echo \"#example\n#projectname,/cscope/path\" > " + projectFileName);

with open(projectFileName) as f:
    lines = f.read().splitlines()

projects = []

#add to projects
for i in lines:
    item = i.strip().split(',')
    if '#' not in item[0]:
        projects.append(Project(item[0], item[1]))

if getThisProject(projects) != False:
    thisProjectPath = getThisProject(projects).path
    if os.path.isfile(thisProjectPath + "/cscope.out") == False:
        genCsOut(thisProjectPath)
    vim.command("cs add %s/cscope.out"% thisProjectPath)
EOF
