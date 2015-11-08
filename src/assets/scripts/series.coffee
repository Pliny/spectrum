class Series

  timeSeries: null
  fft: null

  constructor: () ->

  createTimeSeries: () ->
    @fft = null
    $samples = parseInt($('#samples').val())

    @timeSeries = (
      ((n) ->
        sampleVal = 0.0
        $('.sinusoid').each((idx, ele) ->
          $freq      = parseFloat($(ele).find('.freq').val())
          $phase     = parseFloat($(ele).find('.phase').val())
          $amplitude = parseFloat($(ele).find('.amplitude').val())
          $shift     = parseFloat($(ele).find('.shift').val())
          sampleVal += $shift + $amplitude * Math.cos((n * $freq * (2.0*Math.PI/$samples)) + $phase)
          console.log(sampleVal)
        )
        sampleVal
      )(num) for num in [0..($samples-1)]
    )

  _createFFT: () ->
    $samples = parseInt($('#samples').val())
    $dimensions = parseInt($('#dimensions').val())
    timeSeries = @getTimeSeries()

    if $dimensions isnt $samples
      timeSeries = timeSeries.concat( 0 for num in [0..($dimensions-1-$samples)])

    @fft = new FFT($dimensions, $dimensions)
    @fft.forward(timeSeries)


  getTimeSeries: () ->
    if(not @timeSeries)
      @createTimeSeries()
    @timeSeries

  getFreqSeries: () ->
    if(not @fft)
      @_createFFT()
    @fft.real

  getPhaseSeries: () ->
    if(not @fft)
      @_createFFT()
    @fft.imag


module.exports = Series
