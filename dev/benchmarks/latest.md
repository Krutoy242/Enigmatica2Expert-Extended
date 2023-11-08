## Minecraft load time benchmark


---

<p align="center" style="font-size:160%;">
MC total load time:<br>
523.91 sec
<br>
<sup><sub>(
8:43 min
)</sub></sup>
</p>

<br>


<p align="center">
<img src="https://quickchart.io/chart?w=400&h=30&c={
  type: 'horizontalBar',
  data: {
    datasets: [
      {label:      'MODS:', data: [354.68]},
      {label: 'FML stuff:', data: [169.23]}
    ]
  },
  options: {
    scales: {
      xAxes: [{display: false,stacked: true}],
      yAxes: [{display: false,stacked: true}],
    },
    elements: {rectangle: {borderWidth: 2}},
    legend: {display: false,},
    plugins: {datalabels: {color: 'white',formatter: (value, context) =>
      [context.dataset.label, value].join(' ')
    }}
  }
}"/>
</p>

<br>

# Mods Loading Time
<p align="center">
<img src="https://quickchart.io/chart?w=400&h=300&c={
  type: 'outlabeledPie',
  options: {
    cutoutPercentage: 25,
    plugins: {
      legend: !1,
      outlabels: {
        stretch: 5,
        padding: 1,
        text: (v,i)=>[
          v.labels[v.dataIndex],' ',
          (v.percent*1000|0)/10,
          String.fromCharCode(37)].join('')
      }
    }
  },
  data: {...
`
436e17  42.43s Had Enough Items;
9e2174   2.74s Tinkers' Construct;
8E1E68  25.53s Tinkers' Construct (Oredict Melting);
813e81  12.81s OpenComputers;
516fa8  11.62s Ender IO;
8f3087  11.47s Forge Mod Loader;
5161a8   1.65s CraftTweaker2;
495797   8.98s CraftTweaker2 (Script Loading);
cd922c   7.20s NuclearCraft;
8f304e   7.19s Astral Sorcery;
a651a8   6.59s IndustrialCraft 2;
5c308f   6.45s Mod Tweaker;
8c2ccd   5.64s Immersive Engineering;
6e175e   5.52s Recurrent Complex;
213664   5.04s Forestry;
a86e51   4.30s Extra Utilities 2;
8f4d30   4.21s Open Terrain Generator;
436e17   4.05s Integrated Dynamics;
308f53   3.91s Village Names;
3e7d81   3.63s ProbeZS;
308f7e   3.54s Quark: RotN Edition;
ba3eb8   3.31s Cyclic;
444444  95.62s 52 Other mods;
333333  64.69s 181 'Fast' mods (load 1.0s - 0.1s);
222222   6.55s 194 'Instant' mods (load %3C 0.1s)
`
    .split(';').reduce((a, l) => {
      l.match(/(\w{6}) *(\d*\.\d*)s (.*)/)
      .slice(1).map((a, i) => [[String.fromCharCode(35),a].join(''), parseFloat(a), a][i])
      .forEach((s, i) => 
        [a.datasets[0].backgroundColor, a.datasets[0].data, a.labels][i].push(s)
      );
      return a
    }, {
      labels: [],
      datasets: [{
        backgroundColor: [],
        data: [],
        borderColor: 'rgba(22,22,22,0.3)',
        borderWidth: 1
      }]
    })
  }
}"/>
</p>

<br>

