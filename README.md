# Dataset Splitter
A Ruby program to copy or move dataset files with distributed, regular or random file selections.

## General Information
This is a data splitter program which copies or moves specified amount of files from class-based file-folder structures with either distributed selections or regular sequential selections or random selections.

* **Example**: CIFAR-10 dataset has 1 **train** and 1 **test** folder, each of those folders contains 10 different subfolders that are related to specific classes. If **train** or **test** folder is given as the input folder, the program will move the specified amount of files from each class-based subfolder with the specified type of file selections: *distributed*, *sequential* or *random*.

The user is also asked to choose whether the process will be moving files or copying files that results in the original folder to stay as the same. A sample folder **11_Dataset** derived from CIFAR-10 dataset is given with 10 class-based subfolders where each folder contains only 100 files, to test the program.

This project has 11 different ruby (.rb) files, the first 10 files are preparation programs that belong to specific parts of the main program. And the 11th program is the final main program which splits dataset folders:
1. **1_Continue.rb**: Calling functions.
2. **2_Split_String.rb**: Splitting strings.
3. **3_Trim_String.rb**: Trimming strings.
4. **4_Path_from_Drag.rb**: Printing file-folder path from dragging.
5. **5_Check_File_Existence.rb**: Checking file existence.
6. **6_Count_Files_Folders.rb**: Counting and displaying the number of files and folders in a specific path.
7. **7_Delete_Files_from_Folders.rb**: Deleting files in a folder by the reference of filenames in another folder.
8. **8_Folder_File_Names_to_Textfile.rb**: Writing the list of folder-file names in a path to a textfile.
9. **9_Distributed_Item_Selections.rb**: A simple program to show distributed selections from a set of numbers.
10. **10_Random_Item_Selections.rb**: A simple program to show random selections from a set of numbers.
11. **11_Dataset_Splitter.rb**: The final program; copying or moving dataset files with various file selection modes.
* There are also 5 given folders that will be inputs for their corresponding programs:
```
6_Files_Folders --> Input for:    6_Count_Files_Folders.rb
7_Delete        --> Input(1) for: 7_Delete_Files_from_Folders.rb
7_Reference     --> Input(2) for: 7_Delete_Files_from_Folders.rb
8_Files_Folders --> Input for:    8_Folder_File_Names_to_Textfile.rb
11_Dataset      --> Input for:    11_Dataset_Splitter.rb
```

## Setup & Run
* Download and install **Ruby**: https://www.ruby-lang.org/en/documentation/installation/

* Install **fileutils** from terminal/cmd:
```
gem install fileutils
```
* Run the Ruby (.rb) files and give the related folder names as their inputs:
```
ruby filename.rb
```
* **NOTE**: Some programs such as **7_Delete_Files_from_Folders.rb** and **11_Dataset_Splitter.rb** modify/remove some files in the input folders permanently, you may backup the original folders before running those programs.