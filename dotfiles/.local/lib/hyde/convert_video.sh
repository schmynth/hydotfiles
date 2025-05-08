#!/bin/bash

# This script looks for media files in a directory and re-encodes them to codecs selected by user

# directories

videos_dir="$HOME/Videos"
media_in_dir="$videos_dir/convert_queue"
media_out_dir="$videos_dir/converted"

# global variables

video_enc=""
out_format=""


# counts the files present in $media_in_dir
total="$( ls -A $media_in_dir | wc -l )"

# specify what icons to use
# icons_dir="/usr/share/icons/Papirus/64x64/places"
# icon_success="folder-cat-mocha-blue-video.svg"
# icon_error="folder-cat-mocha-peach-video.svg"

notify_success() {
  notify-send -i $icons_dir/$icon_success "$1"
}

notify_error() {
  notify-send -i $icons_dir/$icon_error "$1"
}

# Main Menu
main_menu_prompt() {
  cat << EOF
--------------------------
video transcoder
--------------------------
What would you like to do?
--------------------------
1) Import an incompatible video
2) Render the final video
3) Exit
EOF
}

# Input Codec Menu 
# for importing to davinci resolve
input_codec_menu_prompt() {
  cat << EOF

--------------------------
Select output codec for queued videos
--------------------------
1) DNHXR HQX
2) AV1
EOF
}

# Output Codec Menu 
# For Export
output_codec_menu_prompt() {
  cat << EOF

Select output codec for rendering
--------------------------
1) H.264
2) H.265
3) AV1
--------------------------
EOF
}



choose_input_codec() {
  # Set input codecs that will be converted
  input_codecs=("h264" "hevc")
  encoder_choice=$1

  case $encoder_choice in
    1) # DNXHR HQX
      video_enc="-c:v dnxhd -profile:v 4 -pix_fmt yuv422p10le"
      # Replace the above variable with the one below if you don't need 10-bit
      # color depth
      # video_enc="-c:v dnxhd -profile:v 3 -pix_fmt yuv422p"
      out_format="mov"
      ;;
    2) # AVI
      video_enc="-c:v libsvtav1 -preset 6 -crf 23 -pix_fmt yuv420p10le"
      out_format="mp4"
      ;;
    3) # MPEG-4 part 2
      video_enc="-c:v mpeg4 -q:v 2"
      out_format="mov"
      ;;
    4) echo "Exiting..." ; exit 0
      ;;
    *)
      notify_error "wrong option"
      ;;
  esac
}


choose_output_codec() {
  # Set input codecs that will be converted
  input_codecs=("dnxhd" "prores")
  encoder_choice=$1

  case $encoder_choice in
    1) # H.264/AVC
      video_enc="-c:v libx264 -preset slow -crf 20 -pix_fmt yuv420p -x264-params opencl=true -movflags +faststart"
      out_format="mp4"
      ;;
    2) # H.265/HEVC
      video_enc="-c:v libx265 -preset slow -crf 20 -movflags +faststart"
      out_format="mov"
      ;;
    3) # AV1
      video_enc="-c:v libsvtav1 -preset 3 -crf 25 -pix_fmt yuv420p10le -svtav1-params tune=0:fast-decode=1 -movflags +faststart"
      out_format="mp4"
      ;;
    4) echo "Exiting..." ; exit 0
      ;;
    *)
      notify_error "wrong option"
      ;;
  esac
}

encode() {
  if ! command -v ffmpeg $> /dev/null; then
    notify_error "ffmpeg needed but not found..."
    exit 2
  fi

  mkdir -p $media_in_dir $media_out_dir
  
  if [[ -z $(ls -A $media_in_dir ) ]]; then
    notify_error "No videos found in queue folder"
    exit 3
  fi

  # actual encoding
  file_index=0

  for file in $media_in_dir/*; do
    # set variables for each video file
    file_name="$(cut -c $((${#media_in_dir} +2))- <<< "$file")"
    container_format="$(cut -c 7- <<< "$(file -b --mime-type $file)")"
    video_codec="$(ffprobe -v error -show_entries stream=codec_name -select_streams v:0 -of default=noprint_wrappers=1:nokey=1 $file)"
    audio_codec="$(ffprobe -v error -show_entries stream=codec_name -select_streams a:0 -of default=noprint_wrappers=1:nokey=1 $file)"
    frame_rate="$(cut -c -2 <<< "$(ffprobe -v error -show_entries stream=avg_frame_rate -select_streams v:0 -of default=noprint_wrappers=1:nokey=1 $file)")"
    keyframe_interval="$(($frame_rate * 10))"
      
    # update ffmpeg arguments for AV1 encoder based on a video's framerate
    if [[ $enc_sel -eq 2 ]];then
      video_enc="$video_enc -g $keyframe_interval"
    fi

    # Set file extension of the input video based on it's container format
    case $container_format in
      "mp4") file_ext=".mp4";;
      "quicktime") file_ext=".mov";;
      "x-matroska") file_ext=".mkv";;
      "webm") file_ext=".webm";;
      *)
        notify_error "Unrecognized file format for file $file_name" ; exit 4;;
    esac

    # set ffmpeg arguments for encoding audio based on the file's audio codec
    if [[ $audio_codec == "aac" ]]; then
      audio_enc="-c:a pcm_s16le"
    else
      audio_enc="-c:a copy"
    fi

    # convert the videos

    if [[ "${input_codecs[*]}" =~ "$video_codec" ]]; then
      file_index=$(( $file_index + 1 ))
      notify_success "Converting... $file_index/$total"
      ffmpeg -i $file $video_enc $audio_enc $media_out_dir/$(basename $file_name $file_ext).$out_format
    fi
  done

  notify_success "All videos in queue successfully converted."
}

# Main Loop
while true; do
  main_menu_prompt
  read main_choice

  case $main_choice in
    1)
      input_codec_menu_prompt
      read encoder_choice
      choose_input_codec $encoder_choice
      echo "video_enc is $video_enc , out_format is $out_format"
      encode
      ;;
    2) 
      output_codec_menu_prompt
      read encoder_choice
      choose_output_codec $encoder_choice
      echo "video_enc is $video_enc , out_format is $out_format"
      encode
      ;;
    3)
      echo "Exiting..." ; exit 0
      ;;
    *)
      echo "invalid option"
  esac
done
