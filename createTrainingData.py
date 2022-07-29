# import packages
import numpy as np
import os
import nibabel as nib
from matplotlib import pyplot as plt
import random
import subprocess
 
# define the input directory containing the patient folders (i.e. P1-8)
cwd = os.getcwd()
slice = os.path.join(cwd,"GliomaSolver/Simulations/TumorGrowth/slice.nii")
input_directory = os.path.join(cwd,"procData")
 
slice_mask = nib.load(slice)
slice_mask = slice_mask.get_fdata()
 
for root, subdirectories, files in os.walk(input_directory):
   for subdirectory in subdirectories:
       current_patient = os.path.join(root, subdirectory) + "/"

       # Get masks of the white matter and gray matter
       gm_img = nib.load(current_patient + 'GM.nii')
       wm_img = nib.load(current_patient + 'WM.nii')
       csf_mask = nib.load(current_patient + 'CSF.nii')

       # Convert to array of data
       gm_img = gm_img.get_fdata()
       wm_img = wm_img.get_fdata()
       csf_mask = csf_mask.get_fdata()
 
       csf_mask[np.where(csf_mask != 0)] = 1
 
       random_choice = gm_img + wm_img
       random_choice[np.where(random_choice > 0.5)] = 1
       random_choice[np.where(random_choice != 1)] = 0
 
       # run the loop 100 times
       for i in range(100):
           while(True):
               z = random.randint(130,170)
               x,y = random.choice(np.argwhere(random_choice[:,:,z] == 1))
               #check to see if mask is in csf, if so, restart loop.
               if (csf_mask[x,y,z] == 1):
                   continue
               # check to see if it is part of the blob; if not, restart loop.
               elif (slice_mask[x,y] == 0):
                   continue
               else:
                   # run gliomasolver
                   N = "4"
                   os.environ["OMP_NUM_THREADS"] = N
                   program = "brain"
                   model = "RD"
                   verbose = "1"
                   profiler = "1"
                   adaptive = "1"
                   vtk = "1"
                   dumpfreq = "50"
                   # 1 +, 2-, 3+, 4-, 5+, 6+, 7+, 8+
                   PatFileName = current_patient

                   Dw="0.0013"
                   rho="0.025"
                   Tend="500"
 
                   # scale x, y, and z to be a decimal to two places between 0 and 1
                   icx = str(round(x/160, 2))
                   icy = str(round(y/240, 2))
                   icz = str(round(z/256, 2))

                   print(icx,icy,icz)
 
                   print("In the directory:" + os.getcwd())
                   print("Running program on nodes " + N)
                   
                   os.chdir("procData/" + subdirectory)
                   os.mkdir(subdirectory + "_" + str(i))
                   os.chdir(subdirectory + "_" + str(i))

                   subprocess.call(["../../../brain", "-nthreads", N, "-model", model, "-profiler", profiler, "-verbose", verbose, "-adaptive", adaptive, "-PatFileName", PatFileName, "-vtk", vtk, "-dumpfreq", dumpfreq, "-Dw", Dw, "-rho", rho, "-Tend", Tend, "-icx", icx, "-icy", icy, "-icz", icz, "liblib"])
                   
                   os.chdir("../../../")
                   break
