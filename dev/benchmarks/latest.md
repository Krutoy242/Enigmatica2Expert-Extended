## Minecraft load time benchmark


---

<p align="center" style="font-size:160%;">
MC total load time:<br>
536.65 sec
<br>
<sup><sub>(
8:56 min
)</sub></sup>
</p>

<br>


<p align="center">
<img src="https://quickchart.io/chart?w=400&h=30&c={
  type: 'horizontalBar',
  data: {
    datasets: [
      {label:      'MODS:', data: [303.08]},
      {label: 'FML stuff:', data: [233.57]}
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
436e17  25.60s Had Enough Items;
3C6315  16.12s Had Enough Items (Plugins);
813e81  12.09s OpenComputers;
516fa8  10.62s Ender IO;
a651a8  10.51s IndustrialCraft 2;
5161a8   1.18s CraftTweaker2;
495797   8.95s CraftTweaker2 (Script Loading);
8f3087   9.18s Forge Mod Loader;
8f304e   7.15s Astral Sorcery;
cd922c   5.88s NuclearCraft;
8c2ccd   5.42s Immersive Engineering;
6e175e   5.03s Recurrent Complex;
213664   4.97s Forestry;
538f30   4.04s Animania;
308f53   4.02s Village Names;
436e17   4.01s Integrated Dynamics;
219e7b   3.92s Fluidlogged API;
a86e51   3.87s Extra Utilities 2;
8f4d30   3.72s Open Terrain Generator;
308f7e   3.50s Quark: RotN Edition;
ba3eb8   3.33s Cyclic;
649e21   3.21s OpenBlocks;
444444  79.31s 44 Other mods;
333333  60.47s 178 'Fast' mods (load 1.0s - 0.1s);
222222   7.00s 202 'Instant' mods (load %3C 0.1s)
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
OpenComputers         |  0.25|  0.02|  8.36|  3.25|  0.21|  0.00|  0.00|  0.00;
Ender IO              |  1.56|  0.01|  3.88|  0.54|  3.43|  0.15|  0.00|  1.07;
IndustrialCraft 2     |  0.73|  0.02|  8.60|  0.87|  0.00|  0.28|  0.00|  0.00;
CraftTweaker2         |  0.65|  0.00|  4.30|  0.01|  0.00|  5.17|  0.01|  0.00;
Astral Sorcery        |  0.23|  0.01|  4.70|  1.64|  0.00|  0.57|  0.00|  0.00;
NuclearCraft          |  0.57|  0.01|  4.05|  0.46|  0.00|  0.73|  0.00|  0.06;
Immersive Engineering |  0.83|  0.01|  1.19|  0.98|  0.00|  2.41|  0.00|  0.00;
Recurrent Complex     |  0.26|  0.01|  0.72|  0.93|  0.00|  3.12|  0.00|  0.00;
Forestry              |  0.40|  0.01|  3.25|  1.01|  0.00|  0.29|  0.00|  0.00;
Animania              |  0.32|  0.00|  3.19|  0.10|  0.00|  0.42|  0.00|  0.00;
Village Names         |  0.12|  0.00|  3.71|  0.19|  0.00|  0.00|  0.00|  0.00;
Integrated Dynamics   |  0.45|  0.01|  3.50|  0.05|  0.00|  0.00|  0.00|  0.00
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
  2.41: cofh.thermalexpansion.plugins.jei.JEIPluginTE;
  1.39: com.github.sokyranthedragon.mia.integrations.jer.JeiJerIntegration$1;
  1.31: jeresources.jei.JEIConfig;
  0.99: com.rwtema.extrautils2.crafting.jei.XUJEIPlugin;
  0.80: ic2.jeiIntegration.SubModule;
  0.79: mezz.jei.plugins.vanilla.VanillaPlugin;
  0.76: crazypants.enderio.machines.integration.jei.MachinesPlugin;
  0.63: nc.integration.jei.NCJEI;
  0.53: com.buuz135.thaumicjei.ThaumcraftJEIPlugin;
  0.53: knightminer.tcomplement.plugin.jei.JEIPlugin;
  0.51: com.buuz135.industrial.jei.JEICustomPlugin;
  0.36: crazypants.enderio.base.integration.jei.JeiPlugin;
  0.30: forestry.factory.recipes.jei.FactoryJeiPlugin;
  0.24: net.bdew.jeibees.BeesJEIPlugin;
  0.24: ninjabrain.gendustryjei.GendustryJEIPlugin;
  4.32: Other 127 Plugins
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
            text: [233.57,'s'].join(''),
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
993A00   1.53s Loading sounds;
994400   1.59s Loading Resource - SoundHandler;
994F00  45.02s ModelLoader: blocks;
995900  15.31s ModelLoader: items;
996300  16.10s ModelLoader: baking;
996D00   2.09s Applying remove recipe actions;
997700   0.15s Applying remove furnace recipe actions;
998200   0.83s Indexing ingredients;
998C00   8.41s Indexing ingredients;
444444 142.55s Other
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