# Top Mods Details (except JEI, FML and Forge)
<p align="center">
<img src="https://quickchart.io/chart?w=400&h=450&c={
  options: {
    scales: {
      xAxes: [{stacked: true}],
      yAxes: [{stacked: true}],
    },
    plugins: {
      datalabels: {
        anchor: 'end',
        align: 'top',
        color: 'white',
        backgroundColor: 'rgba(46, 140, 171, 0.6)',
        borderColor: 'rgba(41, 168, 194, 1.0)',
        borderWidth: 0.5,
        borderRadius: 3,
        padding: 0,
        font: {size:10},
        formatter: (v,ctx) => 
          ctx.datasetIndex!=ctx.chart.data.datasets.length-1 ? null
            : [((ctx.chart.data.datasets.reduce((a,b)=>a- -b.data[ctx.dataIndex],0)*10)|0)/10,'s'].join('')
      },
      colorschemes: {
        scheme: 'office.Damask6'
      }
    }
  },
  type: 'bar',
  data: {...(() => {
    let a = { labels: [], datasets: [] };
`
1: Construction;
2: Loading Resources;
3: PreInitialization;
4: Initialization;
5: InterModComms$IMC;
6: PostInitialization;
7: LoadComplete;
8: ModIdMapping
`
    .split(';')
      .map(l => l.match(/\d: (.*)/).slice(1))
      .forEach(([name]) => a.datasets.push({ label: name, data: [] }));
`
                          1      2      3      4      5      6      7      8  ;
Tinkers' Construct    |  1.21|  0.01|  0.20|  0.06|  0.00| 26.79|  0.00|  0.00;
OpenComputers         |  0.73|  0.02|  8.57|  3.28|  0.22|  0.00|  0.00|  0.00;
Ender IO              |  2.18|  0.01|  3.99|  0.51|  3.39|  0.63|  0.00|  0.90;
CraftTweaker2         |  0.69|  0.00|  4.49|  0.01|  0.00|  5.42|  0.01|  0.00;
NuclearCraft          |  1.39|  0.01|  4.35|  0.52|  0.00|  0.76|  0.00|  0.17;
Astral Sorcery        |  0.25|  0.01|  4.77|  1.63|  0.00|  0.53|  0.00|  0.00;
IndustrialCraft 2     |  0.90|  0.02|  4.50|  0.92|  0.00|  0.26|  0.00|  0.00;
Mod Tweaker           |  0.01|  0.00|  0.01|  0.00|  0.00|  0.00|  6.44|  0.00;
Immersive Engineering |  1.10|  0.01|  1.25|  1.03|  0.00|  2.25|  0.00|  0.00;
Recurrent Complex     |  0.32|  0.00|  0.74|  0.93|  0.00|  3.53|  0.00|  0.00;
Forestry              |  0.47|  0.04|  3.19|  1.03|  0.00|  0.33|  0.00|  0.00;
Extra Utilities 2     |  0.21|  0.01|  3.76|  0.07|  0.00|  0.26|  0.00|  0.00
`
    .split(';').slice(1)
      .map(l => l.split('|').map(s => s.trim()))
      .forEach(([name, ...arr], i) => {
        a.labels.push(name);
        arr.forEach((v, j) => a.datasets[j].data[i] = v)
      }); return a
  })()}
}"/>
</p>

<br>

# TOP JEI Registered Plugis
<p align="center">
<img src="https://quickchart.io/chart?w=700&c={
  options: {
    elements: { rectangle: { borderWidth: 1 } },
    legend: false
  },
  type: 'horizontalBar',
    data: {...(() => {
      let a = {
        labels: [], datasets: [{
          backgroundColor: 'rgba(0, 99, 132, 0.5)',
          borderColor: 'rgb(0, 99, 132)',
          data: []
        }]
      };
`
  0.00: Other -15 Plugins
`
        .split(';')
        .map(l => l.split(':'))
        .forEach(([time, name]) => {
          a.labels.push(name);
          a.datasets[0].data.push(time)
        })
        ; return a
    })()
  }
}"/>
</p>

<br>

# FML Stuff
<p align="center">
<img src="https://quickchart.io/chart?w=500&h=400&c={
  options: {
    rotation: Math.PI,
    cutoutPercentage: 55,
    plugins: {
      legend: !1,
      outlabels: {
        stretch: 5,
        padding: 1,
        text: (v)=>v.labels
      },
      doughnutlabel: {
        labels: [
          {
            text: 'FML stuff:',
            color: 'rgba(128, 128, 128, 0.5)',
            font: {size: 18}
          },
          {
            text: [169.23,'s'].join(''),
            color: 'rgba(128, 128, 128, 1)',
            font: {size: 22}
          }
        ]
      },
    }
  },
  type: 'outlabeledPie',
  data: {...(() => {
    let a = {
      labels: [],
      datasets: [{
        backgroundColor: [],
        data: [],
        borderColor: 'rgba(22,22,22,0.3)',
        borderWidth: 2
      }]
    };
`
993A00   0.75s Loading sounds;
994400   0.82s Loading Resource - SoundHandler;
994F00  41.54s ModelLoader: blocks;
995900  14.52s ModelLoader: items;
996300  15.36s ModelLoader: baking;
996D00   2.28s Applying remove recipe actions;
997700   0.12s Applying remove furnace recipe actions;
998200   0.97s Indexing ingredients;
998C00   8.61s Indexing ingredients;
444444  84.27s Other
`
    .split(';')
      .map(l => l.match(/(\w{6}) *(\d*\.\d*)s (.*)/))
      .forEach(([, col, time, name]) => {
        a.labels.push([name, ' ', time, 's'].join(''));
        a.datasets[0].data.push(parseFloat(time));
        a.datasets[0].backgroundColor.push([String.fromCharCode(35), col].join(''))
      })
      ; return a
  })()}
}"/>
</p>

<br>
