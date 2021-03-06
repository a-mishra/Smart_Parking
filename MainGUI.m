function varargout = MainGUI(varargin)
%% Initialization code
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @MainGUI_OpeningFcn, ...
    'gui_OutputFcn',  @MainGUI_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code

function MainGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% Choose default command line output for MainGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using MainGUI.
if strcmp(get(hObject,'Visible'),'off')
    initial = imread('initialsp1.png');
    imagesc(initial);
    axis off;
end

% --- Outputs from this function are returned to the command line.
function varargout = MainGUI_OutputFcn(hObject, eventdata, handles)
% Get default command line output from handles structure
varargout{1} = handles.output;


%Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'INComing','OUTGoing','Camera3','Camera4'});


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)

%%% Button Live Feed
% Shows live feed from the selected camera
function pushbutton1_Callback(hObject, eventdata, handles)
axes(handles.axes1);
cla;
load('slots.mat');
popup_sel_index = get(handles.popupmenu1, 'Value');
switch popup_sel_index
    case 1
        try
            vid = ipcam(camurl1);
            img = snapshot(vid);
            handles.vid=vid;
            hImage = image( zeros(size(img)) );
            preview(handles.vid, hImage)
        catch E
            msgbox({'Configure The Cam Correctly!',' ',E.message},'CAM INFO')
        end
        guidata(hObject, handles);
        
    case 2
        try
            vid = ipcam(camurl2);
            img = snapshot(vid);
            handles.vid=vid;
            hImage = image( zeros(size(img)) );
            preview(handles.vid, hImage)
        catch E
            msgbox({'Configure The Cam Correctly!',' ',E.message},'CAM INFO')
        end
        guidata(hObject, handles);
        
     case 3
        try
            vid = ipcam(camurl3);
            img = snapshot(vid);
            handles.vid=vid;
            hImage = image( zeros(size(img)) );
            preview(handles.vid, hImage)
        catch E
            msgbox({'Configure The Cam Correctly!',' ',E.message},'CAM INFO')
        end
        guidata(hObject, handles);
        
    case 4
        try
            vid = ipcam(camurl4);
            img = snapshot(vid);
            handles.vid=vid;
            hImage = image( zeros(size(img)) );
            preview(handles.vid, hImage)
        catch E
            msgbox({'Configure The Cam Correctly!',' ',E.message},'CAM INFO')
        end
        guidata(hObject, handles);
        
          
end
%%

%%% Button Processed
% camputes image from selected camera and processes it to find parked and
% vacant slots
function pushbutton2_Callback(hObject, eventdata, handles)
axes(handles.axes1);
cla;
load('slots.mat');
processFlag=1;
popup_sel_index = get(handles.popupmenu1, 'Value');
switch popup_sel_index
    case 1
        try
%            [totalSpots, NoOfVacantSpot, nearestParkingSpot]=calcspot(3);
%            a= num2str(totalSpots);
%            b=(NoOfVacantSpot);
%            c=(nearestParkingSpot);
           % a=8;
           % b=7;
           % c=2;
%             msgbox({'Total no. of spots :' a 'No. of Vacancy :' b 'Nearest Spot :' c},'Current Status','custom',imread('ParkLogo.png'));
            vid = ipcam(camurl1);
            guidata(hObject, handles);
            img = snapshot(vid);
            handles.vid=vid;
            hImage = image( zeros(size(img)));
            preview(handles.vid, hImage)
            set(handles.text1, 'String','Vehicle No.              :');
            set(handles.text2, 'String','Vehicle Class         :');
            set(handles.text3, 'String','Time of Entry         :');
            [numberplate,class,amount] = numberPlateExtraction1(img,'In');
            %set the status panel
            x=clock;
            y = num2str(x(2))
            y = [y '/']
            y = [y num2str(x(3))]
            y = [y ' , ']
            y = [y num2str(x(4))]
            y = [y ':']
            y = [y num2str(x(5))]
            set(handles.text4, 'String',numberplate);
            set(handles.text5, 'String','CAR');
            set(handles.text6, 'String',y);
            if (numberplate == '0')
            msgbox({'!!! Number plate Cant be read !!!'},'Error')
            end
            
            imagesc(img);
            axis off;
            pause(5)
            
            
        catch E
           msgbox({'!!! Configure Camera Correctly !!!'},'Error')
        end

    case 2
        try
            vid = ipcam(camurl1);
            guidata(hObject, handles);
            img = snapshot(vid);
            handles.vid=vid;
            hImage = image( zeros(size(img)));
            preview(handles.vid, hImage)
            set(handles.text1, 'String','Vehicle No.              :');
            set(handles.text2, 'String','Time of Exit         :');
            set(handles.text3, 'String','Amount         :');
            [numberplate,class,amount] = numberPlateExtraction1(img,'Ot');
            %set the status panel
            x=clock;
            y = num2str(x(2))
            y = [y '/']
            y = [y num2str(x(3))]
            y = [y ' , ']
            y = [y num2str(x(4))]
            y = [y ':']
            y = [y num2str(x(5))]
            set(handles.text4, 'String',numberplate);
            set(handles.text5, 'String',y);
            set(handles.text6, 'String',amount);
            if (numberplate == '0')
            msgbox({'!!! Number plate Cant be read !!!'},'Error')
            end
            
            imagesc(img);
            axis off;
            pause(5)
            
            
        catch E
           msgbox({'!!! Configure Camera Correctly !!!'},'Error')
        end
        
     
     case 3
        try
            vid = ipcam(camurl3);
            bck_image = double(imread('refcam3.jpg'));
            bck_img = bck_image(:,:,1);
            nodes = load('slots.mat', 'corcam3');
            nodes = nodes.corcam3;
            tps=size(nodes);
            tps=tps(1);
            
        catch E
            msgbox({'Configure The Cam Correctly!',' ',E.message},'CAM INFO')
        end

     case 4
        try
            vid = ipcam(camurl4);
            bck_image = double(imread('refcam4.jpg'));
            bck_img = bck_image(:,:,1);
            nodes = load('slots.mat', 'corcam4');
            nodes = nodes.corcam4;
            tps=size(nodes);
            tps=tps(1);
            
        catch E
            msgbox({'Configure The Cam Correctly!',' ',E.message},'CAM INFO')
        end
        
        
