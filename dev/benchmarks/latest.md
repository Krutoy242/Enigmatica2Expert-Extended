## Minecraft load time benchmark

---

<p align="center" style="font-size:160%;">
MC total load time:<br>
271 sec
<br>
<sup><sub>(
4:31 min
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
        {label: 'Construction\n', data: [49.00]},
        {label: 'PreInit\n', data: [138.00]},
        {label: 'Init\n', data: [50.00]},
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
5161a8  7.69s CraftTweaker2;
8f304e  7.51s Astral Sorcery;
436e17  6.82s Had Enough Items;
395E14  1.41s [JEI Ingredient Filter];
395E14  6.03s [JEI Plugins];
813e81  6.00s OpenComputers;
516fa8  5.87s Ender IO;
a651a8  4.94s IndustrialCraft 2;
6e5e17  4.58s Tinkers' Antique;
5E5014  3.00s [TCon Textures];
cd922c  3.09s NuclearCraft;
213664  3.09s Forestry;
308f7e  2.34s Quark: RotN Edition;
216364  2.25s Thermal Expansion;
436e17  2.12s Integrated Dynamics;
ba3eb8  2.08s Cyclic;
a86e51  1.96s Extra Utilities 2;
3e8160  1.95s The Twilight Forest;
3e7d81  1.95s ProbeZS;
444444 28.97s 22 Other mods;
333333 42.14s 143 'Fast' mods (1.0s - 0.1s);
222222  7.70s 301 'Instant' mods (%3C 0.1s)
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
CraftTweaker2                 | 0.21| 0.00| 2.59| 4.84| 0.00| 0.05| 0.00| 0.00;
Astral Sorcery                | 0.17| 0.00| 5.91| 1.43| 0.00| 0.00| 0.00| 0.00;
OpenComputers                 | 0.13| 0.00| 4.20| 1.61| 0.05| 0.00| 0.00| 0.00;
Ender IO                      | 1.57| 0.00| 2.78| 0.26| 1.25| 0.00| 0.01| 0.00;
IndustrialCraft 2             | 1.07| 0.00| 3.25| 0.60| 0.00| 0.00| 0.00| 0.00;
Tinkers' Antique              | 0.83| 0.00| 0.11| 0.64| 0.00| 0.00| 0.00| 3.00;
NuclearCraft                  | 0.05| 0.00| 2.67| 0.34| 0.00| 0.00| 0.03| 0.00;
Forestry                      | 0.30| 0.00| 1.99| 0.79| 0.00| 0.00| 0.00| 0.00;
Quark: RotN Edition           | 0.03| 0.00| 2.20| 0.11| 0.00| 0.00| 0.00| 0.00;
Thermal Expansion             | 0.04| 0.00| 0.58| 1.59| 0.02| 0.00| 0.02| 0.00;
[Mod Average]                 | 0.06| 0.00| 0.15| 0.07| 0.00| 0.01| 0.00| 0.01
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
 1.60: jeresources.jei.JEIConfig;
 0.68: com.rwtema.extrautils2.crafting.jei.XUJEIPlugin;
 0.53: ic2.jeiIntegration.SubModule;
 0.48: crazypants.enderio.machines.integration.jei.MachinesPlugin;
 0.31: com.buuz135.industrial.jei.JEICustomPlugin;
 0.31: mezz.jei.plugins.vanilla.VanillaPlugin;
 0.18: cofh.thermalexpansion.plugins.jei.JEIPluginTE;
 0.16: crazypants.enderio.base.integration.jei.JeiPlugin;
 0.13: com.buuz135.thaumicjei.ThaumcraftJEIPlugin;
 0.09: crafttweaker.mods.jei.JEIAddonPlugin;
 0.09: net.bdew.jeibees.BeesJEIPlugin;
 0.09: ninjabrain.gendustryjei.GendustryJEIPlugin;
 1.40: Other
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

тЪая╕П Shows only steps that took 1.0 sec or more.

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
            text: '117.54s',
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
739900  1.11s Reloading;
001799  4.31s Loading Resource - AssetLibrary;
7D9900  6.21s Loading sounds;
739900  6.26s Loading Resource - SoundHandler;
369900  3.65s Preloading 50769 textures;
2C9900  2.12s Texture loading;
009907  4.57s Posting bake events;
009911 32.35s Setting up dynamic models;
00991C 32.42s Loading Resource - ModelManager;
009982 33.17s Rendering Setup;
300099  1.20s XML Recipes;
3A0099  1.68s InterModComms;
8C0099 13.56s [VintageFix]: Texture search 68429 sprites;
960099  3.83s Preloaded 33519 sprites
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
