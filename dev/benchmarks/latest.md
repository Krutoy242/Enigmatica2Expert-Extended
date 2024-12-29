## Minecraft load time benchmark


---

<p align="center" style="font-size:160%;">
MC total load time:<br>
254.33 sec
<br>
<sup><sub>(
4:14 min
)</sub></sup>
</p>

<br>


<p align="center">
<img src="https://quickchart.io/chart?w=400&h=30&c={
  type: 'horizontalBar',
  data: {
    datasets: [
      {label:      'MODS:', data: [101.72]},
      {label: 'FML stuff:', data: [152.61]}
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
8f304e   5.30s Astral Sorcery;
813e81   4.82s OpenComputers;
a651a8   4.40s IndustrialCraft 2;
516fa8   4.14s Ender IO;
5161a8   2.83s CraftTweaker2;
495797   7.08s CraftTweaker2 (Script Loading);
213664   2.74s Forestry;
cd922c   2.42s NuclearCraft;
436e17   1.93s Integrated Dynamics;
308f7e   1.89s Quark: RotN Edition;
ba3eb8   1.88s Cyclic;
5a352c   1.86s Shadowfacts' Forgelin;
3e8160   1.85s The Twilight Forest;
a86e51   1.82s Extra Utilities 2;
3eb2ba   1.50s Botania;
8c2ccd   1.47s Immersive Engineering;
8f4d30   1.38s Open Terrain Generator;
3e68ba   1.30s AE2 Unofficial Extended Life;
649e21   1.30s OpenBlocks;
61176e   1.26s Ice and Fire;
814a3e   1.19s RFTools;
444444   8.76s 8 Other mods;
333333  37.25s 129 'Fast' mods (load 1.0s - 0.1s);
222222   8.44s 304 'Instant' mods (load %3C 0.1s)
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
Astral Sorcery        |  0.15|  0.00|  4.65|  0.50|  0.00|  0.00|  0.00|  0.00;
OpenComputers         |  0.13|  0.01|  3.29|  1.40|  0.00|  0.00|  0.00|  0.00;
IndustrialCraft 2     |  0.71|  0.00|  3.18|  0.51|  0.00|  0.00|  0.00|  0.00;
Ender IO              |  1.28|  0.00|  2.68|  0.18|  0.00|  0.00|  0.00|  0.00;
CraftTweaker2         |  0.09|  0.00|  2.74|  0.00|  0.00|  0.00|  0.00|  0.00;
Forestry              |  0.54|  0.00|  1.83|  0.36|  0.00|  0.00|  0.00|  0.00;
NuclearCraft          |  0.04|  0.00|  2.24|  0.14|  0.00|  0.00|  0.00|  0.00;
Integrated Dynamics   |  0.13|  0.00|  1.77|  0.03|  0.00|  0.00|  0.00|  0.00;
Quark: RotN Edition   |  0.02|  0.00|  1.82|  0.05|  0.00|  0.00|  0.00|  0.00;
Cyclic                |  0.03|  0.00|  1.53|  0.32|  0.00|  0.00|  0.00|  0.00;
Shadowfacts' Forgelin |  1.85|  0.00|  0.01|  0.00|  0.00|  0.00|  0.00|  0.00;
The Twilight Forest   |  0.66|  0.00|  1.10|  0.09|  0.00|  0.00|  0.00|  0.00
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
  1.33: jeresources.jei.JEIConfig;
  0.57: com.rwtema.extrautils2.crafting.jei.XUJEIPlugin;
  0.56: ic2.jeiIntegration.SubModule;
  0.47: crazypants.enderio.machines.integration.jei.MachinesPlugin;
  0.44: com.buuz135.industrial.jei.JEICustomPlugin;
  0.38: mezz.jei.plugins.vanilla.VanillaPlugin;
  0.21: com.warmthdawn.justenoughdrags.jei.JEIPlugin;
  0.19: knightminer.tcomplement.plugin.jei.JEIPlugin;
  0.16: com.buuz135.thaumicjei.ThaumcraftJEIPlugin;
  0.14: cofh.thermalexpansion.plugins.jei.JEIPluginTE;
  0.14: crazypants.enderio.base.integration.jei.JeiPlugin;
  0.08: ninjabrain.gendustryjei.GendustryJEIPlugin;
  0.08: zzzank.mod.jei_area_fixer.JEIAreaFixerJEIPlugin;
  0.08: net.bdew.jeibees.BeesJEIPlugin;
  0.06: crafttweaker.mods.jei.JEIAddonPlugin;
  1.11: Other 126 Plugins
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
            text: [152.61,'s'].join(''),
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
993A00   7.38s Loading sounds;
994400   7.44s Loading Resource - SoundHandler;
444444 137.79s Other
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
