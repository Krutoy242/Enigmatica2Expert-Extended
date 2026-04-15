## Minecraft load time benchmark

---

<p align="center" style="font-size:160%;">
MC total load time:<br>
325 sec
<br>
<sup><sub>(
5:25 min
)</sub></sup>
</p>

<br>
<!--
Note for image scripts:
  - Newlines are ignored
  - This characters cant be used: +<"%#
-->
<p align="center">
<img src="https://quickchart.io/chart.png?w=400&h=60&c={
  type: 'horizontalBar',
  data: {
    datasets: [
        {label: 'Mixins\n', data: [36.00]},
        {label: 'Construction\n', data: [66.00]},
        {label: 'PreInit\n', data: [162.00]},
        {label: 'Init\n', data: [58.00]},
    ]
  },
  options: {
    layout: { padding: { top: 10 } },
    scales: {
      xAxes: [{display: false, stacked: true}],
      yAxes: [{display: false, stacked: true}],
    },
    elements: {rectangle: {borderWidth: 2}},
    legend: {display: false},
    plugins: {datalabels: {
      color: 'white',
      font: {
        family: 'Consolas',
      },
      formatter: (value, context) =>
        [context.dataset.label, value, 's'].join('')
    }},
    annotation: {
      clip: false,
      annotations: [{
          type: 'line',
          scaleID: 'x-axis-0',
          value: 36,
          borderColor: 'black',
          label: {
            content: 'Window appear',
            fontSize: 8,
            enabled: true,
            xPadding: 8, yPadding: 2,
            yAdjust: -20
          },
        }
      ]
    },
  }
}"/>
</p>

<br>

# Mods Loading Time

