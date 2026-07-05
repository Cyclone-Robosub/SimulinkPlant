function saveUCSCameraStream(save_flag, saved_images_path, results, tspan, dt_sample)
    try
        if save_flag
            fileType = 'MPEG-4';
            fileTypeExtension = "mp4";
    
            fprintf("Saving Camera Stream Video\n");
            saved_videos_path = fullfile(saved_images_path, "SimulationVideos");
            if(~isfolder(saved_videos_path))
                mkdir(saved_videos_path);
            end
            todayDate = datetime();
            save_file_path = fullfile(saved_videos_path,"Save_" + todayDate.Month + "_" + todayDate.Day + "_" + todayDate.Year + "_" + todayDate.Hour + todayDate.Minute + floor(todayDate.Second));
            mkdir(save_file_path);
            
            %Left Camera Write
            v = VideoWriter(fullfile(save_file_path, "LeftCamera." + fileTypeExtension), fileType);
            cameraLeftFeed = results.cameraLeft_Feed(:,:,:,:);
            camLeftFeedSize = size(cameraLeftFeed);
            frameNum = camLeftFeedSize(4);
            v.FrameRate = 33;
            open(v);
            for i = 1:frameNum
                writeVideo(v, cameraLeftFeed(:,:,:,i));
            end
            close(v);
            
            %Right Camera Write
            v = VideoWriter(fullfile(save_file_path, "RightCamera." + fileTypeExtension), fileType);
            cameraRightFeed = results.cameraRight_Feed(:,:,:,:);
            camRightFeedSize = size(cameraRightFeed);
            frameNum = camRightFeedSize(4);
            v.FrameRate = 33;
            open(v);
            for i = 1:frameNum
                writeVideo(v, cameraRightFeed(:,:,:,i));
            end
            close(v);
        end
    catch
        fprintf("Camera Stream couldn't save, most likely because there was no camera feed.");
    end
end