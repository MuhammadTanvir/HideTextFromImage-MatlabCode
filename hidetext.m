
function [red,green,blue] = hidetext(redc,greenc,bluec,text)
red=bitand(redc,248);
green=bitand(greenc,248);
blue=bitand(bluec,252);
txt=0;

if bitand(text,128)== 128
    red=bitor(red,4);
end

if bitand(text,64)== 64
    red=bitor(red,2);
end

if bitand(text,32)== 32
    red=bitor(red,1);
end

if bitand(text,16)== 16
    green=bitor(green,4);
end

if bitand(text,8)== 8
    green=bitor(green,2);
end

if bitand(text,4)== 4
    green=bitor(green,1);
end

if bitand(text,2)== 2
    blue=bitor(blue,2);
end

if bitand(text,1)== 1
    blue=bitor(blue,1);
end

return