import os
import shutil
import random
import re

SOURCE_DIR = "benchmarks_UF_new"
TARGET_DIR = "benchmarks_UF"

def get_random_suffix(length=6):
    """Generates a random numeric string of given length."""
    return "".join([str(random.randint(0, 9)) for _ in range(length)])

def split_filename(filename):
    """
    Splits filename into base, suffix (random number), and extension.
    Assumes filename format: name_NUMBER.smt2
    """
    base, ext = os.path.splitext(filename)
    # Match the last segment after '_' which consists of digits
    match = re.search(r'_(\d+)$', base)
    if match:
        suffix = match.group(1)
        name_part = base[:match.start()] # includes the underscore
        return name_part, suffix, ext
    else:
        # If pattern doesn't match, just return base and empty suffix
        return base, "", ext

def merge_directories(source_root, target_root):
    if not os.path.exists(source_root):
        print(f"Source directory {source_root} does not exist.")
        return

    for root, dirs, files in os.walk(source_root):
        # Determine relative path to maintain structure
        rel_path = os.path.relpath(root, source_root)
        target_path = os.path.join(target_root, rel_path)

        if not os.path.exists(target_path):
            os.makedirs(target_path)
            print(f"Created directory: {target_path}")

        for file in files:
            source_file_path = os.path.join(root, file)
            target_file_path = os.path.join(target_path, file)
            
            final_target_path = target_file_path
            
            # Check for collision
            if os.path.exists(final_target_path):
                print(f"Collision found: {file}")
                name_part, suffix, ext = split_filename(file)
                
                if suffix: # Only try to rename if we found a numeric suffix
                    while True:
                        new_suffix = get_random_suffix(len(suffix))
                        new_filename = f"{name_part}_{new_suffix}{ext}"
                        final_target_path = os.path.join(target_path, new_filename)
                        
                        if not os.path.exists(final_target_path):
                            print(f"Renamed {file} to {new_filename}")
                            break
                            
                        # Safety break to avoid infinite loops if directory is extremely full (unlikely)
                        if new_suffix == suffix: 
                             # Should not happen with random, but implies we might just copy it as is if logic fails?
                             # But user asked to rename. 
                             pass 
                else:
                    # If no suffix found, maybe append one? 
                    # User instructions were "modify the last 6 random numbers".
                    # If it doesn't have one, we might just append.
                    while True:
                         new_suffix = get_random_suffix(6)
                         new_filename = f"{name_part}_{new_suffix}{ext}"
                         final_target_path = os.path.join(target_path, new_filename)
                         if not os.path.exists(final_target_path):
                            print(f"Renamed {file} to {new_filename}")
                            break

            # Copy or Move? User said "merge", usually implies moving if it's "merging A into B", 
            # or copying if we want to keep source. 
            # "合并 benchmarks_UF_new进benchmarks_UF中" -> Merge ... into ...
            # I will assume COPY for safety, or I can move. 
            # Scripts usually COPY to avoid destroying source unless specified.
            # But "merge into" often implies source is consumed. 
            # I'll COPY then user can delete benchmarks_UF_new if they want.
            
            shutil.copy2(source_file_path, final_target_path)
            print(f"Copied {source_file_path} to {final_target_path}")

if __name__ == "__main__":
    merge_directories(SOURCE_DIR, TARGET_DIR)
