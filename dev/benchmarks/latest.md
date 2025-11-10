## Minecraft load time benchmark

---

<p align="center" style="font-size:160%;">
MC total load time:<br>
306 sec
<br>
<sup><sub>(
5:06 min
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
        {label: 'Mixins\n', data: [35.00]},
        {label: 'Construction\n', data: [72.00]},
        {label: 'PreInit\n', data: [134.00]},
        {label: 'Init\n', data: [62.00]},
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
          value: 35,
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
436e17  8.72s Had Enough Items;
395E14  1.48s [JEI Ingredient Filter];
395E14  8.96s [JEI Plugins];
516fa8  8.11s Ender IO;
5161a8  7.81s CraftTweaker2;
8f304e  6.83s Astral Sorcery;
a651a8  5.57s IndustrialCraft 2;
6e5e17  4.87s Tinkers' Antique;
5E5014  3.00s [TCon Textures];
cd922c  3.78s NuclearCraft;
813e81  3.60s OpenComputers;
213664  3.48s Forestry;
6e175e  3.18s Recurrent Complex;
306e8f  2.75s Custom Loading Screen;
436e17  2.42s Integrated Dynamics;
3e8160  2.40s The Twilight Forest;
308f7e  2.30s Quark: RotN Edition;
216364  2.27s Thermal Expansion;
8c2ccd  2.26s Immersive Engineering;
444444 37.73s 24 Other mods;
333333 48.94s 150 'Fast' mods (1.0s - 0.1s);
222222  8.09s 290 'Instant' mods (%3C 0.1s)
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
Ender IO                      | 2.99| 0.01| 3.15| 0.35| 1.61| 0.00| 0.01| 0.00;
CraftTweaker2                 | 0.13| 0.00| 2.77| 4.85| 0.00| 0.06| 0.00| 0.00;
Astral Sorcery                | 0.32| 0.00| 4.95| 1.56| 0.00| 0.00| 0.00| 0.00;
IndustrialCraft 2             | 1.08| 0.01| 3.61| 0.87| 0.00| 0.00| 0.00| 0.00;
Tinkers' Antique              | 0.92| 0.01| 0.12| 0.83| 0.00| 0.00| 0.00| 3.00;
NuclearCraft                  | 0.05| 0.01| 2.81| 0.88| 0.00| 0.00| 0.03| 0.00;
OpenComputers                 | 0.16| 0.01| 1.62| 1.75| 0.06| 0.00| 0.00| 0.00;
Forestry                      | 0.34| 0.04| 2.30| 0.80| 0.00| 0.00| 0.00| 0.00;
Recurrent Complex             | 0.19| 0.00| 0.30| 2.69| 0.00| 0.00| 0.00| 0.00;
Custom Loading Screen         | 2.75| 0.00| 0.00| 0.00| 0.00| 0.00| 0.00| 0.00;
[Mod Average]                 | 0.08| 0.00| 0.16| 0.09| 0.00| 0.01| 0.00| 0.01
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
 1.71: li.cil.oc.integration.jei.ModPluginOpenComputers;
 1.29: jeresources.jei.JEIConfig;
 0.71: com.rwtema.extrautils2.crafting.jei.XUJEIPlugin;
 0.66: ic2.jeiIntegration.SubModule;
 0.57: mezz.jei.plugins.vanilla.VanillaPlugin;
 0.56: com.buuz135.industrial.jei.JEICustomPlugin;
 0.48: crazypants.enderio.machines.integration.jei.MachinesPlugin;
 0.21: com._0xc4de.ae2exttable.integration.JEIPlugin;
 0.21: cofh.thermalexpansion.plugins.jei.JEIPluginTE;
 0.18: com.buuz135.thaumicjei.ThaumcraftJEIPlugin;
 0.17: knightminer.tcomplement.plugin.jei.JEIPlugin;
 0.17: rustic.compat.jei.RusticJEIPlugin;
 2.03: Other
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
            text: '127.97s',
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
994400  1.70s Reloading;
001799  2.81s Loading Resource - AssetLibrary;
229900  3.35s Preloading 50967 textures;
179900  1.48s Texture loading;
009907  1.07s Texture mipmap and upload;
00991C  4.83s Posting bake events;
009926 31.06s Setting up dynamic models;
009930 31.12s Loading Resource - ModelManager;
009996 31.98s Rendering Setup;
440099  1.54s XML Recipes;
4F0099  2.08s InterModComms;
990088 12.47s [VintageFix]: Texture search 68584 sprites;
99007D  3.42s Preloaded 33219 sprites
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
