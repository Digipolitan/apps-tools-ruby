# apps-tools-ruby

[![Gem Version](https://badge.fury.io/rb/digipolitan-apps-tools.svg)](http://badge.fury.io/rb/digipolitan-apps-tools)

Digipolitan tools for Ruby scripts

## Cross-platform tools

### UI

The UI class provides some tools to work with stdin / stdout

````Ruby
Digipolitan::UI.message('Hello')
````
Write *Hello* in stdout

````Ruby
Digipolitan::UI.sucess('Hello')
````
Print *Hello* in stdout with a green color

````Ruby
Digipolitan::UI.error('Hello')
````
Print *Hello* in stdout with a red color

````Ruby
Digipolitan::UI.crash('Hello')
````
Print *Hello* in stdout with a red color and kill the script

````Ruby
name = Digipolitan::UI.input('What\'s your name ?')
````
Print *What's your name ?* in stdout with a yellow color and wait the user to write content until '\n'

````Ruby
if Digipolitan::UI.input('Are you sure ?')
  Digipolitan::UI.sucess('YES !')
else
  Digipolitan::UI.error('NO !')
end
````
Print *Are you sure ?* in stdout with a yellow color and wait the user to write 'y' (yes) or 'n' (no)

````Ruby
level = Digipolitan::UI.select('Choose your level ?', %w[easy medium hard 'very hard'])
````
Print *Choose your level ?* in stdout and wait the user to select the level : 1 -> easy, 2 -> medium, etc..

### Argv

The Argv class provides a parser to read inputs from command line and wrap it into a map using these rules :
````Sh
`script.rb -key1 value1 -key2 value2 value3 --key3`
````

This command will generate the following result :

````Json
{
  "-key1": "value1",
  "-key2": [
    "value2",
    "value3"
  ],
  "--key3": true
}
````

Example with `script.rb -key hello` :

````Ruby
args = Digipolitan::Argv.parse
print args['-key'] # display 'hello'
````

### FileUtils

The FileUtils class provides some tools to work easy with files, such as rename all files from a directory, replace all matching contents in files

````Ruby
Digipolitan::FileUtils.rename_files('bonjour', 'hello')
````
This action, replace all file name containing *bonjour* and replace it with *hello*, recursively from the current directory
Result example :
The given path `./bonbon/bonjourtoi/test/bonjouratoi.txt` will be replaced by `./bonbon/hellotoi/test/helloatoi.txt`

````Ruby
Digipolitan::FileUtils.replace_contents_of_files('bonjour', 'hello', %w[.git], './test')
````
This action replace all *bonjour* content with *hello* inside all files from the directory `./test` ignoring the *.git* directory

````Ruby
Digipolitan::FileUtils.write_to_file('./test/bonjour.md', 'Hello world')
````
Sample action used to write data, write *Hello world* in `./test/bonjour.md`

````Ruby
Digipolitan::FileUtils.remove_dir('./dev')
````
Removes the given directory

````Ruby
Digipolitan::FileUtils.mkdir_p('a/b/c/d')
````
Creates a directory and all its parent directories

causes to make following directories, if it does not exist.

````Sh
mkdir a
mkdir a/b
mkdir a/b/c
mkdir a/b/c/d
````

## iOS tools

### Xcodeproj

Working with Xcodeproj

````Ruby
proj = Digipolitan::FileUtils.get_project
````
Retrieves the first xcode project in the current directory

````Ruby
Digipolitan::FileUtils.rename_project
````
Rename the project, ask the user to confirm and choose the name of the new project
