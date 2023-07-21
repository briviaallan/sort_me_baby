
### How to Use the Media Sorting Script:

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
