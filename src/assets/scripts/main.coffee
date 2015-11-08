Series = require('./series')

$(document).on('ready', () ->

  sIdx = 1
  series = new Series()

  $(document).on('click', '#new-function', () ->
    $('#sinusoids').find('#new-function').remove()
    $('#sinusoids').append(
     '<div data-idx="'+ sIdx++ + '" class="sinusoid"><div class="row"><div class="col-xs-1"><input type="text" class="form-control amplitude"></div><div class="col-xs-1"><input type="text" class="form-control freq"></div><div class="col-xs-1"><input type="text" class="form-control phase"></div><div class="col-xs-1"><input type="text" class="form-control shift"></div><div class="col-xs-1"><a id="new-function"><div class="glyphicon glyphicon-plus"></div></a></div></div></div>'
    )
  )

  $(document).on('click', '#graph-it', () ->
    timeSeriesGraph.series[0].setData(series.createTimeSeries())
    freqSeriesGraph.series[0].setData(series.getFreqSeries())
    phaseSeriesGraph.series[0].setData(series.getPhaseSeries())
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
      lineWidth: 6,
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
      lineWidth: 6,
      name: "Sample",
      data: series.getPhaseSeries()
    }]
  })
)

