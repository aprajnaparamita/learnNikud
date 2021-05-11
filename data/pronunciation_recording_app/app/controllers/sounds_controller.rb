require 'fileutils'

class SoundsController < ApplicationController
  before_action :set_sound, only: [:show, :update, :destroy]

  # GET /sounds
  def index
    @speaker = Speaker.where(:slug => params[:speaker_slug]).first
    @sounds = Sound.where(:speaker_id => @speaker.id, :completed => nil)
    @sound  = @sounds.first
    render "sounds/index"
  end

  # GET /sounds/1
  def show
    render json: @sound
  end

  # DELETE /sounds/1
  def destroy
    @sound.completed = nil
    @sound.save
    render json: @sound
  end

  # PATCH/PUT /sounds/1
  def update
   upload = params['sound']['blob']
   name   = params['sound']['filename']
   sounds_dir = Rails.root.join("db", "sounds", @sound.speaker_id.to_s)
   FileUtils.mkdir_p sounds_dir
   sounds_dir = sounds_dir.join(name)
   File.open(sounds_dir, "wb") do |f|
     f.write(upload.read)
   end
   @sound.examples = params['sound']['examples']
   @sound.filename = name
   @sound.completed = true
   @sound.save
   render json: @sound
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sound
      @sound = Sound.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def sound_params
      params.require(:sound).permit(:character, :name, :completed, :filename, :id, :blob, :example)
    end
end
