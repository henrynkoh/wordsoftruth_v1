require 'ostruct'
require 'net/http'
require 'uri'

class YoutubeAutomationController < ApplicationController
  before_action :set_default_stats

  def index
    # YouTube video processing landing page
    @recent_batches = YoutubeVideoBatch.recent.limit(5) if defined?(YoutubeVideoBatch)
    @processing_stats = calculate_processing_stats
  end

  def start_automation
    # Parse URLs with better handling for concatenated URLs
    raw_input = params[:youtube_urls].to_s
    
    # First split by newlines
    video_urls = raw_input.split(/\r?\n/).map(&:strip).reject(&:blank?)
    
    # If we only got one "URL" but it contains multiple YouTube patterns, split them
    if video_urls.size == 1 && video_urls.first.include?('youtube.com')
      # Try to split by common separators
      single_url = video_urls.first
      video_urls = single_url.split(/[,\s]+/).map(&:strip).reject(&:blank?)
    end

    # Validate URLs
    valid_urls = []
    invalid_urls = []
    
    video_urls.each do |url|
      if valid_youtube_url?(url)
        valid_urls << url
      else
        invalid_urls << url
      end
    end

    if valid_urls.empty?
      flash[:error] = "유효한 YouTube URL을 입력해주세요."
      redirect_to youtube_automation_index_path and return
    end

    # Create batch for processing
    batch_id = SecureRandom.uuid
    batch_data = {
      id: batch_id,
      urls: valid_urls,
      status: 'processing',
      created_at: Time.current,
      total_count: valid_urls.size,
      processed_count: 0,
      success_count: 0,
      error_count: 0
    }

    # Store batch in cache for progress tracking
    Rails.cache.write("youtube_batch_#{batch_id}", batch_data, expires_in: 1.hour)

    # Start background processing
    valid_urls.each_with_index do |url, index|
      YoutubeVideoProcessingJob.perform_later(url, batch_id, index)
    end

    flash[:success] = "#{valid_urls.size}개의 동영상 처리를 시작했습니다. 배치 ID: #{batch_id}"
    
    if invalid_urls.any?
      flash[:warning] = "#{invalid_urls.size}개의 잘못된 URL이 제외되었습니다."
    end

    redirect_to youtube_automation_index_path
  end

  private

  def valid_youtube_url?(url)
    return false if url.blank?
    
    # Check for YouTube URL patterns
    youtube_patterns = [
      /youtube\.com\/watch\?v=/,
      /youtu\.be\//,
      /youtube\.com\/embed\//,
      /youtube\.com\/v\//
    ]
    
    youtube_patterns.any? { |pattern| url.match?(pattern) }
  end

  def set_default_stats
    @processing_stats = {
      total_processed: 0,
      success_rate: 0,
      average_processing_time: 0,
      today_processed: 0
    }
  end

  def calculate_processing_stats
    # This would typically query your database
    # For now, return default stats
    {
      total_processed: 0,
      success_rate: 0,
      average_processing_time: 0,
      today_processed: 0
    }
  end
end
