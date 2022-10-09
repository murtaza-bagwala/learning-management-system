# frozen_string_literal: true

module Api
  module V1
    class CoursesController < ApplicationController
      skip_before_action :authenticate_user!, only: %i[index]
    end
  end
end
