## Minecraft load time benchmark

---

<p align="center" style="font-size:160%;">
MC total load time:<br>
311 sec
<br>
<sup><sub>(
5:11 min
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
        {label: 'Mixins\n', data: [31.00]},
        {label: 'Construction\n', data: [69.00]},
        {label: 'PreInit\n', data: [146.00]},
        {label: 'Init\n', data: [63.00]},
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
          value: 31,
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
8f304e 12.26s Astral Sorcery;
436e17  9.49s Had Enough Items;
395E14  1.32s [JEI Ingredient Filter];
395E14  8.18s [JEI Plugins];
5161a8  8.41s CraftTweaker2;
516fa8  6.91s Ender IO;
cd922c  6.84s NuclearCraft;
a651a8  6.04s IndustrialCraft 2;
6e5e17  4.75s Tinkers' Antique;
5E5014  3.00s [TCon Textures];
213664  4.36s Forestry;
6e175e  4.19s Recurrent Complex;
813e81  3.99s OpenComputers;
3e7d81  3.30s ProbeZS;
813e80  2.92s Shadowfacts' Forgelin (Dummy);
436e17  2.80s Integrated Dynamics;
306e8f  2.51s Custom Loading Screen;
308f7e  2.35s Quark: RotN Edition;
ba3eb8  2.32s Cyclic;
444444 39.51s 26 Other mods;
333333 47.33s 151 'Fast' mods (1.0s - 0.1s);
222222  7.83s 290 'Instant' mods (%3C 0.1s)
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
Astral Sorcery                | 0.18| 0.00|10.75| 1.33| 0.00| 0.00| 0.00| 0.00;
CraftTweaker2                 | 0.22| 0.00| 3.26| 4.87| 0.00| 0.06| 0.00| 0.00;
Ender IO                      | 1.48| 0.01| 3.50| 0.41| 1.51| 0.00| 0.01| 0.00;
NuclearCraft                  | 0.06| 0.01| 5.72| 1.02| 0.00| 0.00| 0.03| 0.00;
IndustrialCraft 2             | 1.26| 0.01| 4.00| 0.77| 0.00| 0.00| 0.00| 0.00;
Tinkers' Antique              | 0.87| 0.01| 0.12| 0.75| 0.00| 0.00| 0.00| 3.00;
Forestry                      | 1.16| 0.01| 2.55| 0.64| 0.00| 0.00| 0.00| 0.00;
Recurrent Complex             | 0.21| 0.00| 0.36| 3.61| 0.00| 0.00| 0.00| 0.00;
OpenComputers                 | 0.17| 0.01| 1.54| 2.21| 0.05| 0.00| 0.00| 0.00;
ProbeZS                       | 0.03| 0.00| 0.04| 3.23| 0.00| 0.00| 0.00| 0.00;
[Mod Average]                 | 0.08| 0.00| 0.18| 0.09| 0.00| 0.01| 0.00| 0.01
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
 1.60: li.cil.oc.integration.jei.ModPluginOpenComputers;
 1.04: jeresources.jei.JEIConfig;
 0.76: com.rwtema.extrautils2.crafting.jei.XUJEIPlugin;
 0.56: com.buuz135.industrial.jei.JEICustomPlugin;
 0.50: mezz.jei.plugins.vanilla.VanillaPlugin;
 0.50: crazypants.enderio.machines.integration.jei.MachinesPlugin;
 0.39: ic2.jeiIntegration.SubModule;
 0.22: com.glodblock.github.integration.jei.FCJeiPlugin;
 0.20: crazypants.enderio.base.integration.jei.JeiPlugin;
 0.17: com.buuz135.thaumicjei.ThaumcraftJEIPlugin;
 0.17: cofh.thermalexpansion.plugins.jei.JEIPluginTE;
 0.16: rustic.compat.jei.RusticJEIPlugin;
 1.92: Other
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
            text: '120.90s',
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
994400  1.64s Reloading;
001799  8.40s Loading Resource - AssetLibrary;
229900  3.55s Preloading 51456 textures;
179900  1.64s Texture loading;
009907  2.54s Texture mipmap and upload;
00991C  4.57s Posting bake events;
009926 34.42s Setting up dynamic models;
009930 34.51s Loading Resource - ModelManager;
009996 35.39s Rendering Setup;
440099  1.46s XML Recipes;
4F0099  1.98s InterModComms;
99007D 14.82s [VintageFix]: Texture search 69577 sprites;
990073  3.66s Preloaded 33708 sprites
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
