import tkinter as tk
import time
import os

# Specify the source file (the first text file)
source_file_path = "C:\\Users\\WANG Xingyu\\Downloads\\WitMotion(V2.4.2.0)\\Record\\WT9011DCL-BT50_1695836891863_1.txt"

# Specify the destination file (the second text file)
destination_folder = "C:\\Users\\WANG Xingyu\\Documents\\MATLAB\\CDPR_Motion_Track"
destination_file_path = os.path.join(destination_folder, "copied_data.txt")


def delete_destination_file():
    # Delete the earlier 'copied_data.txt' file if it exists
    if os.path.exists(destination_file_path):
        os.remove(destination_file_path)

def copy_data():
    try:
        delete_destination_file()  # Clean the destination file at the start of copying
        with open(source_file_path, "r") as source_file:
            with open(destination_file_path, "w") as destination_file:
                first_line = True  # Flag to skip the first line
                current_line_count = 0 # Track the line count
                while copying_flag:
                    line = source_file.readline()
                    if not line:
                        time.sleep(0.1)
                    else:
                        current_line_count += 1
                        if first_line:
                            first_line = False
                            continue  # Skip the first line
                        # Split the line into columns and keep only columns 3 and onwards
                        columns = line.strip().split()
                        modified_line = ' '.join(columns[10:13]) + "\n"

                        destination_file.write(modified_line)
                        destination_file.flush()
    except Exception as e:
        print(f"An error occurred: {e}")
    finally:
        end_copy()


def start_copy():
    global copying_flag
    copying_flag = True
    copy_data()
    start_button.config(state=tk.DISABLED)
    end_button.config(state=tk.NORMAL)


def end_copy():
    global copying_flag
    copying_flag = False
    start_button.config(state=tk.NORMAL)
    end_button.config(state=tk.DISABLED)


# Create the main window
window = tk.Tk()
window.title("Text File Copy")

# Create and configure widgets
start_button = tk.Button(window, text="Start Copy", command=start_copy)
end_button = tk.Button(window, text="End Copy", command=end_copy, state=tk.DISABLED)

# Pack widgets
start_button.pack(pady=10)
end_button.pack()

# Initialize copying flag
copying_flag = False

# Start the main loop
window.mainloop()