end

guidata(hObject, handles);
img = snapshot(vid);
handles.vid=vid;
hImage = image( zeros(size(img)));
preview(handles.vid, hImage)

if(popup_sel_index==1 || popup_sel_index==2)
    processFlag=0;
end
if (processFlag==1)   
    while (processFlag==1)
        %% from raw color image to binary image with highlighted occupied spots
        himage2 = snapshot(vid);
        num3 = load('slots.mat', 'thres');num3 = str2double(num3.thres);          %threshold
        num4 = load('slots.mat', 'eliminate');num4= str2double(num4.eliminate);   %bwareopen
        hsize = load('slots.mat', 'hsize');hsize= str2double(hsize.hsize);        %gaussian filter
        sigma = load('slots.mat', 'sigma');sigma=str2double(sigma.sigma);
        gaus_filt = fspecial('gaussian',hsize , sigma);
        
        img_tmp = double(himage2);                                    %load image and convert to double for computation
        img2 = img_tmp(:,:,1);                                        %reduce to just the first dimension
        sub_img = (img2 - bck_img);                                   %subtract background from the image
        gaus_img = filter2(gaus_filt,sub_img,'same');                 %gaussian blurr the image
        thres_img = (gaus_img < num3);
        thres_img = ~thres_img;
        thres_img = bwareaopen(thres_img,num4);
        thres_img = ~thres_img;
        se2 = strel('disk',1);
        thres_img = imerode(thres_img,se2);
        
        %% counting no of blobs
        thres_img = ~thres_img;
        [L, num] = bwlabel(thres_img);
        stats = regionprops(L, 'Centroid');
        thres_img = ~thres_img;
        
        %% highlight strange objects
        img3 = himage2;
        % circle parameters
        r = 15;                                                                    % radius
        t = linspace(0, 2*pi, 20);                                                 % approximate circle with 50 points
        
        %      for k=1:1:num
        %          c = [stats(k,1).Centroid(1) stats(k,1).Centroid(2)];                   % center()
        %          BW = poly2mask(r*cos(t)+c(1), r*sin(t)+c(2), size(img,1), size(img,2));% create a circular mask
        %          clr = [0 0 255];            % Blue color for circle
        %          a = 0.8;                    % blending factor
        %          z = false(size(BW));
        %          mask = cat(3,BW,z,z); img3(mask) = a*clr(1) + (1-a)*img3(mask);
        %          mask = cat(3,z,BW,z); img3(mask) = a*clr(2) + (1-a)*img3(mask);
        %          mask = cat(3,z,z,BW); img3(mask) = a*clr(3) + (1-a)*img3(mask);
        %      end
        %% highlight Occupied and Unoccupied slots
        num2 = 0;
        for k=1:1:tps
            c = [nodes(k,1) nodes(k,2)];                   % center
            BW = poly2mask(r*cos(t)+c(1), r*sin(t)+c(2), size(img,1), size(img,2));% create a circular mask
            if thres_img(nodes(k,2), nodes(k,1))== 0
                clr = [255 0 0 ];            % Red color for circle
                num2 = num2 + 1;             % counting no of filled spots
            else
                clr = [0 255 0 ];            % Green color for circle
            end
            a = 0.8;                         % blending factor
            z = false(size(BW));
            mask = cat(3,BW,z,z); img3(mask) = a*clr(1) + (1-a)*img3(mask);
            mask = cat(3,z,BW,z); img3(mask) = a*clr(2) + (1-a)*img3(mask);
            mask = cat(3,z,z,BW); img3(mask) = a*clr(3) + (1-a)*img3(mask);
        end
        %% Results
        %set the status panel
        set(handles.text1, 'String','Total                 :');
        set(handles.text2, 'String','Occupied         :');
        set(handles.text3, 'String','vacant               :');
        set(handles.text4, 'String',num2str(tps));
        set(handles.text5, 'String',num2str(num2));
        set(handles.text6, 'String',num2str(tps-num2));
        
        imagesc(img3);
        axis off;
        pause(.1)
        
    end
end
    %%
    
    %%% Button Settings
    % Jumps to Settings function
    function pushbutton3_Callback(hObject, eventdata, handles)
    %closePreview(vid);
    processFlag=0;
    Settings()
