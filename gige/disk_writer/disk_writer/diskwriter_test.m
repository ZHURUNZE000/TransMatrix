% Script to test the diskwriter class.
%   - Damien Loterie (03/2015)

% Includes
addpath('../../../tm11b');
addpath('../../gige_interface/gige_interface');

% Create camera
disp('Creating source...');
clear source vid;
vid = gigeinput('192.168.10.2');
source = vid.source;
% source = gigesource('192.168.10.2');

info = getdeviceinfo(source);

% Create disk writer
disp('Creating disk writer...');
%dw = diskwriter('C:\video.dat', vid, true);
dw = diskwriter('C:\Users\admin\Desktop\Jacob\video.dat', vid, true);

% Configure
disp('Configuring...');
set(source,'TriggerMode','On');
set(source,'TriggerSource','Line1');
set(source,'ExposureMode','TriggerWidth'); 

% Configure
disp('Starting...');
start(source);

% Trigger
disp('Trigger...');

n_frames = 10;
triggere('proximal', 1000, 5, n_frames);

% Stop
disp('Stopping...');
stop(source);

% % Image
disp('Getting image(s)');
%frame = getlastimage(source);
[frames, time] = getimages(source, n_frames);
%disp(['Frames gathered: ' int2str(size(frames,4))]);
disp(['Frames left: ' int2str(getnumberofimages(source))]);

% Errors
dw_errors = dw.geterrors();
source_errors = source.geterrors();
disp(['Errors (dw):      ' int2str(numel(dw_errors))]);
disp(['Errors (sources): ' int2str(numel(source_errors))]);

% Delete
disp('Delete...');
delete(source);
delete(dw);
clear source dw;
