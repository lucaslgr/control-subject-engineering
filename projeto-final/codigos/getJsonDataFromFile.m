function jsonData = getJsonDataFromFile(path)
%Read a specific JSON file and reutrn DATA
%   Detailed explanation goes here
    fname = path; 
    fid = fopen(fname); 
    raw = fread(fid,inf); 
    str = char(raw'); 
    fclose(fid); 
    jsonData = jsondecode(str);
end

