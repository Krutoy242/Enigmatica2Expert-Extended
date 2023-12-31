## Minecraft load time benchmark


---

<p align="center" style="font-size:160%;">
MC total load time:<br>
598.88 sec
<br>
<sup><sub>(
9:58 min
)</sub></sup>
</p>

<br>


<p align="center">
<img src="https://quickchart.io/chart?w=400&h=30&c={
  type: 'horizontalBar',
  data: {
    datasets: [
      {label:      'MODS:', data: [383.05]},
      {label: 'FML stuff:', data: [215.83]}
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
436e17  63.63s Had Enough Items;
9e2174   2.88s Tinkers' Construct;
8E1E68  27.98s Tinkers' Construct (Oredict Melting);
516fa8  13.04s Ender IO;
813e81  12.66s OpenComputers;
5161a8  11.18s CraftTweaker2;
5c308f   8.06s Mod Tweaker;
8f304e   7.26s Astral Sorcery;
cd922c   7.03s NuclearCraft;
a651a8   6.21s IndustrialCraft 2;
8f3087   6.16s Forge Mod Loader;
6e175e   5.96s Recurrent Complex;
8c2ccd   5.64s Immersive Engineering;
213664   5.28s Forestry;
8f4d30   4.60s Open Terrain Generator;
3ebab8   4.55s CoFH World;
a86e51   4.21s Extra Utilities 2;
436e17   4.03s Integrated Dynamics;
308f53   3.95s Village Names;
3e7d81   3.77s ProbeZS;
308f7e   3.69s Quark: RotN Edition;
444444 102.00s 52 Other mods;
333333  62.55s 178 'Fast' mods (load 1.0s - 0.1s);
222222   6.73s 199 'Instant' mods (load %3C 0.1s)
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
Tinkers' Construct     |  1.07|  0.01|  0.17|  0.07|  0.00| 29.53|  0.00|  0.00;
Ender IO               |  1.85|  0.01|  4.18|  0.58|  3.67|  1.61|  0.00|  1.14;
OpenComputers          |  0.41|  0.02|  8.61|  3.41|  0.22|  0.00|  0.00|  0.00;
CraftTweaker2          |  0.54|  0.00|  4.22|  0.01|  0.00|  6.33|  0.09|  0.00;
Mod Tweaker            |  0.00|  0.00|  0.01|  0.00|  0.00|  0.00|  8.04|  0.00;
Astral Sorcery         |  0.22|  0.01|  4.67|  1.77|  0.00|  0.59|  0.00|  0.00;
NuclearCraft           |  1.22|  0.01|  4.38|  0.45|  0.00|  0.90|  0.00|  0.07;
IndustrialCraft 2      |  0.71|  0.02|  4.24|  0.94|  0.00|  0.29|  0.00|  0.00;
Recurrent Complex      |  0.50|  0.00|  0.75|  1.11|  0.00|  3.60|  0.00|  0.00;
Immersive Engineering  |  0.85|  0.01|  1.23|  1.14|  0.00|  2.41|  0.00|  0.00;
Forestry               |  0.38|  0.01|  3.28|  1.16|  0.00|  0.44|  0.00|  0.00;
Open Terrain Generator |  0.05|  0.01|  0.00|  4.55|  0.00|  0.00|  0.00|  0.00
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
            text: [215.83,'s'].join(''),
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
993A00   1.23s Loading sounds;
994400   1.29s Loading Resource - SoundHandler;
994F00  42.11s ModelLoader: blocks;
995900  14.37s ModelLoader: items;
996300  15.91s ModelLoader: baking;
996D00   2.48s Applying remove recipe actions;
997700   0.41s Applying remove furnace recipe actions;
998200   0.76s Indexing ingredients;
998C00  16.09s Indexing ingredients;
444444 121.18s Other
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
