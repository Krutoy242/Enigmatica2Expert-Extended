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
<img alt="Loading Timeline" src="https://quickchart.io/chart.png?w=400&h=60&c={
  type: 'horizontalBar',
  data: {
    datasets: [
        {label: 'Mixins\n', data: [48.00]},
        {label: 'Construction\n', data: [51.00]},
        {label: 'PreInit\n', data: [150.00]},
        {label: 'Init\n', data: [72.00]},
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
          value: 48,
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
<img alt="Mods Loading Time" src="https://quickchart.io/chart.png?w=400&h=300&c={
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
436e17 13.59s Had Enough Items;
395E14  8.52s [JEI Plugins];
5161a8  8.07s CraftTweaker2;
6a3eba  6.67s Ender IO CEu;
5A359E  1.65s [VF ModelBake];
213664  6.00s Forestry;
1C2E55  2.38s [VF ModelBake];
8f304e  5.59s Astral Sorcery;
cd922c  4.76s NuclearCraft;
a651a8  4.25s IndustrialCraft 2;
176e6e  4.12s Recurrent Complex Volts;
813e81  4.34s OpenComputers;
3e68ba  3.74s AE2 Unofficial Extended Life;
35589E  1.07s [VF ModelBake];
308f7e  2.84s Quark: RotN Edition;
3e8160  2.66s The Twilight Forest;
3e7d81  2.60s ProbeZS;
8c2ccd  2.59s Immersive Engineering;
8f4d30  2.49s Open Terrain Generator;
a86e51  2.57s Extra Utilities 2;
444444 51.64s 34 Other mods;
333333 49.54s 160 'Fast' mods (1.0s - 0.1s);
222222  8.29s 292 'Instant' mods (%3C 0.1s)
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
<img alt="Loader Steps" src="https://quickchart.io/chart.png?w=400&h=450&c={
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
CraftTweaker2                 | 0.21| 0.00| 3.16| 4.67| 0.00| 0.04| 0.00| 0.00;
Ender IO CEu                  | 0.92| 0.01| 2.37| 0.19| 1.51| 0.00| 0.02| 1.65;
Forestry                      | 0.36| 0.01| 2.17| 1.08| 0.00| 0.00| 0.00| 2.38;
Astral Sorcery                | 0.17| 0.00| 3.96| 1.46| 0.00| 0.00| 0.00| 0.00;
NuclearCraft                  | 0.05| 0.01| 3.28| 1.39| 0.00| 0.00| 0.04| 0.00;
IndustrialCraft 2             | 0.47| 0.01| 2.96| 0.82| 0.00| 0.00| 0.00| 0.00;
Recurrent Complex Volts       | 0.18| 0.00| 0.38| 3.55| 0.00| 0.00| 0.00| 0.00;
OpenComputers                 | 0.16| 0.01| 1.35| 1.93| 0.10| 0.00| 0.00| 0.40;
AE2 Unofficial Extended Life  | 0.08| 0.01| 1.58| 1.00| 0.01| 0.00| 0.00| 1.07;
Quark: RotN Edition           | 0.05| 0.01| 2.60| 0.18| 0.00| 0.00| 0.00| 0.00;
[Mod Average]                 | 0.07| 0.00| 0.17| 0.10| 0.00| 0.01| 0.00| 0.02
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
<img alt="TOP JEI Registered Plugis" src="https://quickchart.io/chart.png?w=500&h=200&c={
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
 1.42: crazypants.enderio.base.integration.jei.JeiPlugin;
 1.07: jeresources.jei.JEIConfig;
 0.74: mezz.jei.plugins.vanilla.VanillaPlugin;
 0.68: com.buuz135.industrial.jei.JEICustomPlugin;
 0.53: ic2.jeiIntegration.SubModule;
 0.52: com.rwtema.extrautils2.crafting.jei.XUJEIPlugin;
 0.41: crazypants.enderio.machines.integration.jei.MachinesPlugin;
 0.20: cofh.thermalexpansion.plugins.jei.JEIPluginTE;
 0.20: knightminer.tcomplement.plugin.jei.JEIPlugin;
 0.18: ninjabrain.gendustryjei.GendustryJEIPlugin;
 0.14: roidrole.thaumicinfo.HEIPlugin;
 0.13: thaumicenergistics.integration.jei.ThEJEI;
 2.29: Other
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
<img alt="FML Stuff" src="https://quickchart.io/chart.png?w=500&h=400&c={
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
            text: '125.39s',
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
994400  1.84s Reloading;
002C99  2.09s Loading Resource - AssetLibrary;
2C9900  5.11s Preloading 53515 textures;
229900  1.87s Texture loading;
009911  7.57s Posting bake events;
00991C 33.92s Setting up dynamic models;
009926 34.01s Loading Resource - ModelManager;
00998C 35.18s Rendering Setup;
440099  1.48s XML Recipes;
4F0099  2.12s InterModComms;
990700  1.42s Ender IO;
990040 10.72s [VintageFix]: Texture search 70383 sprites;
990036  5.20s Preloaded 33922 sprites
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
