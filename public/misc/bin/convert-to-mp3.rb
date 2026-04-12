#!/usr/bin/env ruby

require "find"
require "fileutils"
require "pathname"
require "shellwords"

base_path = File.expand_path(File.dirname(__FILE__))
base_output_path = "/Volumes/S14TB-1/media/deemix/mp3/"
target_path = "/Volumes/S14TB-1/media/plex/rick/music/"

def convert_to_mp3(input_path, output_path)
  puts "Converting #{input_path} to #{output_path}"
  command = %Q|time ffmpeg -i #{input_path.shellescape} -ab 320k -map_metadata 0 -id3v2_version 3 #{output_path.shellescape}|
  puts command
  system(command)
end

Find.find(File.join(base_path, "music")) do |path|
  if File.file?(path)
    if File.extname(path).downcase == ".flac"
      relative_path = Pathname.new(path).relative_path_from(Pathname.new(File.join(base_path, "music")))
      target_file_path = File.join(target_path, relative_path.to_s.sub(/\.flac$/, ".mp3"))
      next if File.file?(target_file_path)
      mp3_path = File.join(base_output_path, relative_path.to_s.sub(/\.flac$/, ".mp3"))
      FileUtils.mkdir_p(File.dirname(mp3_path))

      if !File.file?(mp3_path)
        convert_to_mp3(path, mp3_path)
      end

      FileUtils.mkdir_p(File.dirname(target_file_path))

      if !File.file?(target_file_path)
        puts "Copying #{mp3_path} to #{target_file_path}"
        FileUtils.cp(mp3_path, target_file_path)
      end
    elsif File.extname(path).downcase == ".mp3"
      # sometimes we have a fallback from .flac to .mp3, so we need to copy that to the target path
      relative_path = Pathname.new(path).relative_path_from(Pathname.new(File.join(base_path, "music")))
      target_file_path = File.join(target_path, relative_path.to_s)
      FileUtils.mkdir_p(File.dirname(target_file_path))

      if !File.file?(target_file_path)
        puts "Copying #{path} to #{target_file_path}"
        FileUtils.cp(path, target_file_path)
      end
    elsif File.extname(path).downcase =~ /gif|jpe?g|png/
      relative_path = Pathname.new(path).relative_path_from(Pathname.new(File.join(base_path, "music")))
      output_file_path = File.join(base_output_path, relative_path.to_s)
      FileUtils.mkdir_p(File.dirname(output_file_path))

      if !File.file?(output_file_path)
        puts "Copying #{path} to #{output_file_path}"
        FileUtils.cp(path, output_file_path)
      end
    end
  end
end
