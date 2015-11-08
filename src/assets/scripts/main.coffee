Series = require('./series')

$(document).on('ready', () ->

  sIdx = 1
  series = new Series()

  refreshGraphs = () ->
    timeSeriesGraph.series[0].setData(series.createTimeSeries())
    freqSeriesGraph.series[0].setData(series.getFreqSeries())
    phaseSeriesGraph.series[0].setData(series.getPhaseSeries()) if phaseSeriesGraph isnt null


  $('.freq-slider')
    .attr('max', $('#samples').val())
    .attr('step', $('#samples').val()/100.0)

  $('.knobs').each((idx, ele) ->
    eleToUpdate = $(this).attr('data-for')
    $(ele).closest('.sinusoid').find(eleToUpdate).val($(this).val())
  )

  $(document).on('click', '#new-function', () ->
    $('#sinusoids').find('#new-function').remove()
    $('#sinusoids').append(
      '<div data-idx="'+ sIdx++ + '" class="sinusoid"><div class="row"><div class="col-sm-6 col-md-1"><input type="text" value="1" data-for=".amp-slider" class="form-control knobs amplitude"><input type="range" min="0" max="10" step="0.5" data-for=".amplitude" class="form-control slider amp-slider"></div><div class="col-sm-6 col-md-1"><input type="text" value="2" data-for=".freq-slider" class="form-control knobs freq"><input type="range" min="0" max="64" step="0.5" data-for=".freq" class="form-control slider freq-slider"></div><div class="col-sm-6 col-md-1"><input type="text" value="0" data-for=".phase-slider" class="form-control knobs phase"><input type="range" min="0" max="6.2857142857" step="0.4" data-for=".phase" class="form-control slider phase-slider"></div><div class="col-sm-6 col-md-1"><input type="text" value="0" data-for=".shift-slider" class="form-control knobs shift"><input type="range" min="-3" max="3" step="0.25" data-for=".shift" class="form-control slider shift-slider"></div><div class="col-sm-6 col-md-1"><a id="new-function"><span class="glyphicon glyphicon-plus"></span></a></div></div></div>'
    )
  )

  $(document).on('click', '#graph-it', () ->
    refreshGraphs()
  )

  $(document).on('change', '.slider, .knobs', () ->
    eleToUpdate = $(this).attr('data-for')
    $(this).closest('.sinusoid').find(eleToUpdate).val($(this).val())
    refreshGraphs()
  )

  $(document).on('change', '#samples', () ->
    maxVal = $(this).val()
    $('.freq-slider').attr('max', maxVal)
      .attr('step', maxVal/100.0)
  )

  $(document).on('change', '#samples, #dimensions', () ->
   refreshGraphs()
  )

  timeSeriesGraph = null
  freqSeriesGraph = null
  phaseSeriesGraph = null
  $('#time-graph').highcharts({
    chart: {
      animation: false,
      options3d: {
        enabled: true
      },
      events: {
        load: () -> timeSeriesGraph = this
      }
    },
    title: {
      text: 'Discrete Time Graph'
    },
    xAxis: [{
      title: {
        text: "Time"
      }
    }],
    yAxis: [{
      min: -2,
      max:  2
    }],
    tooltip: {
      shared: true
    },
    plotOptions: {
      allowPointSelect: true
      pointPlacement: "on"
    },
    legend: {
      floating: true,
      align: 'left',
      x: 150,
      y: -320
    },
    series: [{
      marker: {
        enabled : true,
        radius : 4
      },
      lineWidth: 0,
      name: "Sample",
      data: series.getTimeSeries()
    }]
  })

  $('#freq-graph').highcharts({
    chart: {
      animation: false,
      options3d: {
        enabled: true
      },
      events: {
        load: () -> freqSeriesGraph = this
      }
    },
    title: {
      text: 'Frequency Graph'
    },
    xAxis: [{
      title: {
        text: "Freq"
      }
    }],
    yAxis: [{
      min: -40,
      max:  40
    }],
    tooltip: {
      shared: true
    },
    plotOptions: {
      allowPointSelect: true
      pointPlacement: "on"
    },
    legend: {
      floating: true,
      align: 'left',
      x: 150,
      y: -320
    },
    series: [{
      marker: {
        enabled : false,
        radius : 1
      },
      color: '#90ed7d',
      lineWidth: 3,
      name: "Sample",
      data: series.getFreqSeries()
    }]
  })

  $('#phase-graph').highcharts({
    chart: {
      animation: false,
      options3d: {
        enabled: true
      },
      events: {
        load: () -> phaseSeriesGraph = this
      }
    },
    title: {
      text: 'Phase Graph'
    },
    xAxis: [{
      title: {
        text: "Phase"
      }
    }],
    yAxis: [{
      min: -30,
      max:  30
    }],
    tooltip: {
      shared: true
    },
    plotOptions: {
      allowPointSelect: true
      pointPlacement: "on"
    },
    legend: {
      floating: true,
      align: 'left',
      x: 150,
      y: -320
    },
    series: [{
      marker: {
        enabled : false,
        radius : 1
      },
      color: '#f7a35c',
      lineWidth: 3,
      name: "Sample",
      data: series.getPhaseSeries()
    }]
  })
)

