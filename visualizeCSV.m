file = "CSVFileFromVTU2CSV";
arr = table2array(file);

tumor_x = arr(:,1);
tumor_y = arr(:,2);
tumor_z = arr(:,3);
tumor_c = arr(:,4);

tumor_idx = tumor_c >= 0;
tumor_idx2 = tumor_c > 0;

% plot tumor only;
figure
scatter3(tumor_x(tumor_idx), tumor_y(tumor_idx), tumor_z(tumor_idx), 10, tumor_c(tumor_idx))
colorbar

figure
scatter3(tumor_x(tumor_idx2), tumor_y(tumor_idx2), tumor_z(tumor_idx2), 10, tumor_c(tumor_idx2))
colorbar
