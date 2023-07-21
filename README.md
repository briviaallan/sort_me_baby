# sort_me_baby
An auto file sorting script for windows & linux systems

### How to Use the Media Sorting Script:

### Linux Systems
1. Download the script: Save the script to a location on your Linux computer. You can name it something like `media_sort.sh`.

2. Make the script executable: Open a terminal, navigate to the folder containing the script, and run the following command to make it executable:
   ```
   chmod +x media_sort.sh
   ```

3. Run the script: Execute the script by typing the following command in the terminal:
   ```
   ./media_sort.sh
   ```

4. Source and Destination Folders: The script will prompt you to enter the source folder containing your media files (movies, TV shows, etc.). Press Enter after providing the path to the source folder.

5. Sorting Destination: Next, the script will ask you to specify the destination folder where you want to sort your media files. Press Enter after providing the path to the destination folder.

6. Permission Prompt: The script will check if it needs elevated privileges (root) to perform certain operations, such as moving files across different drives/partitions. If required, it will prompt you with the message "Do you want to run the script with elevated privileges (root)?" Type 'yes' and enter your password when prompted to proceed with elevated privileges. If not required, the script will proceed without elevated privileges.

7. Single or Multi-Destination Transfer: The script will ask if you want to perform a multi-destination transfer. If you choose 'yes', you can provide multiple destination directories for sorting your media files. If you choose 'no', the script will prompt you to decide whether to move or copy the files.

8. Moving or Copying Files: If you choose a single-destination transfer, the script will ask whether you want to move or copy the files. Enter 'move' to move the files (cut and paste) or 'copy' to copy the files (duplicate).

9. File Sorting: The script will then analyze the source folder and its subdirectories, extracting commonalities from file titles (e.g., season numbers, episode numbers) to sort them into appropriate subfolders based on genre or commonalities.

10. Disk Space Check: The script will check if there is enough space in the destination drive/partition before copying files to it. If there isn't enough space, it will prompt you to provide another destination folder.

11. File Overwrite: If a file with the same name already exists in the destination folder, the script will prompt you to decide whether to overwrite the existing file or skip the transfer.

12. Sorting Completion: After processing all files and subdirectories, the script will display the message "Files sorted into appropriate folders."

Please ensure you understand what the script does before running it. Be cautious when using the script with elevated privileges and make sure to have backups of important data before performing file operations. It's essential to use the script responsibly and verify the results to avoid unintentional data loss or file modifications.


### Windows Systems

To use the script for sorting your video files on a Windows system using PowerShell, follow these instructions:

1. **Prepare the Script:**
   - Copy the PowerShell script provided in the previous response and save it to a text file with a `.ps1` extension. For example, you can name it `sort_me_baby.ps1`.

2. **Open PowerShell:**
   - Press the Windows key, type "PowerShell," and select "Windows PowerShell" or "Windows PowerShell (Admin)" from the search results. Running PowerShell with admin privileges may be required if you want to move files across different drives or partitions.

3. **Set Execution Policy (Optional):**
   - By default, PowerShell restricts running scripts for security reasons. If you haven't previously executed any PowerShell scripts on your system, you might need to change the execution policy. To do this, run the following command:
     ```
     Set-ExecutionPolicy RemoteSigned
     ```
   - Choose `Y` or `A` when prompted to confirm the change.

4. **Navigate to the Script's Directory:**
   - Use the `cd` command to change the working directory to the location where you saved the PowerShell script. For example, if you saved the script in your Documents folder, use:
     ```
     cd C:\Users\YourUserName\Documents
     ```

5. **Run the Script:**
   - Execute the script by typing its name followed by the `Enter` key. For example:
     ```
     .\sort_me_baby.ps1
     ```
   - Note: The `.\` prefix before the script name is essential to execute scripts in the current directory.

6. **Follow the Prompts:**
   - The script will prompt you to enter the source folder path for your video files. Provide the full path to the folder containing your video files (e.g., `C:\Videos`), and press `Enter`.

   - Next, it will ask you to enter the destination folder path where the sorted video files will be moved or copied. Provide the full path to the destination folder (e.g., `D:\SortedVideos`), and press `Enter`.

   - The script will then prompt you to choose whether you want to "move" or "copy" the video files. Type `move` or `copy` and press `Enter`.

7. **Wait for Sorting:**
   - The script will start sorting your video files based on their commonalities in titles and move or copy them to appropriate subfolders.

8. **Review the Results:**
   - Once the sorting is complete, the script will display a message indicating that the files have been sorted into appropriate folders.

9. **Exit PowerShell:**
   - You can close the PowerShell window once the sorting is finished.

Remember to exercise caution when using the script, especially when moving or copying files. Always back up your important data before running any script that performs file operations.

Please ensure that you have a backup of your video files before running the script and verify the results after the sorting process is complete.
