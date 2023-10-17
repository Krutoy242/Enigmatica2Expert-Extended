## Minecraft load time benchmark


---

<p align="center" style="font-size:160%;">
MC total load time:<br>
620.36 sec
<br>
<sup><sub>(
10:20 min
)</sub></sup>
</p>

<br>


<p align="center">
<img src="https://quickchart.io/chart?w=400&h=30&c={
  type: 'horizontalBar',
  data: {
    datasets: [
      {label:      'MODS:', data: [369.90]},
      {label: 'FML stuff:', data: [250.46]}
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
436e17  32.81s Had Enough Items;
3C6315  17.75s Had Enough Items (Plugins);
516fa8  14.31s Ender IO;
813e81  13.65s OpenComputers;
5161a8  11.44s CraftTweaker2;
495797  12.29s CraftTweaker2 (Script Loading);
8f304e   7.86s Astral Sorcery;
cd922c   7.79s NuclearCraft;
5c308f   7.39s Mod Tweaker;
6e175e   7.23s Recurrent Complex;
a651a8   7.21s IndustrialCraft 2;
8f3087   7.01s Forge Mod Loader;
8c2ccd   6.86s Immersive Engineering;
213664   5.86s Forestry;
8f6c30   5.74s Dynamic Surroundings;
3e68ba   4.88s AE2 Unofficial Extended Life;
8f4d30   4.86s Open Terrain Generator;
176e43   4.68s Thaumic Additions: Reconstructed;
ba3eb8   4.58s Cyclic;
649e21   4.54s OpenBlocks;
308f53   4.49s Village Names;
a86e51   4.40s Extra Utilities 2;
444444 111.14s 52 Other mods;
333333  67.17s 188 'Fast' mods (load 1.0s - 0.1s);
222222   6.26s 189 'Instant' mods (load %3C 0.1s)
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
Ender IO                     |  1.80|  0.01|  4.43|  0.75|  4.40|  0.79|  0.00|  2.12;
OpenComputers                |  0.26|  0.02|  9.28|  3.81|  0.28|  0.00|  0.00|  0.00;
CraftTweaker2                |  0.66|  0.00|  5.07|  0.01|  0.00|  5.70|  0.01|  0.00;
Astral Sorcery               |  0.27|  0.01|  4.72|  1.94|  0.00|  0.93|  0.00|  0.00;
NuclearCraft                 |  0.91|  0.01|  4.82|  0.57|  0.00|  1.42|  0.00|  0.07;
Mod Tweaker                  |  0.01|  0.00|  0.01|  0.00|  0.00|  0.00|  7.38|  0.00;
Recurrent Complex            |  0.33|  0.00|  0.96|  0.95|  0.00|  4.99|  0.00|  0.00;
IndustrialCraft 2            |  0.80|  0.02|  5.13|  0.98|  0.00|  0.29|  0.00|  0.00;
Immersive Engineering        |  0.92|  0.02|  1.64|  1.16|  0.00|  3.14|  0.00|  0.00;
Forestry                     |  0.40|  0.02|  3.90|  1.09|  0.00|  0.45|  0.00|  0.00;
Dynamic Surroundings         |  0.96|  0.01|  0.29|  0.15|  0.00|  0.04|  4.30|  0.00;
AE2 Unofficial Extended Life |  0.14|  0.02|  3.79|  0.23|  0.06|  0.63|  0.00|  0.00
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
  3.07: cofh.thermalexpansion.plugins.jei.JEIPluginTE;
  1.40: com.rwtema.extrautils2.crafting.jei.XUJEIPlugin;
  1.36: jeresources.jei.JEIConfig;
  1.34: com.github.sokyranthedragon.mia.integrations.jer.JeiJerIntegration$1;
  0.91: mezz.jei.plugins.vanilla.VanillaPlugin;
  0.87: ic2.jeiIntegration.SubModule;
  0.76: crazypants.enderio.machines.integration.jei.MachinesPlugin;
  0.75: knightminer.tcomplement.plugin.jei.JEIPlugin;
  0.56: com.buuz135.thaumicjei.ThaumcraftJEIPlugin;
  0.53: com.buuz135.industrial.jei.JEICustomPlugin;
  0.51: nc.integration.jei.NCJEI;
  0.46: crazypants.enderio.base.integration.jei.JeiPlugin;
  0.28: ninjabrain.gendustryjei.GendustryJEIPlugin;
  0.28: forestry.factory.recipes.jei.FactoryJeiPlugin;
  0.24: net.bdew.jeibees.BeesJEIPlugin;
  4.45: Other 125 Plugins
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
            text: [250.46,'s'].join(''),
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
993A00   1.34s Loading sounds;
994400   1.41s Loading Resource - SoundHandler;
994F00  47.65s ModelLoader: blocks;
995900  19.04s ModelLoader: items;
996300  20.05s ModelLoader: baking;
996D00   2.41s Applying remove recipe actions;
997700   0.16s Applying remove furnace recipe actions;
998200   1.07s Indexing ingredients;
998C00   9.92s Indexing ingredients;
444444 147.41s Other
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