<p align="center">
<img src="https://quickchart.io/chart.png?w=400&h=300&c={
  type: 'outlabeledPie',
  options: {
    rotation: Math.PI,
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
516fa8 14.06s Ender IO;
8f304e 11.45s Astral Sorcery;
436e17  9.70s Had Enough Items;
395E14  1.13s [JEI Ingredient Filter];
395E14  8.54s [JEI Plugins];
5161a8  8.26s CraftTweaker2;
a651a8  7.18s IndustrialCraft 2;
6e5e17  4.75s Tinkers' Antique;
5E5014  3.00s [TCon Textures];
213664  4.01s Forestry;
cd922c  3.73s NuclearCraft;
813e81  3.66s OpenComputers;
6e175e  3.42s Recurrent Complex;
308f7e  3.32s Quark: RotN Edition;
ba3eb8  3.06s Cyclic;
3e7d81  2.86s ProbeZS;
3e8160  2.65s The Twilight Forest;
3e68ba  2.57s AE2 Unofficial Extended Life;
8c2ccd  2.48s Immersive Engineering;
444444 41.33s 24 Other mods;
333333 55.81s 166 'Fast' mods (1.0s - 0.1s);
222222  7.58s 287 'Instant' mods (%3C 0.1s)
`
    .split(';').reduce((a, l) => {
      l.match(/(\w{6}) *(\d*\.\d*) ?s (.*)/s)
      .slice(1).map((a, i) => [[String.fromCharCode(35),a].join(''), a,
        a.length > 15 ? a.split(/(?%3C=.{9})\s(?=\S{5})/).join('\n') : a
      ][i])
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

# Loader steps

Show how much time each mod takes on each game load phase.

JEI/HEI not included, since its load time based on other mods and overal item count.

<p align="center">
<img src="https://quickchart.io/chart.png?w=400&h=450&c={
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
0: Construction;
1: Loading Resources;
2: PreInitialization;
3: Initialization;
4: InterModComms;
5: LoadComplete;
6: ModIdMapping;
7: Other
`
    .split(';')
      .map(l => l.match(/\d: (.*)/).slice(1))
      .forEach(([name]) => a.datasets.push({ label: name, data: [] }));
`
                                  0      1      2      3      4      5      6      7;
Ender IO                      | 2.57| 0.01| 9.70| 0.29| 1.45| 0.00| 0.04| 0.00;
Astral Sorcery                | 0.18| 0.00|10.17| 1.10| 0.00| 0.00| 0.00| 0.00;
CraftTweaker2                 | 0.12| 0.00| 3.53| 4.56| 0.00| 0.05| 0.00| 0.00;
IndustrialCraft 2             | 0.96| 0.01| 5.49| 0.72| 0.00| 0.00| 0.00| 0.00;
Tinkers' Antique              | 1.06| 0.01| 0.14| 0.54| 0.00| 0.00| 0.00| 3.00;
Forestry                      | 0.57| 0.01| 2.72| 0.71| 0.00| 0.00| 0.00| 0.00;
NuclearCraft                  | 0.06| 0.01| 2.77| 0.85| 0.00| 0.00| 0.04| 0.00;
OpenComputers                 | 0.14| 0.01| 1.85| 1.60| 0.06| 0.00| 0.00| 0.00;
Recurrent Complex             | 0.21| 0.01| 0.31| 2.89| 0.00| 0.00| 0.00| 0.00;
Quark: RotN Edition           | 0.02| 0.01| 3.19| 0.10| 0.00| 0.00| 0.00| 0.00;
[Mod Average]                 | 0.08| 0.00| 0.22| 0.08| 0.00| 0.01| 0.00| 0.01
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
<img src="https://quickchart.io/chart.png?w=500&h=200&c={
  options: {
    elements: { rectangle: { borderWidth: 1 } },
    legend: false,
    scales: {
      yAxes: [{ ticks: { fontSize: 9, fontFamily: 'Verdana' }}],
    },
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
 1.86: li.cil.oc.integration.jei.ModPluginOpenComputers;
 0.98: jeresources.jei.JEIConfig;
 0.83: com.buuz135.industrial.jei.JEICustomPlugin;
 0.50: ic2.jeiIntegration.SubModule;
 0.49: mezz.jei.plugins.vanilla.VanillaPlugin;
 0.49: com.rwtema.extrautils2.crafting.jei.XUJEIPlugin;
 0.48: crazypants.enderio.machines.integration.jei.MachinesPlugin;
 0.34: knightminer.tcomplement.plugin.jei.JEIPlugin;
 0.26: cofh.thermalexpansion.plugins.jei.JEIPluginTE;
 0.17: com.buuz135.thaumicjei.ThaumcraftJEIPlugin;
 0.14: crazypants.enderio.base.integration.jei.JeiPlugin;
 0.14: net.bdew.jeibees.BeesJEIPlugin;
 1.87: Other
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

Loading bars that usually not related to specific mods.

⚠️ Shows only steps that took 1.0 sec or more.

<p align="center">
<img src="https://quickchart.io/chart.png?w=500&h=400&c={
  options: {
    rotation: Math.PI*1.125,
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
            text: '121.41s',
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
994400  1.77s Reloading;
001799  7.82s Loading Resource - AssetLibrary;
179900  3.30s Preloading 53291 textures;
0D9900  1.68s Texture loading;
009926  4.38s Posting bake events;
009930 29.15s Setting up dynamic models;
00993A 29.22s Loading Resource - ModelManager;
009299 30.19s Rendering Setup;
590099  1.39s XML Recipes;
630099  1.91s InterModComms;
99007D 12.14s [VintageFix]: Texture search 69863 sprites;
990073  3.41s Preloaded 33701 sprites
`
    .split(';')
      .map(l => l.match(/(\w{6}) *(\d*\.\d*) ?s (.*)/s))
      .forEach(([, col, time, name]) => {
        a.labels.push([
          name.length > 15 ? name.split(/(?%3C=.{11})\s(?=\S{6})/).join('\n') : name
          , ' ', time, 's'
        ].join(''));
        a.datasets[0].data.push(parseFloat(time));
        a.datasets[0].backgroundColor.push([String.fromCharCode(35), col].join(''))
      })
      ; return a
  })()}
}"/>
</p>
