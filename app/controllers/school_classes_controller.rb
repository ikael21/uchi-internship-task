class SchoolClassesController < ApplicationController
  def index
    school_classes = SchoolClass.for_school(params[:school_id])
      .page(params[:page])
      .per(params[:per_page])

    render json: {
      data: SchoolClassSerializer.new(school_classes).serializable_hash,
      meta: pagination_meta(school_classes)
    }
  end
end
