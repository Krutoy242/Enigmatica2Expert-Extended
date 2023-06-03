## Minecraft load time benchmark


---

<p align="center" style="font-size:160%;">
MC total load time:<br>
543.10 sec
<br>
<sup><sub>(
9:3 min
)</sub></sup>
</p>

<br>


<p align="center">
<img src="https://quickchart.io/chart?w=400&h=30&c={
  type: 'horizontalBar',
  data: {
    datasets: [
      {label:      'MODS:', data: [319.30]},
      {label: 'FML stuff:', data: [223.80]}
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
436e17  30.87s Had Enough Items;
3C6315  16.04s Had Enough Items (Plugins);
813e81  12.22s OpenComputers;
516fa8  11.47s Ender IO;
5161a8   1.13s CraftTweaker2;
495797   8.94s CraftTweaker2 (Script Loading);
a651a8   9.18s IndustrialCraft 2;
8f3087   8.91s Forge Mod Loader;
8f304e   6.83s Astral Sorcery;
cd922c   6.15s NuclearCraft;
214d9e   5.76s Minecraft Forge;
8c2ccd   5.76s Immersive Engineering;
6e175e   5.33s Recurrent Complex;
213664   5.09s Forestry;
538f30   4.16s Animania;
308f53   3.98s Village Names;
436e17   3.97s Integrated Dynamics;
a86e51   3.84s Extra Utilities 2;
8f4d30   3.72s Open Terrain Generator;
308f7e   3.55s Quark: RotN Edition;
176e43   3.42s Thaumic Additions: Reconstructed;
ba3eb8   3.40s Cyclic;
444444  88.52s 47 Other mods;
333333  60.13s 177 'Fast' mods (load 1.0s - 0.1s);
222222   6.94s 200 'Instant' mods (load %3C 0.1s)
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
OpenComputers         |  0.37|  0.02|  8.16|  3.45|  0.21|  0.00|  0.00|  0.00;
Ender IO              |  1.64|  0.01|  4.04|  0.58|  3.42|  0.78|  0.00|  1.00;
CraftTweaker2         |  0.68|  0.00|  4.34|  0.01|  0.00|  5.03|  0.01|  0.00;
IndustrialCraft 2     |  0.77|  0.02|  7.04|  0.91|  0.00|  0.43|  0.00|  0.00;
Astral Sorcery        |  0.23|  0.01|  4.43|  1.55|  0.00|  0.62|  0.00|  0.00;
NuclearCraft          |  0.53|  0.01|  4.09|  0.39|  0.00|  1.06|  0.00|  0.07;
Immersive Engineering |  0.90|  0.01|  1.16|  1.00|  0.00|  2.68|  0.00|  0.00;
Recurrent Complex     |  0.26|  0.01|  0.76|  1.10|  0.00|  3.20|  0.00|  0.00;
Forestry              |  0.48|  0.01|  3.31|  1.00|  0.00|  0.29|  0.00|  0.00;
Animania              |  0.31|  0.00|  3.27|  0.10|  0.00|  0.47|  0.00|  0.00;
Village Names         |  0.12|  0.00|  3.67|  0.19|  0.00|  0.00|  0.00|  0.00;
Integrated Dynamics   |  0.44|  0.01|  3.47|  0.05|  0.00|  0.00|  0.00|  0.00
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
  2.47: cofh.thermalexpansion.plugins.jei.JEIPluginTE;
  1.26: jeresources.jei.JEIConfig;
  1.20: com.github.sokyranthedragon.mia.integrations.jer.JeiJerIntegration$1;
  1.11: com.rwtema.extrautils2.crafting.jei.XUJEIPlugin;
  0.84: crazypants.enderio.machines.integration.jei.MachinesPlugin;
  0.77: ic2.jeiIntegration.SubModule;
  0.74: mezz.jei.plugins.vanilla.VanillaPlugin;
  0.65: knightminer.tcomplement.plugin.jei.JEIPlugin;
  0.57: nc.integration.jei.NCJEI;
  0.54: com.buuz135.thaumicjei.ThaumcraftJEIPlugin;
  0.48: com.buuz135.industrial.jei.JEICustomPlugin;
  0.40: crazypants.enderio.base.integration.jei.JeiPlugin;
  0.27: ninjabrain.gendustryjei.GendustryJEIPlugin;
  0.27: net.bdew.jeibees.BeesJEIPlugin;
  0.23: forestry.factory.recipes.jei.FactoryJeiPlugin;
  4.23: Other 127 Plugins
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
            text: [223.80,'s'].join(''),
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
993A00   1.62s Loading sounds;
994400   1.69s Loading Resource - SoundHandler;
994F00  44.62s ModelLoader: blocks;
995900  14.91s ModelLoader: items;
996300   9.36s ModelLoader: baking;
996D00   2.12s Applying remove recipe actions;
997700   0.15s Applying remove furnace recipe actions;
998200   0.83s Indexing ingredients;
998C00  15.11s Indexing ingredients;
444444 133.39s Other
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
