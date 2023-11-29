## Minecraft load time benchmark


---

<p align="center" style="font-size:160%;">
MC total load time:<br>
566.30 sec
<br>
<sup><sub>(
9:26 min
)</sub></sup>
</p>

<br>


<p align="center">
<img src="https://quickchart.io/chart?w=400&h=30&c={
  type: 'horizontalBar',
  data: {
    datasets: [
      {label:      'MODS:', data: [335.82]},
      {label: 'FML stuff:', data: [230.48]}
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
436e17  44.43s Had Enough Items;
813e81  13.34s OpenComputers;
516fa8  12.09s Ender IO;
5161a8  11.58s CraftTweaker2;
cd922c   7.75s NuclearCraft;
8f304e   7.43s Astral Sorcery;
5c308f   7.29s Mod Tweaker;
8f3087   6.89s Forge Mod Loader;
a651a8   6.78s IndustrialCraft 2;
8c2ccd   6.02s Immersive Engineering;
6e175e   5.94s Recurrent Complex;
213664   5.48s Forestry;
8f4d30   4.48s Open Terrain Generator;
a86e51   4.35s Extra Utilities 2;
436e17   4.14s Integrated Dynamics;
308f53   4.09s Village Names;
308f7e   3.62s Quark: RotN Edition;
3e7d81   3.60s ProbeZS;
ba3eb8   3.58s Cyclic;
3e68ba   3.57s AE2 Unofficial Extended Life;
444444  99.97s 53 Other mods;
333333  62.66s 179 'Fast' mods (load 1.0s - 0.1s);
222222   6.72s 197 'Instant' mods (load %3C 0.1s)
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
OpenComputers          |  0.45|  0.02|  8.90|  3.71|  0.27|  0.00|  0.00|  0.00;
Ender IO               |  1.69|  0.01|  4.38|  0.53|  4.02|  0.16|  0.00|  1.30;
CraftTweaker2          |  0.58|  0.00|  4.60|  0.01|  0.00|  6.31|  0.07|  0.00;
NuclearCraft           |  1.51|  0.01|  4.89|  0.50|  0.00|  0.77|  0.00|  0.06;
Astral Sorcery         |  0.25|  0.01|  4.85|  1.63|  0.00|  0.70|  0.00|  0.00;
Mod Tweaker            |  0.00|  0.00|  0.01|  0.00|  0.00|  0.00|  7.28|  0.00;
IndustrialCraft 2      |  0.81|  0.02|  4.69|  0.98|  0.00|  0.28|  0.00|  0.00;
Immersive Engineering  |  0.90|  0.01|  1.34|  1.07|  0.00|  2.71|  0.00|  0.00;
Recurrent Complex      |  0.31|  0.00|  0.77|  1.11|  0.00|  3.75|  0.00|  0.00;
Forestry               |  0.41|  0.02|  3.62|  1.08|  0.00|  0.35|  0.00|  0.00;
Open Terrain Generator |  0.06|  0.01|  0.00|  4.41|  0.00|  0.00|  0.00|  0.00;
Extra Utilities 2      |  0.20|  0.01|  3.83|  0.08|  0.00|  0.23|  0.00|  0.00
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
            text: [230.48,'s'].join(''),
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
993A00   1.31s Loading sounds;
994400   1.39s Loading Resource - SoundHandler;
994F00  46.45s ModelLoader: blocks;
995900  16.65s ModelLoader: items;
996300  16.89s ModelLoader: baking;
996D00   2.25s Applying remove recipe actions;
997700   0.37s Applying remove furnace recipe actions;
998200   0.63s Indexing ingredients;
998C00   9.60s Indexing ingredients;
444444 134.95s Other
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
