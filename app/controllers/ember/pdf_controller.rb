class Ember::PdfController < ApplicationController
  def generate
    Pdf.generate_pdf
  end
end
