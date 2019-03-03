class PdfService
  attr_reader :html, :file_name

  def initialize(html, file_name)
    @html = html
    @fileName = file_name
  end

  def api_key
    ENV['API2PDF']
  end

  def endpoint
    'https://v2018.api2pdf.com'
  end

  def convert_from_html
    Unirest.post endpoint+"/wkhtmltopdf/html",
      headers: {Accept: "application/json", Authorization: api_key},
      parameters: {
        html: html.to_str,
        inlinePdf: true,
        fileName: file_name
      }.to_json
  end
end
