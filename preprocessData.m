path = uigetdir;
directory = dir(path);
shortenedDir = directory(4:end);

for i = 1:length(shortenedDir)
    cd(shortenedDir(i).name);
    %movefile("csf.nii","CSF.nii");
    %movefile("gm.nii","GM.nii");
    %movefile("wm.nii","WM.nii");
    movefile("tumor_segm_FLAIR.nii","Tum_FLAIR.nii");
    movefile("tumor_segm_T1Gd.nii","Tum_T1c.nii");
    movefile("T1Gd_masked.nii","T1c.nii");
    movefile("FLAIR_masked.nii","FLAIR.nii");
    
    file = niftiread("FET_masked.nii");
    maxVal = max(file(:));
    indices = find(file < maxVal/2);
    file2 = file;
    file2(indices) = 0;

    niftiwrite(file2,"Tum_FET.nii");

    movefile("FET_masked.nii","FET.nii");

    cd ..
end