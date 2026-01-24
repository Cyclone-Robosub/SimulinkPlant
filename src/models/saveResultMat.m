function saveResultMat(result,path)
name = string(datetime('now','Format','uuuuMMdd''T''HHmmss'));

mat_folder = fullfile(path,name);
mkdir(mat_folder);
file_path = fullfile(mat_folder,name+".mat");

save(file_path,'result','-mat');

end