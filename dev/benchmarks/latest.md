## Minecraft load time benchmark

---

<p align="center" style="font-size:160%;">
MC total load time:<br>
260 sec
<br>
<sup><sub>(
4:20 min
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
        {label: 'Mixins\n', data: [28.00]},
        {label: 'Construction\n', data: [54.00]},
        {label: 'PreInit\n', data: [128.00]},
        {label: 'Init\n', data: [47.00]},
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
          value: 28,
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
516fa8  9.73s Ender IO;
455E8F  3.91s [VF ModelBake];
436e17  8.57s Had Enough Items;
395E14  5.64s [JEI Plugins];
5161a8  6.34s CraftTweaker2;
8f304e  6.14s Astral Sorcery;
a651a8  4.80s IndustrialCraft 2;
213664  3.66s Forestry;
1C2E55  1.01s [VF ModelBake];
813e81  3.89s OpenComputers;
cd922c  3.33s NuclearCraft;
6e175e  3.08s Recurrent Complex;
3e68ba  2.46s AE2 Unofficial Extended Life;
35589E  0.64s [VF ModelBake];
ba3eb8  2.16s Cyclic;
436e17  2.06s Integrated Dynamics;
308f7e  2.02s Quark: RotN Edition;
3e8160  1.97s The Twilight Forest;
306e8f  1.95s Custom Loading Screen;
a86e51  2.02s Extra Utilities 2;
444444 25.85s 18 Other mods;
333333 47.63s 149 'Fast' mods (1.0s - 0.1s);
222222  8.24s 313 'Instant' mods (%3C 0.1s)
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
Ender IO                      | 1.60| 0.01| 2.58| 0.27| 1.36| 0.00| 0.02| 3.91;
CraftTweaker2                 | 0.21| 0.00| 2.37| 3.72| 0.00| 0.04| 0.00| 0.00;
Astral Sorcery                | 0.16| 0.00| 5.07| 0.91| 0.00| 0.00| 0.00| 0.00;
IndustrialCraft 2             | 0.86| 0.01| 3.25| 0.68| 0.00| 0.00| 0.00| 0.00;
Forestry                      | 0.26| 0.01| 1.77| 0.61| 0.00| 0.00| 0.00| 1.01;
OpenComputers                 | 0.16| 0.01| 1.34| 1.80| 0.05| 0.00| 0.00| 0.26;
NuclearCraft                  | 0.05| 0.01| 2.46| 0.78| 0.00| 0.00| 0.03| 0.00;
Recurrent Complex             | 0.17| 0.00| 0.27| 2.64| 0.00| 0.00| 0.00| 0.00;
AE2 Unofficial Extended Life  | 0.06| 0.01| 1.26| 0.48| 0.01| 0.00| 0.00| 0.64;
Cyclic                        | 0.04| 0.01| 1.73| 0.38| 0.00| 0.00| 0.00| 0.00;
[Mod Average]                 | 0.06| 0.00| 0.14| 0.07| 0.00| 0.00| 0.00| 0.02
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
 0.82: jeresources.jei.JEIConfig;
 0.60: crazypants.enderio.machines.integration.jei.MachinesPlugin;
 0.57: com.rwtema.extrautils2.crafting.jei.XUJEIPlugin;
 0.52: com.buuz135.industrial.jei.JEICustomPlugin;
 0.41: mezz.jei.plugins.vanilla.VanillaPlugin;
 0.36: ic2.jeiIntegration.SubModule;
 0.29: knightminer.tcomplement.plugin.jei.JEIPlugin;
 0.16: cofh.thermalexpansion.plugins.jei.JEIPluginTE;
 0.16: crazypants.enderio.base.integration.jei.JeiPlugin;
 0.14: com.buuz135.thaumicjei.ThaumcraftJEIPlugin;
 0.09: ninjabrain.gendustryjei.GendustryJEIPlugin;
 0.08: net.bdew.jeibees.BeesJEIPlugin;
 1.43: Other
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
            text: '103.06s',
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
994400  1.46s Reloading;
002299  3.26s Loading Resource - AssetLibrary;
2C9900  3.28s Preloading 53295 textures;
229900  1.65s Texture loading;
039900  1.46s Texture mipmap and upload;
009911  7.30s Posting bake events;
00991C 32.30s Setting up dynamic models;
009926 32.38s Loading Resource - ModelManager;
00998C 33.08s Rendering Setup;
440099  1.30s XML Recipes;
4F0099  1.77s InterModComms;
990092 10.54s [VintageFix]: Texture search 69872 sprites;
990088  3.36s Preloaded 33705 sprites
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
