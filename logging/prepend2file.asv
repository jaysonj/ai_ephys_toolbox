function prepend2file( string, filename, newline, dupcheck )
% newline: is an optional boolean, that if true will append a \n to the end
% of the string that is sent in such that the original text starts on the
% next line rather than the end of the line that the string is on
% string: a single line string
% filename: the file you want to prepend to
% dupcheck: make sure you haven't already added that line
tempFile = tempname
fw = fopen( tempFile, 'wt' );
if nargin < 4
    dupcheck = false;
end
if nargin < 3
    newline = false;
end

if dupcheck
    l1 = fread(fw, 30)
if newline
    fwrite( fw, sprintf('%s\n', string ) );
else
    fwrite( fw, string );
end

fclose( fw );
appendFiles( filename, tempFile );
copyfile( tempFile, filename );
delete(tempFile);

% append readFile to writtenFile
function status = appendFiles( readFile, writtenFile )
fr = fopen( readFile, 'rt' );
fw = fopen( writtenFile, 'at' );

while feof( fr ) == 0
    tline = fgetl( fr );
    fwrite( fw, sprintf('%s\n',tline ) );
end
fclose(fr);
fclose(fw);
