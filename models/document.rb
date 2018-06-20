# frozen_string_literal: true

module Edocument
  # Behaviors of the currently logged in account
  class Document
    attr_reader :id, :filename, :relative_path, :description, # basic info
                :content

    def initialize(info)
      @id             = info['id']
      @filename       = info['filename']
      @relative_path  = info['relative_path']
      @description    = info['description']
      @content        = info['content']
    end
  end
end
