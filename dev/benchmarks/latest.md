## Minecraft load time benchmark

---

<p align="center" style="font-size:160%;">
MC total load time:<br>
293 sec
<br>
<sup><sub>(
4:53 min
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
        {label: 'Mixins\n', data: [30.00]},
        {label: 'Construction\n', data: [67.00]},
        {label: 'PreInit\n', data: [134.00]},
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
          value: 30,
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
436e17  8.55s Had Enough Items;
395E14  0.98s [JEI Ingredient Filter];
395E14  9.12s [JEI Plugins];
516fa8  7.70s Ender IO;
5161a8  7.36s CraftTweaker2;
6e5e17  5.97s Tinkers' Antique;
5E5014  4.00s [TCon Textures];
a651a8  5.57s IndustrialCraft 2;
8f304e  5.52s Astral Sorcery;
cd922c  3.91s NuclearCraft;
813e81  3.33s OpenComputers;
6e175e  3.21s Recurrent Complex;
213664  3.15s Forestry;
813e80  2.86s Shadowfacts' Forgelin (Dummy);
3e8160  2.55s The Twilight Forest;
308f7e  2.45s Quark: RotN Edition;
ba3eb8  2.43s Cyclic;
436e17  2.36s Integrated Dynamics;
216364  2.33s Thermal Expansion;
444444 39.29s 25 Other mods;
333333 48.35s 153 'Fast' mods (1.0s - 0.1s);
222222  8.26s 290 'Instant' mods (%3C 0.1s)
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
Ender IO                      | 2.48| 0.01| 2.98| 0.32| 1.88| 0.00| 0.03| 0.00;
CraftTweaker2                 | 0.10| 0.00| 2.51| 4.70| 0.00| 0.05| 0.00| 0.00;
Tinkers' Antique              | 0.94| 0.01| 0.13| 0.90| 0.00| 0.00| 0.00| 4.00;
IndustrialCraft 2             | 0.93| 0.01| 3.84| 0.80| 0.00| 0.00| 0.00| 0.00;
Astral Sorcery                | 0.18| 0.00| 4.22| 1.12| 0.00| 0.00| 0.00| 0.00;
NuclearCraft                  | 0.07| 0.01| 2.90| 0.90| 0.00| 0.00| 0.03| 0.00;
OpenComputers                 | 0.14| 0.01| 1.46| 1.58| 0.15| 0.00| 0.00| 0.00;
Recurrent Complex             | 0.20| 0.00| 0.32| 2.69| 0.00| 0.00| 0.00| 0.00;
Forestry                      | 0.34| 0.01| 2.12| 0.68| 0.00| 0.00| 0.00| 0.00;
Shadowfacts' Forgelin (Dummy) | 2.85| 0.00| 0.01| 0.00| 0.00| 0.00| 0.00| 0.00;
[Mod Average]                 | 0.08| 0.00| 0.16| 0.08| 0.01| 0.00| 0.00| 0.01
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
 1.81: li.cil.oc.integration.jei.ModPluginOpenComputers;
 1.11: jeresources.jei.JEIConfig;
 0.92: com.rwtema.extrautils2.crafting.jei.XUJEIPlugin;
 0.78: ic2.jeiIntegration.SubModule;
 0.58: com.buuz135.industrial.jei.JEICustomPlugin;
 0.54: crazypants.enderio.machines.integration.jei.MachinesPlugin;
 0.50: mezz.jei.plugins.vanilla.VanillaPlugin;
 0.26: lach_01298.qmd.jei.QMDJEI;
 0.19: cofh.thermalexpansion.plugins.jei.JEIPluginTE;
 0.19: com.buuz135.thaumicjei.ThaumcraftJEIPlugin;
 0.18: knightminer.tcomplement.plugin.jei.JEIPlugin;
 0.18: crazypants.enderio.base.integration.jei.JeiPlugin;
 1.88: Other
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
            text: '113.81s',
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
994400  1.52s Reloading;
001799  2.36s Loading Resource - AssetLibrary;
369900  1.09s CCL ModelLoading: Blocks;
229900  3.45s Preloading 50988 textures;
179900  1.71s Texture loading;
00991C  4.82s Posting bake events;
009926 31.23s Setting up dynamic models;
009930 31.29s Loading Resource - ModelManager;
009996 32.05s Rendering Setup;
440099  1.83s XML Recipes;
4F0099  2.48s InterModComms;
990055 12.37s [VintageFix]: Texture search 69073 sprites;
99004A  3.62s Preloaded 33240 sprites
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
