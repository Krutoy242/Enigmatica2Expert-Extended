## Minecraft load time benchmark


---

<p align="center" style="font-size:160%;">
MC total load time:<br>
582.04 sec
<br>
<sup><sub>(
9:42 min
)</sub></sup>
</p>

<br>


<p align="center">
<img src="https://quickchart.io/chart?w=400&h=30&c={
  type: 'horizontalBar',
  data: {
    datasets: [
      {label:      'MODS:', data: [386.05]},
      {label: 'FML stuff:', data: [195.99]}
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
436e17  59.13s Had Enough Items;
813e81  14.35s OpenComputers;
516fa8  13.95s Ender IO;
5161a8   1.58s CraftTweaker2;
495797  10.50s CraftTweaker2 (Script Loading);
5c308f  10.35s Mod Tweaker;
8f304e  10.21s Astral Sorcery;
8f3087   9.83s Forge Mod Loader;
a651a8   8.02s IndustrialCraft 2;
6e175e   7.71s Recurrent Complex;
cd922c   7.64s NuclearCraft;
213664   7.09s Forestry;
8c2ccd   6.61s Immersive Engineering;
3e7d81   4.99s ProbeZS;
8f4d30   4.95s Open Terrain Generator;
308f7e   4.51s Quark: RotN Edition;
308f53   4.40s Village Names;
a86e51   4.33s Extra Utilities 2;
436e17   3.95s Integrated Dynamics;
649e21   3.87s OpenBlocks;
ba3eb8   3.83s Cyclic;
444444 110.37s 57 Other mods;
333333  67.59s 188 'Fast' mods (load 1.0s - 0.1s);
222222   6.27s 183 'Instant' mods (load %3C 0.1s)
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
OpenComputers          |  0.43|  0.02|  9.04|  4.49|  0.37|  0.00|  0.00|  0.00;
Ender IO               |  1.91|  0.02|  4.66|  0.57|  4.68|  0.20|  0.00|  1.91;
CraftTweaker2          |  0.76|  0.00|  4.58|  0.01|  0.00|  6.71|  0.03|  0.00;
Mod Tweaker            |  0.01|  0.00|  0.01|  0.00|  0.00|  0.00| 10.34|  0.00;
Astral Sorcery         |  0.27|  0.01|  7.45|  1.84|  0.00|  0.65|  0.00|  0.00;
IndustrialCraft 2      |  0.95|  0.02|  5.78|  0.97|  0.00|  0.31|  0.00|  0.00;
Recurrent Complex      |  0.50|  0.00|  0.92|  1.00|  0.00|  5.29|  0.00|  0.00;
NuclearCraft           |  0.71|  0.01|  4.92|  0.51|  0.00|  1.40|  0.00|  0.10;
Forestry               |  0.46|  0.01|  4.96|  1.16|  0.00|  0.49|  0.00|  0.00;
Immersive Engineering  |  1.03|  0.01|  1.36|  1.11|  0.00|  3.09|  0.00|  0.00;
ProbeZS                |  0.04|  0.00|  0.11|  0.00|  0.00|  4.82|  0.00|  0.00;
Open Terrain Generator |  0.08|  0.01|  0.00|  4.86|  0.00|  0.00|  0.00|  0.00
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
            text: [195.99,'s'].join(''),
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
993A00   0.88s Loading sounds;
994400   0.97s Loading Resource - SoundHandler;
994F00  46.75s ModelLoader: blocks;
995900  14.75s ModelLoader: items;
996300  19.64s ModelLoader: baking;
996D00   2.81s Applying remove recipe actions;
997700   0.14s Applying remove furnace recipe actions;
998200   1.69s Indexing ingredients;
998C00  12.59s Indexing ingredients;
444444  95.77s Other
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
