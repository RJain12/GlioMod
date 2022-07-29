# import packagas
from async_generator import yield_
import numpy as np
import os
import nibabel as nib
from matplotlib import pyplot as plt
import random

# define the input directory containing the patient folders (i.e. P1-8)
input_directory = '/Users/rishabjain/Desktop/rsi/procData'
slice = '/Users/rishabjain/Desktop/rsi/procData/test.nii'

for root, subdirectories, files in os.walk(input_directory):
    for subdirectory in subdirectories:
        print(os.path.join(root, subdirectory))

        # Get masks of the white matter and gray matter
        gm_img = nib.load(os.path.join(root, subdirectory, 'GM.nii'))
        wm_img = nib.load(os.path.join(root, subdirectory, 'WM.nii'))
        csf_mask = nib.load(os.path.join(root, subdirectory, 'CSF.nii'))

        # Convert to array of data
        gm_img = gm_img.get_fdata()
        wm_img = wm_img.get_fdata()
        csf_mask = csf_mask.get_fdata()

        csf_mask[np.where(csf_mask != 0)] = 1

        random_choice = random.choice([gm_img, wm_img])
        random_choice[np.where(random_choice > 0.5)] = 1
        random_choice[np.where(random_choice != 1)] = 0

        while(True):
            idx_arr = np.argwhere(random_choice == 1)
            z,x,y = random.choice(np.argwhere(random_choice == 1))
            if (csf_mask[z][x,y] == 1):
                print("Oops! Point was in the CSF!")
                continue
            else:
                print(random_choice[z][x,y])
                plt.imshow(random_choice[...,z])
                plt.show()
                break
"""

"""