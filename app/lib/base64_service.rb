class Base64Service

  def initialize(data)
    @data = data
  end

  def file
    document = Base64.decode64(@data).force_encoding('UTF-8')
    @temp = Tempfile.new([ 'temp', '.xml' ])
    @temp.write(document)
    @temp.rewind
    @temp
  end

  def close
    @temp.close
    @temp.unlink
  end
end
